#!/bin/bash
echo "Checking Jekyll server status..."

# 检查jekyll进程是否在运行
if pgrep -f "jekyll serve" > /dev/null; then
    echo "✓ Jekyll server is running"
    echo "Running processes:"
    ps aux | grep jekyll | grep -v grep
    echo ""
    echo "To view logs: tail -f jekyll.log"
    echo "Server URL: http://0.0.0.0:4000"
else
    echo "✗ Jekyll server is not running"
    echo "To start server: ./start_server.sh"
fi

# 检查日志文件是否存在
if [ -f "jekyll.log" ]; then
    echo ""
    echo "Recent log entries:"
    tail -10 jekyll.log
fi
