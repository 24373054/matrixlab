#!/bin/bash
# SEO 验证快速检查脚本

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                                                              ║"
echo "║        🔍 SEO 验证状态检查                                   ║"
echo "║                                                              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

check_url() {
    local url=$1
    local name=$2
    local code=$(curl -s -o /dev/null -w "%{http_code}" "$url")
    
    if [ "$code" = "200" ]; then
        echo -e "  ${GREEN}✓${NC} $name: $code (正常)"
    elif [ "$code" = "404" ]; then
        echo -e "  ${RED}✗${NC} $name: $code (文件不存在)"
    else
        echo -e "  ${YELLOW}⚠${NC} $name: $code (需要检查)"
    fi
}

# 检查验证文件
echo "📄 验证文件检查:"
check_url "https://matrixlab.work/googleOWYcThUEXCJ2tRqvTsJ7ahhdos6rlzNzRFvHhnfjVrI.html" "Google 验证文件"
check_url "https://matrixlab.work/baidu_verify_codeva-U55Hd3ryRv.html" "百度验证文件"
echo ""

# 检查 SEO 文件
echo "📊 SEO 文件检查:"
check_url "https://matrixlab.work/sitemap.xml" "Sitemap"
check_url "https://matrixlab.work/robots.txt" "Robots.txt"
check_url "https://matrixlab.work/feed.xml" "RSS Feed"
check_url "https://matrixlab.work/manifest.json" "PWA Manifest"
echo ""

# 检查关键页面
echo "🌐 关键页面检查:"
check_url "https://matrixlab.work/" "首页"
check_url "https://matrixlab.work/home.html" "Home"
check_url "https://matrixlab.work/publications.html" "Publications"
check_url "https://matrixlab.work/people.html" "People"
check_url "https://matrixlab.work/platforms.html" "Platforms"
echo ""

# 检查子网站链接
echo "🔗 子网站链接检查:"
check_url "https://develop.matrixlab.work/" "刻熵科技官网"
check_url "https://develop.matrixlab.work/zh" "刻熵科技中文"
check_url "https://develop.matrixlab.work/sitemap.xml" "子网站 Sitemap"
echo ""

# 检查 Sitemap 内容
echo "📋 Sitemap 内容分析:"
sitemap_urls=$(curl -s https://matrixlab.work/sitemap.xml | grep -o "<loc>.*</loc>" | wc -l)
echo "  总 URL 数量: $sitemap_urls"

subsite_urls=$(curl -s https://matrixlab.work/sitemap.xml | grep "develop.matrixlab.work" | wc -l)
echo "  子网站 URL: $subsite_urls"
echo ""

# 检查 Meta 标签
echo "🏷️  Meta 标签检查:"
if curl -s https://matrixlab.work/ | grep -q "google-site-verification"; then
    echo -e "  ${GREEN}✓${NC} Google 验证 meta 标签存在"
else
    echo -e "  ${RED}✗${NC} Google 验证 meta 标签缺失"
fi

if curl -s https://matrixlab.work/ | grep -q "og:title"; then
    echo -e "  ${GREEN}✓${NC} Open Graph 标签存在"
else
    echo -e "  ${RED}✗${NC} Open Graph 标签缺失"
fi

if curl -s https://matrixlab.work/ | grep -q "twitter:card"; then
    echo -e "  ${GREEN}✓${NC} Twitter Card 标签存在"
else
    echo -e "  ${RED}✗${NC} Twitter Card 标签缺失"
fi
echo ""

# 检查结构化数据
echo "📐 结构化数据检查:"
if curl -s https://matrixlab.work/ | grep -q "application/ld+json"; then
    echo -e "  ${GREEN}✓${NC} Schema.org 结构化数据存在"
    
    if curl -s https://matrixlab.work/ | grep -q "subOrganization"; then
        echo -e "  ${GREEN}✓${NC} 子组织关系已定义"
    else
        echo -e "  ${YELLOW}⚠${NC} 子组织关系未定义"
    fi
else
    echo -e "  ${RED}✗${NC} Schema.org 结构化数据缺失"
fi
echo ""

# 性能检查
echo "⚡ 性能检查:"
response_time=$(curl -o /dev/null -s -w '%{time_total}' https://matrixlab.work/)
echo "  首页响应时间: ${response_time}s"

if (( $(echo "$response_time < 1.0" | bc -l) )); then
    echo -e "  ${GREEN}✓${NC} 响应速度优秀 (<1s)"
elif (( $(echo "$response_time < 3.0" | bc -l) )); then
    echo -e "  ${YELLOW}⚠${NC} 响应速度良好 (1-3s)"
else
    echo -e "  ${RED}✗${NC} 响应速度需要优化 (>3s)"
fi
echo ""

# 总结
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                                                              ║"
echo "║        ✅ 检查完成！                                         ║"
echo "║                                                              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

echo "💡 下一步:"
echo "  1. 如果所有检查都通过，前往 Google Search Console 验证"
echo "  2. 提交 sitemap: https://matrixlab.work/sitemap.xml"
echo "  3. 前往百度搜索资源平台验证"
echo "  4. 查看详细指南: SEO_VERIFICATION_GUIDE.md"
echo ""
