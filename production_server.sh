#!/bin/bash
# =========================================
# Matrix Lab 生产环境 HTTPS 服务管理脚本
# 网站: https://matrixlab.work
# =========================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SITE_DIR="$SCRIPT_DIR/_site"
NGINX_CONFIG="/etc/nginx/sites-available/matrixlab.work"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印函数
print_header() {
    echo -e "${BLUE}╔═══════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║       Matrix Lab - HTTPS 生产环境管理               ║${NC}"
    echo -e "${BLUE}╚═══════════════════════════════════════════════════════╝${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}ℹ $1${NC}"
}

# 检查是否以root权限运行
check_sudo() {
    if [ "$EUID" -ne 0 ]; then
        print_error "请使用 sudo 运行此脚本"
        exit 1
    fi
}

# 检查Nginx状态
check_status() {
    print_header
    echo ""
    
    if systemctl is-active --quiet nginx; then
        print_success "Nginx 服务运行中"
        
        # 检查端口
        if netstat -tlnp | grep -q ":443.*nginx"; then
            print_success "HTTPS (443) 端口监听正常"
        else
            print_error "HTTPS (443) 端口未监听"
        fi
        
        if netstat -tlnp | grep -q ":80.*nginx"; then
            print_success "HTTP (80) 端口监听正常"
        else
            print_error "HTTP (80) 端口未监听"
        fi
        
        echo ""
        print_info "网站地址: https://matrixlab.work"
        print_info "测试命令: curl -I https://matrixlab.work"
        
    else
        print_error "Nginx 服务未运行"
    fi
    echo ""
}

# 启动服务
start_service() {
    print_header
    echo ""
    print_info "正在启动 HTTPS 服务..."
    
    # 检查配置文件
    if [ ! -f "$NGINX_CONFIG" ]; then
        print_error "Nginx 配置文件不存在: $NGINX_CONFIG"
        exit 1
    fi
    
    # 检查静态文件
    if [ ! -d "$SITE_DIR" ]; then
        print_error "网站文件目录不存在: $SITE_DIR"
        exit 1
    fi
    
    # 测试配置
    print_info "测试 Nginx 配置..."
    if nginx -t 2>&1 | grep -q "test is successful"; then
        print_success "配置文件测试通过"
    else
        print_error "配置文件测试失败"
        nginx -t
        exit 1
    fi
    
    # 启动Nginx
    systemctl start nginx
    sleep 1
    
    if systemctl is-active --quiet nginx; then
        print_success "Nginx 启动成功"
        echo ""
        print_info "网站地址: https://matrixlab.work"
    else
        print_error "Nginx 启动失败"
        systemctl status nginx
        exit 1
    fi
    echo ""
}

# 停止服务
stop_service() {
    print_header
    echo ""
    print_info "正在停止 HTTPS 服务..."
    
    systemctl stop nginx
    sleep 1
    
    if ! systemctl is-active --quiet nginx; then
        print_success "Nginx 已停止"
    else
        print_error "Nginx 停止失败"
        exit 1
    fi
    echo ""
}

# 重启服务
restart_service() {
    print_header
    echo ""
    print_info "正在重启 HTTPS 服务..."
    
    # 测试配置
    print_info "测试 Nginx 配置..."
    if nginx -t 2>&1 | grep -q "test is successful"; then
        print_success "配置文件测试通过"
    else
        print_error "配置文件测试失败"
        nginx -t
        exit 1
    fi
    
    systemctl restart nginx
    sleep 1
    
    if systemctl is-active --quiet nginx; then
        print_success "Nginx 重启成功"
        echo ""
        print_info "网站地址: https://matrixlab.work"
    else
        print_error "Nginx 重启失败"
        systemctl status nginx
        exit 1
    fi
    echo ""
}

# 重新加载配置
reload_config() {
    print_header
    echo ""
    print_info "正在重新加载配置..."
    
    # 测试配置
    if nginx -t 2>&1 | grep -q "test is successful"; then
        print_success "配置文件测试通过"
        systemctl reload nginx
        print_success "配置重新加载成功"
    else
        print_error "配置文件测试失败"
        nginx -t
        exit 1
    fi
    echo ""
}

# 查看日志
view_logs() {
    print_header
    echo ""
    echo "请选择要查看的日志:"
    echo "1) 访问日志 (Access Log)"
    echo "2) 错误日志 (Error Log)"
    echo "3) 实时监控 (tail -f Error Log)"
    echo ""
    read -p "请输入选项 [1-3]: " log_choice
    
    case $log_choice in
        1)
            less /var/log/nginx/matrixlab_access.log
            ;;
        2)
            less /var/log/nginx/matrixlab_error.log
            ;;
        3)
            tail -f /var/log/nginx/matrixlab_error.log
            ;;
        *)
            print_error "无效选项"
            exit 1
            ;;
    esac
}

# 测试连接
test_connection() {
    print_header
    echo ""
    print_info "测试 HTTPS 连接..."
    echo ""
    
    # 测试HTTPS
    echo "===== HTTPS 测试 ====="
    curl -I https://matrixlab.work 2>&1 | head -15
    echo ""
    
    # 测试HTTP重定向
    echo "===== HTTP 重定向测试 ====="
    curl -I http://matrixlab.work 2>&1 | head -10
    echo ""
}

# 主菜单
main_menu() {
    if [ $# -eq 0 ]; then
        print_header
        echo ""
        echo "用法: sudo $0 {start|stop|restart|reload|status|logs|test}"
        echo ""
        echo "命令说明:"
        echo "  start   - 启动 HTTPS 服务"
        echo "  stop    - 停止 HTTPS 服务"
        echo "  restart - 重启 HTTPS 服务"
        echo "  reload  - 重新加载配置"
        echo "  status  - 查看服务状态"
        echo "  logs    - 查看日志"
        echo "  test    - 测试连接"
        echo ""
        exit 1
    fi
    
    case "$1" in
        start)
            check_sudo
            start_service
            ;;
        stop)
            check_sudo
            stop_service
            ;;
        restart)
            check_sudo
            restart_service
            ;;
        reload)
            check_sudo
            reload_config
            ;;
        status)
            check_status
            ;;
        logs)
            check_sudo
            view_logs
            ;;
        test)
            test_connection
            ;;
        *)
            print_error "无效命令: $1"
            main_menu
            ;;
    esac
}

# 执行主函数
main_menu "$@"

