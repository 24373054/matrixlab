# Gunicorn 配置文件 - 性能优化
# Matrix Lab Admin Server

import multiprocessing

# 绑定地址和端口
bind = "127.0.0.1:3003"

# Worker 进程数（建议 2-4 倍 CPU 核心数）
workers = multiprocessing.cpu_count() * 2 + 1

# Worker 类型（使用同步 workers）
worker_class = "sync"

# 每个 worker 的线程数
threads = 2

# Worker 连接数
worker_connections = 1000

# 请求超时时间（秒）
timeout = 60

# 优雅重启超时
graceful_timeout = 30

# Keep-alive 连接时间
keepalive = 5

# 最大请求数（防止内存泄漏）
max_requests = 1000
max_requests_jitter = 50

# 后台运行
daemon = False

# 日志配置
accesslog = "/var/log/matrixlab-admin-access.log"
errorlog = "/var/log/matrixlab-admin-error.log"
loglevel = "info"

# 进程名称
proc_name = "matrixlab-admin"

# 预加载应用（提升性能）
preload_app = True

# 性能优化
worker_tmp_dir = "/dev/shm"

