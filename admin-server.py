#!/usr/bin/env python3
"""
Matrix Lab Admin Server - Production Ready
A Flask-based admin server for managing publications data
"""

import os
import yaml
import json
import subprocess
import threading
from flask import Flask, request, jsonify
from flask_cors import CORS
from functools import wraps
import logging

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

app = Flask(__name__, static_folder='.', static_url_path='')
app.config['SECRET_KEY'] = 'matrixlab-production-secret-2025'

# Enable CORS for all routes
CORS(app, origins=['http://140.143.183.163', 'http://localhost:3001', 'http://127.0.0.1:3001', 'http://localhost', 'http://127.0.0.1','https://matrixlab.work'])

# Configuration
PUBLICATIONS_FILE = os.path.join(os.path.dirname(__file__), '_data', 'publications.yml')
ADMIN_CREDENTIALS = {
    'username': 'admin',
    'password': 'matrixlab2025'
}

def load_publications():
    """Load publications from YAML file"""
    try:
        with open(PUBLICATIONS_FILE, 'r', encoding='utf-8') as file:
            return yaml.safe_load(file) or []
    except FileNotFoundError:
        logger.warning("Publications file not found, creating empty list")
        return []
    except Exception as e:
        logger.error(f"Error loading publications: {e}")
        return []

def rebuild_site():
    """Rebuild Jekyll site in background"""
    def build():
        try:
            logger.info("Starting Jekyll build...")
            result = subprocess.run(
                ['jekyll', 'build'],
                cwd=os.path.dirname(__file__),
                capture_output=True,
                text=True,
                timeout=30
            )
            if result.returncode == 0:
                logger.info("Jekyll build completed successfully")
            else:
                logger.error(f"Jekyll build failed: {result.stderr}")
        except Exception as e:
            logger.error(f"Error during Jekyll build: {e}")
    
    # Run build in background thread
    thread = threading.Thread(target=build)
    thread.daemon = True
    thread.start()

def save_publications(publications):
    """Save publications to YAML file and trigger site rebuild"""
    try:
        # Ensure directory exists
        os.makedirs(os.path.dirname(PUBLICATIONS_FILE), exist_ok=True)
        
        with open(PUBLICATIONS_FILE, 'w', encoding='utf-8') as file:
            yaml.dump(publications, file, default_flow_style=False, allow_unicode=True, encoding='utf-8')
        
        # Trigger automatic rebuild
        logger.info("Publications saved, triggering site rebuild...")
        rebuild_site()
        
        return True
    except Exception as e:
        logger.error(f"Error saving publications: {e}")
        return False

def authenticate(f):
    """Authentication decorator"""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        auth_header = request.headers.get('Authorization')
        
        if not auth_header or not auth_header.startswith('Bearer '):
            return jsonify({'error': 'Unauthorized - No token provided'}), 401
        
        token = auth_header[7:]  # Remove 'Bearer ' prefix
        
        # In production, this would validate JWT tokens
        if token != 'matrixlab2025':
            return jsonify({'error': 'Unauthorized - Invalid token'}), 401
        
        return f(*args, **kwargs)
    return decorated_function

@app.route('/api/publications', methods=['GET'])
def get_publications():
    """Get all publications"""
    try:
        publications = load_publications()
        return jsonify(publications)
    except Exception as e:
        logger.error(f"Error getting publications: {e}")
        return jsonify({'error': 'Failed to load publications'}), 500

@app.route('/api/publications', methods=['POST'])
@authenticate
def add_publication():
    """Add a new publication"""
    try:
        data = request.get_json()
        
        # Validate required fields
        required_fields = ['title', 'url', 'authors', 'year']
        for field in required_fields:
            if not data.get(field):
                return jsonify({'error': f'Missing required field: {field}'}), 400
        
        publications = load_publications()
        
        # Create new publication
        new_publication = {
            'title': data['title'],
            'url': data['url'],
            'authors': data['authors'],
            'year': str(data['year'])
        }
        
        # Add optional fields
        if data.get('journal'):
            new_publication['journal'] = data['journal']
        if data.get('conference'):
            new_publication['conference'] = data['conference']
        if data.get('citations'):
            new_publication['citations'] = str(data['citations'])
        
        # Add to beginning of list (most recent first)
        publications.insert(0, new_publication)
        
        if save_publications(publications):
            logger.info(f"Added new publication: {data['title']}")
            return jsonify({'success': True, 'publication': new_publication})
        else:
            return jsonify({'error': 'Failed to save publication'}), 500
            
    except Exception as e:
        logger.error(f"Error adding publication: {e}")
        return jsonify({'error': 'Failed to add publication'}), 500

@app.route('/api/publications/<int:index>', methods=['PUT'])
@authenticate
def update_publication(index):
    """Update an existing publication"""
    try:
        data = request.get_json()
        publications = load_publications()
        
        if index < 0 or index >= len(publications):
            return jsonify({'error': 'Publication not found'}), 404
        
        # Update publication
        publications[index] = {
            'title': data['title'],
            'url': data['url'],
            'authors': data['authors'],
            'year': str(data['year'])
        }
        
        # Add optional fields
        if data.get('journal'):
            publications[index]['journal'] = data['journal']
        if data.get('conference'):
            publications[index]['conference'] = data['conference']
        if data.get('citations'):
            publications[index]['citations'] = str(data['citations'])
        
        if save_publications(publications):
            logger.info(f"Updated publication at index {index}: {data['title']}")
            return jsonify({'success': True, 'publication': publications[index]})
        else:
            return jsonify({'error': 'Failed to update publication'}), 500
            
    except Exception as e:
        logger.error(f"Error updating publication: {e}")
        return jsonify({'error': 'Failed to update publication'}), 500

@app.route('/api/publications/<int:index>', methods=['DELETE'])
@authenticate
def delete_publication(index):
    """Delete a publication"""
    try:
        publications = load_publications()
        
        if index < 0 or index >= len(publications):
            return jsonify({'error': 'Publication not found'}), 404
        
        deleted_publication = publications.pop(index)
        
        if save_publications(publications):
            logger.info(f"Deleted publication: {deleted_publication['title']}")
            return jsonify({'success': True, 'publication': deleted_publication})
        else:
            return jsonify({'error': 'Failed to delete publication'}), 500
            
    except Exception as e:
        logger.error(f"Error deleting publication: {e}")
        return jsonify({'error': 'Failed to delete publication'}), 500

@app.route('/api/login', methods=['POST'])
def login():
    """User login endpoint"""
    try:
        data = request.get_json()
        
        if not data or 'username' not in data or 'password' not in data:
            return jsonify({'error': 'Username and password required'}), 400
        
        if (data['username'] == ADMIN_CREDENTIALS['username'] and 
            data['password'] == ADMIN_CREDENTIALS['password']):
            
            logger.info(f"Successful login for user: {data['username']}")
            return jsonify({
                'success': True,
                'token': 'matrixlab2025',  # In production, generate JWT
                'message': 'Login successful'
            })
        else:
            logger.warning(f"Failed login attempt for user: {data['username']}")
            return jsonify({'error': 'Invalid credentials'}), 401
            
    except Exception as e:
        logger.error(f"Login error: {e}")
        return jsonify({'error': 'Login failed'}), 500

@app.route('/api/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    return jsonify({'status': 'healthy', 'service': 'Matrix Lab Admin API'})

if __name__ == '__main__':
    # Check if publications file exists, create if not
    if not os.path.exists(PUBLICATIONS_FILE):
        logger.info("Creating initial publications file")
        save_publications([])
    
    logger.info("Starting Matrix Lab Admin Server...")
    logger.info(f"Server running on http://localhost:3003")
    logger.info(f"Admin panel: http://localhost:3003/admin.html")
    logger.info(f"Health check: http://localhost:3003/api/health")
    
    app.run(host='0.0.0.0', port=3003, debug=False)
