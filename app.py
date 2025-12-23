#!/usr/bin/env python3
"""
WSGI entry point for Matrix Lab Admin Server
优化版入口文件 - 供 Gunicorn 使用
"""

import sys
import os

# 确保可以导入模块
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

# 导入原始 admin-server.py 中的 app
import importlib.util
spec = importlib.util.spec_from_file_location("admin_server", 
                                               os.path.join(os.path.dirname(__file__), "admin-server.py"))
admin_server = importlib.util.module_from_spec(spec)
spec.loader.exec_module(admin_server)

# 导出 Flask app
app = admin_server.app

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=3003)

