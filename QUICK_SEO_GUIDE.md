# Quick SEO Setup Guide

## 🚀 Immediate Actions (5 minutes)

### 1. Google Search Console
```
1. Go to: https://search.google.com/search-console
2. Add property: matrixlab.work
3. Verification is already done via meta tag in _includes/seo.html
4. Submit sitemap: https://matrixlab.work/sitemap.xml
```

### 2. Google Analytics (Optional)
```
1. Create GA4 property at: https://analytics.google.com
2. Get your Measurement ID (format: G-XXXXXXXXXX)
3. Replace in: _includes/analytics.html
   Find: G-XXXXXXXXXX
   Replace with: Your actual ID
```

### 3. Generate Social Media Image
```bash
# If you have Python and Pillow installed:
python3 generate_og_image.py

# Or create manually:
# - Size: 1200x630 pixels
# - Save to: assets/images/og-image.png
# - Update _config.yml: metadata.image: /assets/images/og-image.png
```

## 📊 Testing Your SEO (10 minutes)

### Test URLs:
1. **Rich Results Test**: https://search.google.com/test/rich-results
   - Test: https://matrixlab.work/
   - Should show: Organization, WebSite, WebPage schemas

2. **Mobile-Friendly Test**: https://search.google.com/test/mobile-friendly
   - Test: https://matrixlab.work/
   - Should pass all mobile checks

3. **PageSpeed Insights**: https://pagespeed.web.dev/
   - Test: https://matrixlab.work/
   - Target: 90+ score

4. **Open Graph Debugger**: https://www.opengraph.xyz/
   - Test: https://matrixlab.work/
   - Check social media preview

5. **Twitter Card Validator**: https://cards-dev.twitter.com/validator
   - Test: https://matrixlab.work/
   - Check Twitter preview

## 🔧 Configuration Checklist

- [x] sitemap.xml created
- [x] robots.txt configured
- [x] Meta tags added
- [x] Structured data implemented
- [x] Open Graph tags added
- [x] Twitter Cards configured
- [x] Performance optimization
- [x] Security headers
- [x] 404 page created
- [ ] Google Analytics ID (replace placeholder)
- [ ] Social media image (generate or create)

## 📈 Monitor & Improve

### Weekly Tasks:
- Check Google Search Console for errors
- Monitor keyword rankings
- Review analytics data
- Check for broken links

### Monthly Tasks:
- Update content
- Build backlinks
- Analyze competitor SEO
- Optimize underperforming pages

## 🎯 SEO Metrics to Track

1. **Organic Traffic**: Google Analytics
2. **Keyword Rankings**: Google Search Console
3. **Click-Through Rate (CTR)**: Search Console
4. **Page Speed**: PageSpeed Insights
5. **Backlinks**: Ahrefs, SEMrush, or Moz
6. **Indexing Status**: Search Console

## 🔗 Important URLs

- Sitemap: https://matrixlab.work/sitemap.xml
- RSS Feed: https://matrixlab.work/feed.xml
- Robots: https://matrixlab.work/robots.txt
- Manifest: https://matrixlab.work/manifest.json

## 💡 Pro Tips

1. **Content is King**: Regularly publish quality research content
2. **Internal Linking**: Link between related pages
3. **External Links**: Get citations and backlinks from academic sites
4. **Social Signals**: Share on social media
5. **Mobile First**: Ensure mobile experience is excellent
6. **Page Speed**: Keep load times under 3 seconds
7. **HTTPS**: Always use secure connections
8. **Fresh Content**: Update pages regularly

## 🆘 Troubleshooting

### Site not indexed?
- Check robots.txt isn't blocking
- Submit sitemap in Search Console
- Check for manual penalties
- Ensure site is accessible

### Low rankings?
- Improve content quality
- Build more backlinks
- Optimize page speed
- Fix technical SEO issues

### Poor CTR?
- Improve title tags
- Write better meta descriptions
- Use rich snippets
- Add structured data

## 📚 Resources

- [Google SEO Guide](https://developers.google.com/search/docs)
- [Schema.org](https://schema.org)
- [Web.dev](https://web.dev)
- [Moz SEO Guide](https://moz.com/beginners-guide-to-seo)

---

**Need Help?** Check SEO_OPTIMIZATION.md for detailed documentation.
