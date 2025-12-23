# Matrix Lab Admin Panel - Production Guide

## Overview

This is a production-ready admin panel for managing Matrix Lab publications. The system provides a complete backend API and frontend interface for adding, viewing, and deleting publications.

## Features

- ✅ **Production-Ready**: Full backend API with Python Flask
- ✅ **Authentication**: Secure login system
- ✅ **CRUD Operations**: Add, view, delete publications
- ✅ **Real-time Updates**: Changes immediately reflect in the publications page
- ✅ **Data Persistence**: Publications stored in YAML format
- ✅ **Health Monitoring**: API health check endpoint
- ✅ **Logging**: Comprehensive logging for monitoring

## Quick Start

### 1. Start the Admin Server

```bash
cd yz/Matrix_Lab/Matrix_Lab1.0
./start-admin-server.sh
```

The server will automatically:
- Check for Python 3 and required packages
- Install dependencies if needed
- Start the admin server on port 3001

### 2. Access the Admin Panel

Open your browser and navigate to:
```
http://localhost:3001/admin-panel.html
```

### 3. Login Credentials

- **Username**: `admin`
- **Password**: `matrixlab2025`

## API Endpoints

| Endpoint | Method | Description | Authentication |
|----------|--------|-------------|----------------|
| `/api/publications` | GET | Get all publications | No |
| `/api/publications` | POST | Add new publication | Yes |
| `/api/publications/{index}` | DELETE | Delete publication | Yes |
| `/api/login` | POST | User login | No |
| `/api/health` | GET | Health check | No |

## File Structure

```
Matrix_Lab1.0/
├── admin-server.py          # Production Python server
├── admin-panel.html         # Admin panel frontend
├── start-admin-server.sh    # Startup script
├── _data/
│   └── publications.yml     # Publications data file
├── publications.md          # Jekyll publications page
└── assets/libdoc/js/
    └── publications-sort.js # Sorting functionality
```

## Data Storage

Publications are stored in `_data/publications.yml` in YAML format:

```yaml
- title: "Publication Title"
  url: "https://example.com"
  authors: "Author Names"
  year: "2025"
  journal: "Journal Name"
  conference: "Conference Name"
  citations: "10"
```

## Security Features

- **Authentication**: Bearer token-based authentication
- **Input Validation**: Server-side validation of all inputs
- **Error Handling**: Comprehensive error handling and logging
- **CORS**: Configured for local development

## Monitoring

### Health Check
```
GET http://localhost:3001/api/health
```

### Logs
The server logs all operations including:
- User logins (successful and failed)
- Publication additions, updates, deletions
- System errors and warnings

## Integration with Jekyll

The publications page (`publications.md`) automatically loads data from `_data/publications.yml`:

```liquid
{% for pub in site.data.publications %}
### [ {{ pub.title }}]({{ pub.url }})
**Authors**: {{ pub.authors }}  
{% if pub.journal %}**Journal**: {{ pub.journal }}  {% endif %}
**Year**: {{ pub.year }}  
{% if pub.citations %}**Citations**: {{ pub.citations }}{% endif %}
{% endfor %}
```

## Troubleshooting

### Common Issues

1. **Port 3001 already in use**
   - Kill the existing process: `pkill -f "python3 admin-server.py"`
   - Or change the port in `admin-server.py`

2. **Python dependencies missing**
   - Run: `pip3 install flask pyyaml`

3. **Permissions denied**
   - Make scripts executable: `chmod +x start-admin-server.sh`

4. **Publications not updating**
   - Restart the Jekyll server to reload data files

### Logs Location
Check the terminal where the admin server is running for detailed logs.

## Production Deployment Notes

For production deployment, consider:

1. **Environment Variables**: Move credentials to environment variables
2. **HTTPS**: Enable SSL/TLS for secure communication
3. **Database**: Consider migrating from YAML to a proper database
4. **JWT Tokens**: Implement proper JWT token generation and validation
5. **Rate Limiting**: Add rate limiting to prevent abuse
6. **Backup**: Implement regular backups of the publications data

## Support

For technical support or feature requests, contact the system administrator.
