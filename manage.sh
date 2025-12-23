#!/bin/bash
# =========================================
# Matrix Lab 完整服务管理脚本
# 管理网站 (Nginx) + 管理员后端 (Python Flask)
# =========================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 打印函数
print_header() {
    echo -e "${BLUE}╔═══════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║          Matrix Lab - 服务管理中心                   ║${NC}"
    echo -e "${BLUE}╚═══════════════════════════════════════════════════════╝${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${CYAN}ℹ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# 检查服务状态
check_status() {
    print_header
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}  网站服务 (Nginx)${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    if systemctl is-active --quiet nginx; then
        print_success "Nginx 服务运行中"
        
        if netstat -tlnp 2>/dev/null | grep -q ":443.*nginx"; then
            print_success "HTTPS (443) 端口监听正常"
        else
            print_error "HTTPS (443) 端口未监听"
        fi
        
        if netstat -tlnp 2>/dev/null | grep -q ":80.*nginx"; then
            print_success "HTTP (80) 端口监听正常"
        else
            print_error "HTTP (80) 端口未监听"
        fi
    else
        print_error "Nginx 服务未运行"
    fi
    
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}  管理员后端服务 (Flask API)${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    if systemctl is-active --quiet matrixlab-admin; then
        print_success "管理员后端运行中"
        
        if netstat -tlnp 2>/dev/null | grep -q ":3003.*python"; then
            print_success "API 端口 (3003) 监听正常"
        else
            print_error "API 端口 (3003) 未监听"
        fi
        
        # 测试API健康检查
        if curl -s -f https://matrixlab.work/api/health > /dev/null 2>&1; then
            print_success "API 健康检查通过"
        else
            print_warning "API 健康检查失败（可能正在启动）"
        fi
    else
        print_error "管理员后端未运行"
    fi
    
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}  访问地址${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    print_info "网站首页: ${GREEN}https://matrixlab.work${NC}"
    print_info "管理面板: ${GREEN}https://matrixlab.work/admin.html${NC}"
    print_info "API健康检查: ${GREEN}https://matrixlab.work/api/health${NC}"
    echo ""
}

# 启动所有服务
start_all() {
    print_header
    echo ""
    print_info "正在启动所有服务..."
    echo ""
    
    # 启动 Nginx
    echo -e "${CYAN}► 启动 Nginx...${NC}"
    if systemctl is-active --quiet nginx; then
        print_warning "Nginx 已经在运行"
    else
        sudo systemctl start nginx
        if systemctl is-active --quiet nginx; then
            print_success "Nginx 启动成功"
        else
            print_error "Nginx 启动失败"
        fi
    fi
    
    echo ""
    
    # 启动管理员后端
    echo -e "${CYAN}► 启动管理员后端...${NC}"
    if systemctl is-active --quiet matrixlab-admin; then
        print_warning "管理员后端已经在运行"
    else
        sudo systemctl start matrixlab-admin
        sleep 2
        if systemctl is-active --quiet matrixlab-admin; then
            print_success "管理员后端启动成功"
        else
            print_error "管理员后端启动失败"
        fi
    fi
    
    echo ""
    print_success "所有服务启动完成！"
    echo ""
    print_info "网站地址: https://matrixlab.work"
    print_info "管理面板: https://matrixlab.work/admin.html"
    echo ""
}

# 停止所有服务
stop_all() {
    print_header
    echo ""
    print_info "正在停止所有服务..."
    echo ""
    
    # 停止 Nginx
    echo -e "${CYAN}► 停止 Nginx...${NC}"
    sudo systemctl stop nginx
    if ! systemctl is-active --quiet nginx; then
        print_success "Nginx 已停止"
    else
        print_error "Nginx 停止失败"
    fi
    
    echo ""
    
    # 停止管理员后端
    echo -e "${CYAN}► 停止管理员后端...${NC}"
    sudo systemctl stop matrixlab-admin
    if ! systemctl is-active --quiet matrixlab-admin; then
        print_success "管理员后端已停止"
    else
        print_error "管理员后端停止失败"
    fi
    
    echo ""
    print_success "所有服务已停止"
    echo ""
}

# 重启所有服务
restart_all() {
    print_header
    echo ""
    print_info "正在重启所有服务..."
    echo ""
    
    # 测试 Nginx 配置
    echo -e "${CYAN}► 测试 Nginx 配置...${NC}"
    if sudo nginx -t 2>&1 | grep -q "test is successful"; then
        print_success "Nginx 配置测试通过"
    else
        print_error "Nginx 配置测试失败"
        sudo nginx -t
        return 1
    fi
    
    echo ""
    
    # 重启 Nginx
    echo -e "${CYAN}► 重启 Nginx...${NC}"
    sudo systemctl restart nginx
    if systemctl is-active --quiet nginx; then
        print_success "Nginx 重启成功"
    else
        print_error "Nginx 重启失败"
    fi
    
    echo ""
    
    # 重启管理员后端
    echo -e "${CYAN}► 重启管理员后端...${NC}"
    sudo systemctl restart matrixlab-admin
    sleep 2
    if systemctl is-active --quiet matrixlab-admin; then
        print_success "管理员后端重启成功"
    else
        print_error "管理员后端重启失败"
    fi
    
    echo ""
    print_success "所有服务重启完成！"
    echo ""
}

# 查看日志
view_logs() {
    print_header
    echo ""
    echo "选择要查看的日志:"
    echo ""
    echo "  1) Nginx 访问日志"
    echo "  2) Nginx 错误日志"
    echo "  3) 管理员后端日志"
    echo "  4) 管理员后端错误日志"
    echo "  5) 实时监控 Nginx 错误日志"
    echo "  6) 实时监控管理员后端日志"
    echo ""
    read -p "请输入选项 [1-6]: " log_choice
    
    case $log_choice in
        1)
            sudo less /var/log/nginx/matrixlab_access.log
            ;;
        2)
            sudo less /var/log/nginx/matrixlab_error.log
            ;;
        3)
            sudo less /var/log/matrixlab-admin.log
            ;;
        4)
            sudo less /var/log/matrixlab-admin-error.log
            ;;
        5)
            echo "按 Ctrl+C 退出监控"
            sudo tail -f /var/log/nginx/matrixlab_error.log
            ;;
        6)
            echo "按 Ctrl+C 退出监控"
            sudo tail -f /var/log/matrixlab-admin.log
            ;;
        *)
            print_error "无效选项"
            ;;
    esac
}

# 测试连接
test_connection() {
    print_header
    echo ""
    print_info "正在测试连接..."
    echo ""
    
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}  网站首页 (HTTPS)${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    curl -I https://matrixlab.work 2>&1 | head -12
    echo ""
    
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}  HTTP 重定向测试${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    curl -I http://matrixlab.work 2>&1 | head -8
    echo ""
    
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}  API 健康检查${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    curl -s https://matrixlab.work/api/health | python3 -m json.tool
    echo ""
    
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}  管理面板${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    if curl -s -I https://matrixlab.work/admin.html | grep -q "200 OK"; then
        print_success "管理面板访问正常"
        print_info "访问地址: https://matrixlab.work/admin.html"
    else
        print_error "管理面板访问失败"
    fi
    echo ""
}

# 显示管理员凭据
show_credentials() {
    print_header
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}  管理员登录信息${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    print_info "管理面板地址: ${GREEN}https://matrixlab.work/admin.html${NC}"
    print_info "用户名: ${GREEN}admin${NC}"
    print_info "密码: ${GREEN}matrixlab2025${NC}"
    echo ""
    print_warning "请妥善保管登录凭据！"
    echo ""
}

# 主菜单
show_menu() {
    print_header
    echo ""
    echo "请选择操作:"
    echo ""
    echo "  ${GREEN}1)${NC} 查看服务状态"
    echo "  ${GREEN}2)${NC} 启动所有服务"
    echo "  ${GREEN}3)${NC} 停止所有服务"
    echo "  ${GREEN}4)${NC} 重启所有服务"
    echo "  ${GREEN}5)${NC} 查看日志"
    echo "  ${GREEN}6)${NC} 测试连接"
    echo "  ${GREEN}7)${NC} 显示管理员凭据"
    echo "  ${GREEN}0)${NC} 退出"
    echo ""
    read -p "请输入选项 [0-7]: " choice
    
    case $choice in
        1) check_status ;;
        2) start_all ;;
        3) stop_all ;;
        4) restart_all ;;
        5) view_logs ;;
        6) test_connection ;;
        7) show_credentials ;;
        0) echo ""; print_info "再见！"; echo ""; exit 0 ;;
        *) print_error "无效选项"; sleep 1; show_menu ;;
    esac
    
    echo ""
    read -p "按 Enter 键继续..."
    show_menu
}

# 命令行参数处理
if [ $# -eq 0 ]; then
    show_menu
else
    case "$1" in
        status)
            check_status
            ;;
        start)
            start_all
            ;;
        stop)
            stop_all
            ;;
        restart)
            restart_all
            ;;
        logs)
            view_logs
            ;;
        test)
            test_connection
            ;;
        credentials)
            show_credentials
            ;;
        *)
            print_header
            echo ""
            echo "用法: $0 {status|start|stop|restart|logs|test|credentials}"
            echo ""
            echo "命令说明:"
            echo "  status       - 查看服务状态"
            echo "  start        - 启动所有服务"
            echo "  stop         - 停止所有服务"
            echo "  restart      - 重启所有服务"
            echo "  logs         - 查看日志"
            echo "  test         - 测试连接"
            echo "  credentials  - 显示管理员凭据"
            echo ""
            echo "交互模式: 直接运行 $0 (不带参数)"
            echo ""
            exit 1
            ;;
    esac
fi

