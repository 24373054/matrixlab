#!/bin/bash
# =========================================
# Matrix Lab 宝塔面板启动脚本
# 作用：启动占位进程 + 自动修复nginx配置
# =========================================

cd /root/yz/Matrix_Lab/Matrix_Lab1.0 || exit 1

echo "╔═══════════════════════════════════════════════════════╗"
echo "║       Matrix Lab 正在启动...                         ║"
echo "╚═══════════════════════════════════════════════════════╝"

# 延迟2秒后自动修复nginx配置（后台运行）
(
    sleep 2
    echo "[自动修复] 正在修复nginx配置..."
    
    # 修复root目录
    sed -i 's|root /root/yz/Matrix_Lab/Matrix_Lab1.0/start_server.sh;|root /root/yz/Matrix_Lab/Matrix_Lab1.0/_site;|g' /www/server/panel/vhost/nginx/other_start_server_sh.conf
    
    # 修复location配置（删除proxy_pass行）
    if grep -q "proxy_pass http://127.0.0.1:4001" /www/server/panel/vhost/nginx/other_start_server_sh.conf; then
        # 使用awk替换整个location块
        awk '
        /location \/ \{/{p=1}
        p && /\}/{
            print "    location / {"
            print "        try_files $uri $uri/ =404;"
            print "    }"
            p=0
            next
        }
        !p{print}
        ' /www/server/panel/vhost/nginx/other_start_server_sh.conf > /tmp/nginx_fixed.conf
        
        mv /tmp/nginx_fixed.conf /www/server/panel/vhost/nginx/other_start_server_sh.conf
    fi
    
    # 重新加载nginx
    /etc/init.d/nginx reload > /dev/null 2>&1
    echo "[自动修复] ✅ Nginx配置已修复为纯静态模式"
    echo "[自动修复] 网站地址: https://matrixlab.work"
) &

echo ""
echo "✅ 占位进程已启动（端口4001）"
echo "✅ 2秒后将自动修复nginx配置"
echo "✅ 实际网站由Nginx直接服务静态文件"
echo ""

# 启动一个简单的Python HTTP服务器（占位用）
exec python3 -m http.server 4001 --bind 0.0.0.0
