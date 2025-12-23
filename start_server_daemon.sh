#!/bin/bash
echo "Starting Jekyll server as daemon (will continue running after terminal closes)..."
echo "Server will be accessible at: http://0.0.0.0:4000"
echo "Logs will be saved to: jekyll_server.log"

# 使用nohup在后台运行Jekyll服务器，忽略挂起信号
nohup jekyll serve --host 0.0.0.0 --port 4000 --livereload > jekyll_server.log 2>&1 &

# 获取进程ID
SERVER_PID=$!
echo "Jekyll server started with PID: $SERVER_PID"
echo "Process ID saved to: jekyll_server.pid"

# 保存进程ID到文件，便于后续管理
echo $SERVER_PID > jekyll_server.pid

echo ""
echo "Server is now running in the background."
echo "To stop the server, run: kill \$(cat jekyll_server.pid)"
echo "To view logs, run: tail -f jekyll_server.log"
echo "To check if server is running, run: ps -p \$(cat jekyll_server.pid)"
