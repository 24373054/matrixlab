#!/bin/bash
# SEO Audit Script for Matrix Lab
# Quick check of SEO implementation

echo "🔍 Matrix Lab SEO Audit"
echo "======================="
echo ""

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} $1 exists"
        return 0
    else
        echo -e "${RED}✗${NC} $1 missing"
        return 1
    fi
}

check_content() {
    if grep -q "$2" "$1" 2>/dev/null; then
        echo -e "${GREEN}✓${NC} $1 contains $3"
        return 0
    else
        echo -e "${YELLOW}⚠${NC} $1 missing $3"
        return 1
    fi
}

echo "📄 Core SEO Files:"
check_file "sitemap.xml"
check_file "robots.txt"
check_file "feed.xml"
check_file "humans.txt"
check_file "manifest.json"
check_file "404.html"
check_file ".htaccess"
echo ""

echo "🔧 SEO Components:"
check_file "_includes/seo.html"
check_file "_includes/analytics.html"
check_file "_includes/performance.html"
check_file "_includes/social-share.html"
check_file "_includes/breadcrumbs.html"
echo ""

echo "📝 Content Pages:"
check_file "home.md"
check_file "publications.md"
check_file "people.md"
echo ""

echo "🔍 Meta Tag Checks:"
check_content "_includes/seo.html" "og:title" "Open Graph title"
check_content "_includes/seo.html" "twitter:card" "Twitter Card"
check_content "_includes/seo.html" "application/ld+json" "Structured Data"
check_content "_includes/seo.html" "google-site-verification" "Google verification"
echo ""

echo "⚙️ Configuration:"
check_content "_config.yml" "url: https://matrixlab.work" "Production URL"
check_content "_config.yml" "Matrix Lab" "Site title"
check_content "_config.yml" "description:" "Site description"
echo ""

echo "🚀 Performance:"
check_content ".htaccess" "mod_deflate" "Compression enabled"
check_content ".htaccess" "mod_expires" "Browser caching"
check_content ".htaccess" "HTTPS" "HTTPS redirect"
echo ""

echo "🔒 Security:"
check_content ".htaccess" "X-Frame-Options" "Clickjacking protection"
check_content ".htaccess" "X-XSS-Protection" "XSS protection"
check_content ".htaccess" "Content-Security-Policy" "CSP header"
check_file "security.txt"
echo ""

echo "📊 Structured Data:"
check_content "_includes/seo.html" "Organization" "Organization schema"
check_content "_includes/seo.html" "WebSite" "WebSite schema"
check_content "_includes/analytics.html" "ResearchOrganization" "Research schema"
echo ""

echo "🌐 Sitemap Check:"
if [ -f "sitemap.xml" ]; then
    pages=$(grep -c "<url>" sitemap.xml 2>/dev/null || echo "0")
    echo -e "${GREEN}✓${NC} Sitemap contains $pages URLs"
fi
echo ""

echo "🤖 Robots.txt Check:"
if [ -f "robots.txt" ]; then
    if grep -q "Sitemap:" robots.txt; then
        echo -e "${GREEN}✓${NC} Sitemap declared in robots.txt"
    else
        echo -e "${YELLOW}⚠${NC} Sitemap not declared in robots.txt"
    fi
fi
echo ""

echo "📱 Mobile Optimization:"
check_content "_includes/seo.html" "viewport" "Viewport meta tag"
check_content "manifest.json" "display" "PWA manifest"
echo ""

echo "🎯 Next Steps:"
echo "1. Replace G-XXXXXXXXXX in _includes/analytics.html with your GA4 ID"
echo "2. Verify site in Google Search Console"
echo "3. Submit sitemap: https://matrixlab.work/sitemap.xml"
echo "4. Generate social media images (run generate_og_image.py)"
echo "5. Test with: https://search.google.com/test/rich-results"
echo "6. Check mobile: https://search.google.com/test/mobile-friendly"
echo "7. Test speed: https://pagespeed.web.dev/"
echo ""

echo "✅ SEO Audit Complete!"
