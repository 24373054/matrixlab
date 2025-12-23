#!/bin/bash
echo "Stopping Jekyll server..."

# 查找并停止所有jekyll服务进程
pkill -f "jekyll serve"

# 检查是否还有jekyll进程在运行
if pgrep -f "jekyll serve" > /dev/null; then
    echo "Some jekyll processes are still running. Force stopping..."
    pkill -9 -f "jekyll serve"
    echo "Jekyll server forcefully stopped"
else
    echo "Jekyll server stopped successfully"
fi

echo "Check if any jekyll processes remain:"
ps aux | grep jekyll | grep -v grep
