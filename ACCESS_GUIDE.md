# Matrix Lab Admin Panel - Access Guide

## Important: Correct Access URL

The admin panel is running on a separate server (port 3001), not the main Jekyll server (port 80).

### Correct URL to Access Admin Panel:
```
http://140.143.183.163:3001/admin-panel.html
```

### Incorrect URL (what you're currently using):
```
http://140.143.183.163/admin-panel.html  (port 80 - Jekyll server)
```

## Quick Access Steps

1. **Start the Admin Server** (if not already running):
   ```bash
   cd /root/yz/Matrix_Lab/Matrix_Lab1.0
   ./start-admin-server.sh
   ```

2. **Access the Correct URL**:
   Open your browser and go to:
   ```
   http://140.143.183.163:3001/admin-panel.html
   ```

3. **Login Credentials**:
   - Username: `admin`
   - Password: `matrixlab2025`

## Why This Happens

- **Jekyll Server**: Runs on port 80, serves the main website
- **Admin Server**: Runs on port 3001, serves the admin panel and API
- **Different Ports**: They are separate servers running on different ports

## Verification

To verify the admin server is running:
```bash
ps aux | grep admin-server
netstat -tlnp | grep 3001
```

