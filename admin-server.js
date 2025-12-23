const fs = require('fs');
const path = require('path');
const express = require('express');
const bodyParser = require('body-parser');
const yaml = require('js-yaml');

const app = express();
const PORT = 3003;

// Middleware
app.use(bodyParser.json());
app.use(express.static('.'));

// Simple authentication middleware
const authenticate = (req, res, next) => {
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
        return res.status(401).json({ error: 'Unauthorized' });
    }
    
    const token = authHeader.substring(7);
    // In production, use proper JWT tokens
    if (token !== 'matrixlab2025') {
        return res.status(401).json({ error: 'Invalid token' });
    }
    
    next();
};

// Get publications
app.get('/api/publications', (req, res) => {
    try {
        const publicationsPath = path.join(__dirname, '_data', 'publications.yml');
        const publicationsData = fs.readFileSync(publicationsPath, 'utf8');
        const publications = yaml.load(publicationsData);
        res.json(publications);
    } catch (error) {
        res.status(500).json({ error: 'Failed to load publications' });
    }
});

// Add publication
app.post('/api/publications', authenticate, (req, res) => {
    try {
        const publicationsPath = path.join(__dirname, '_data', 'publications.yml');
        const publicationsData = fs.readFileSync(publicationsPath, 'utf8');
        const publications = yaml.load(publicationsData);
        
        const newPublication = {
            title: req.body.title,
            url: req.body.url,
            authors: req.body.authors,
            year: req.body.year.toString()
        };
        
        if (req.body.journal) newPublication.journal = req.body.journal;
        if (req.body.conference) newPublication.conference = req.body.conference;
        if (req.body.citations) newPublication.citations = req.body.citations.toString();
        
        publications.unshift(newPublication); // Add to beginning
        
        fs.writeFileSync(publicationsPath, yaml.dump(publications, { lineWidth: -1 }));
        res.json({ success: true, publication: newPublication });
    } catch (error) {
        res.status(500).json({ error: 'Failed to add publication' });
    }
});

// Update publication
app.put('/api/publications/:index', authenticate, (req, res) => {
    try {
        const index = parseInt(req.params.index);
        const publicationsPath = path.join(__dirname, '_data', 'publications.yml');
        const publicationsData = fs.readFileSync(publicationsPath, 'utf8');
        const publications = yaml.load(publicationsData);
        
        if (index < 0 || index >= publications.length) {
            return res.status(404).json({ error: 'Publication not found' });
        }
        
        publications[index] = {
            title: req.body.title,
            url: req.body.url,
            authors: req.body.authors,
            year: req.body.year.toString()
        };
        
        if (req.body.journal) publications[index].journal = req.body.journal;
        if (req.body.conference) publications[index].conference = req.body.conference;
        if (req.body.citations) publications[index].citations = req.body.citations.toString();
        
        fs.writeFileSync(publicationsPath, yaml.dump(publications, { lineWidth: -1 }));
        res.json({ success: true, publication: publications[index] });
    } catch (error) {
        res.status(500).json({ error: 'Failed to update publication' });
    }
});

// Delete publication
app.delete('/api/publications/:index', authenticate, (req, res) => {
    try {
        const index = parseInt(req.params.index);
        const publicationsPath = path.join(__dirname, '_data', 'publications.yml');
        const publicationsData = fs.readFileSync(publicationsPath, 'utf8');
        const publications = yaml.load(publicationsData);
        
        if (index < 0 || index >= publications.length) {
            return res.status(404).json({ error: 'Publication not found' });
        }
        
        const deletedPublication = publications.splice(index, 1)[0];
        fs.writeFileSync(publicationsPath, yaml.dump(publications, { lineWidth: -1 }));
        res.json({ success: true, publication: deletedPublication });
    } catch (error) {
        res.status(500).json({ error: 'Failed to delete publication' });
    }
});

// Login endpoint
app.post('/api/login', (req, res) => {
    const { username, password } = req.body;
    
    if (username === 'admin' && password === 'matrixlab2025') {
        res.json({ 
            success: true, 
            token: 'matrixlab2025', // In production, use JWT
            message: 'Login successful' 
        });
    } else {
        res.status(401).json({ error: 'Invalid credentials' });
    }
});

app.listen(PORT, () => {
    console.log(`Admin server running on http://localhost:${PORT}`);
    console.log(`Admin panel: http://localhost:${PORT}/admin.html`);
});
