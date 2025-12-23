#!/usr/bin/env python3
"""
WSGI entry point for Matrix Lab Admin Server
用于 Gunicorn 的入口文件
"""

import sys
import os

# 添加项目路径
sys.path.insert(0, os.path.dirname(__file__))

# 导入 Flask 应用
from admin_server import app

if __name__ == "__main__":
    app.run()

