#!/bin/bash
# Matrix Lab - 构建和部署脚本
# 用于更新网站内容后重新构建 Jekyll

set -e  # 遇到错误立即退出

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                                                              ║"
echo "║        🔨 Matrix Lab 网站构建和部署                          ║"
echo "║                                                              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# 获取脚本所在目录
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

echo "📍 当前目录: $SCRIPT_DIR"
echo ""

# 1. 清理旧的构建
echo "🧹 清理旧的构建文件..."
if [ -d "_site" ]; then
    rm -rf _site/.jekyll-cache 2>/dev/null || true
    echo "   ✓ 清理完成"
else
    echo "   ℹ️  _site 目录不存在，跳过清理"
fi
echo ""

# 2. 运行 Jekyll 构建
echo "🔨 开始构建 Jekyll 网站..."
if command -v jekyll &> /dev/null; then
    jekyll build
    if [ $? -eq 0 ]; then
        echo "   ✅ Jekyll 构建成功！"
    else
        echo "   ❌ Jekyll 构建失败！"
        exit 1
    fi
else
    echo "   ❌ Jekyll 未安装！"
    echo "   请运行: gem install jekyll bundler"
    exit 1
fi
echo ""

# 3. 验证关键文件
echo "🔍 验证 SEO 文件..."
REQUIRED_FILES=(
    "_site/sitemap.xml"
    "_site/robots.txt"
    "_site/feed.xml"
    "_site/manifest.json"
    "_site/404.html"
    "_site/home.html"
    "_site/publications.html"
)

ALL_EXIST=true
for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "   ✓ $file"
    else
        echo "   ✗ $file (缺失)"
        ALL_EXIST=false
    fi
done
echo ""

if [ "$ALL_EXIST" = false ]; then
    echo "❌ 部分文件缺失，请检查构建过程"
    exit 1
fi

# 4. 显示构建统计
echo "📊 构建统计:"
echo "   HTML 文件: $(find _site -name "*.html" | wc -l)"
echo "   CSS 文件:  $(find _site -name "*.css" | wc -l)"
echo "   JS 文件:   $(find _site -name "*.js" | wc -l)"
echo "   总大小:    $(du -sh _site | cut -f1)"
echo ""

# 5. 可选：重启 Nginx
read -p "是否重启 Nginx 服务？(y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🔄 重启 Nginx..."
    if command -v systemctl &> /dev/null; then
        sudo systemctl restart nginx
        if [ $? -eq 0 ]; then
            echo "   ✅ Nginx 重启成功！"
        else
            echo "   ❌ Nginx 重启失败！"
            exit 1
        fi
    else
        echo "   ⚠️  systemctl 不可用，请手动重启 Nginx"
    fi
    echo ""
fi

# 6. 运行 SEO 审计
if [ -f "seo_audit.sh" ]; then
    echo "🔍 运行 SEO 审计..."
    ./seo_audit.sh 2>/dev/null | tail -20
    echo ""
fi

# 7. 完成
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                                                              ║"
echo "║        ✅ 构建和部署完成！                                   ║"
echo "║                                                              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "🌐 网站地址: https://matrixlab.work"
echo ""
echo "📋 下一步:"
echo "   1. 访问网站验证更新"
echo "   2. 测试 SEO 文件:"
echo "      curl https://matrixlab.work/sitemap.xml"
echo "      curl https://matrixlab.work/robots.txt"
echo "   3. 在线测试:"
echo "      https://search.google.com/test/rich-results"
echo "      https://pagespeed.web.dev/"
echo ""
