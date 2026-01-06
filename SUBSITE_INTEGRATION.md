# 子网站整合方案 - 刻熵科技官网

## 📋 概述

**主网站**: Matrix Lab (Jekyll) - https://matrixlab.work  
**子网站**: 刻熵科技官网 (Next.js) - https://develop.matrixlab.work

## 🎯 整合目标

1. 统一 SEO 策略
2. 交叉链接优化
3. 统一品牌形象
4. 提升整体权重

---

## 🔗 1. 交叉链接策略

### 主网站 → 子网站

在 Matrix Lab 主网站添加刻熵科技的链接：

#### 1.1 在主页 (home.md) 添加

```markdown
## 🏢 Related Platforms

### Ke Entropy Technology (刻熵科技)
Our commercial arm focusing on blockchain security and Web3 solutions.

- **Official Website**: [develop.matrixlab.work](https://develop.matrixlab.work)
- **Products**:
  - [MatrixTrace](https://develop.matrixlab.work/zh/products/trace) - Blockchain Analysis Platform
  - [Matrix Exchange](https://develop.matrixlab.work/zh/products/exchange) - Decentralized Exchange
  - [Yingzhou Chronicles](https://develop.matrixlab.work/zh/products/game) - Web3 Game
- **Blog**: [Technical Articles](https://develop.matrixlab.work/zh/blog)
```

#### 1.2 创建专门的链接页面

创建 `platforms.md`:

```markdown
---
title: Platforms & Products
description: "Explore Matrix Lab's ecosystem of platforms and products"
layout: libdoc/page
category: Navigation
order: 130
---

# Matrix Lab Ecosystem

## 🏢 Ke Entropy Technology (刻熵科技)

Our commercial technology company specializing in blockchain security and Web3 solutions.

**Website**: [develop.matrixlab.work](https://develop.matrixlab.work)

### Products & Services

#### MatrixTrace - Blockchain Analysis Platform
Advanced on-chain data analysis and fund tracking system.
- [Learn More](https://develop.matrixlab.work/zh/products/trace)
- [Documentation](https://develop.matrixlab.work/zh/developers)

#### Matrix Exchange
Decentralized exchange platform with advanced trading features.
- [Visit Platform](https://develop.matrixlab.work/zh/products/exchange)

#### Yingzhou Chronicles (瀛州纪)
Web3 gaming platform combining blockchain technology with traditional gaming.
- [Play Now](https://develop.matrixlab.work/zh/products/game)
- [Open Source](https://github.com/24373054/Web3-games)

### Technical Blog
Stay updated with our latest research and insights:
- [Web3 Security Trends 2025](https://develop.matrixlab.work/zh/blog/web3-security-trends-2025)
- [Smart Contract Audit Guide](https://develop.matrixlab.work/zh/blog/smart-contract-audit-guide)
- [Benign Arbitrage Theory](https://develop.matrixlab.work/zh/blog/benign-arbitrage-theory)

## 🔗 Related Links

- **Founder's Profile**: [24373054.github.io](https://24373054.github.io/)
- **GitHub Organization**: [github.com/24373054](https://github.com/24373054)
- **Research Lab**: [matrixlab.work](https://matrixlab.work)
```

### 子网站 → 主网站

在刻熵科技官网的相关位置添加 Matrix Lab 链接。

---

## 📄 2. 主网站 Sitemap 更新

更新主网站的 `sitemap.xml` 以包含子网站链接：

```xml
<!-- 在 sitemap.xml 中添加 -->

<!-- Subsite - Ke Entropy Technology -->
<url>
  <loc>https://develop.matrixlab.work/</loc>
  <lastmod>{{ site.time | date_to_xmlschema }}</lastmod>
  <changefreq>weekly</changefreq>
  <priority>0.9</priority>
</url>

<!-- Key subsite pages -->
<url>
  <loc>https://develop.matrixlab.work/zh/products/trace</loc>
  <lastmod>{{ site.time | date_to_xmlschema }}</lastmod>
  <changefreq>weekly</changefreq>
  <priority>0.8</priority>
</url>

<url>
  <loc>https://develop.matrixlab.work/zh/blog</loc>
  <lastmod>{{ site.time | date_to_xmlschema }}</lastmod>
  <changefreq>daily</changefreq>
  <priority>0.8</priority>
</url>
```

---

## 🔍 3. 统一 SEO 配置

### 3.1 Schema.org 关联

在主网站的 `_includes/seo.html` 中添加子组织关系：

```json
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "@id": "https://matrixlab.work/#organization",
  "name": "Matrix Lab",
  "url": "https://matrixlab.work",
  "subOrganization": {
    "@type": "Organization",
    "name": "Ke Entropy Technology",
    "alternateName": "刻熵科技",
    "url": "https://develop.matrixlab.work",
    "description": "Blockchain security and Web3 solutions provider",
    "sameAs": [
      "https://github.com/24373054"
    ]
  }
}
```

### 3.2 统一关键词策略

**主网站关键词**:
- Matrix Lab
- Blockchain Research
- Federated Learning
- Academic Research
- Smart Contract Security Research

**子网站关键词**:
- Ke Entropy Technology / 刻熵科技
- MatrixTrace
- Blockchain Security Audit
- Web3 Solutions
- DeFi Risk Management

---

## 🎨 4. 品牌一致性

### 4.1 Logo 和视觉元素

确保两个网站使用一致的：
- 品牌色彩
- Logo 样式
- 字体系统
- 设计语言

### 4.2 导航链接

在主网站导航栏添加子网站入口：

```yaml
# _config.yml 中的 sidebar.additional_links
additional_links:
  - url: https://develop.matrixlab.work
    title: <span class="i-building"></span> Ke Entropy Tech
    order: 5
    category: Ecosystem
```

---

## 📊 5. 统一分析和监控

### 5.1 Google Search Console

两个网站都需要单独验证：
- matrixlab.work
- develop.matrixlab.work

但可以在同一个账号下管理。

### 5.2 Google Analytics

可以使用：
- **选项 A**: 同一个 GA4 属性（推荐）
  - 使用数据流过滤区分流量
  
- **选项 B**: 两个独立的 GA4 属性
  - 更清晰的数据分离

### 5.3 监控指标

统一追踪：
- 跨站点用户行为
- 转化路径
- 流量来源
- 关键词排名

---

## 🚀 6. 实施步骤

### 第一阶段：基础整合（今天）

1. **在主网站添加子网站链接**
   ```bash
   # 创建 platforms.md
   # 更新 home.md
   # 更新 sitemap.xml
   ```

2. **更新主网站配置**
   ```bash
   # 编辑 _config.yml
   # 编辑 _includes/seo.html
   ```

3. **构建和部署**
   ```bash
   jekyll build
   sudo systemctl restart nginx
   ```

### 第二阶段：子网站更新（本周）

1. **在子网站添加主网站链接**
   - 更新 Footer 组件
   - 添加 "Research Lab" 链接
   - 在博客文章中引用主网站研究

2. **优化子网站 SEO**
   - 确保 sitemap 正确
   - 添加结构化数据
   - 优化 meta 标签

### 第三阶段：内容协同（持续）

1. **交叉引用内容**
   - 主网站的研究成果链接到子网站产品
   - 子网站的技术博客引用主网站论文

2. **统一发布策略**
   - 研究成果 → 主网站
   - 产品更新 → 子网站
   - 技术文章 → 两站都发布

---

## 📝 7. 内容策略

### 主网站内容定位
- 学术研究
- 论文发表
- 团队介绍
- 研究方向

### 子网站内容定位
- 产品介绍
- 技术博客
- 使用教程
- 商业服务

### 内容协同
- 主网站研究成果 → 子网站产品应用
- 子网站实践经验 → 主网站研究方向
- 交叉引用，互相导流

---

## 🔗 8. 外链建设策略

### 统一外链来源

**学术平台** → 主网站
- Google Scholar
- ResearchGate
- IEEE Xplore
- ACM Digital Library

**商业平台** → 子网站
- 产品评测网站
- 技术社区
- 行业媒体
- 合作伙伴

**社交媒体** → 两站都链接
- GitHub (主要)
- Twitter/X
- LinkedIn
- 知乎

---

## 📈 9. SEO 效果预期

### 短期（1-3个月）
- 两站都被 Google 索引
- 品牌词可以搜到
- 交叉链接生效

### 中期（3-6个月）
- 主网站：学术关键词排名提升
- 子网站：产品关键词排名提升
- 整体域名权重提升

### 长期（6-12个月）
- 建立完整的内容生态
- 多个关键词排名前10
- 形成品牌影响力

---

## ✅ 检查清单

### 主网站 (matrixlab.work)
- [ ] 创建 platforms.md 页面
- [ ] 更新 home.md 添加子网站链接
- [ ] 更新 sitemap.xml
- [ ] 更新 _includes/seo.html 添加子组织 schema
- [ ] 更新 _config.yml 添加导航链接
- [ ] 构建和部署

### 子网站 (develop.matrixlab.work)
- [ ] 在 Footer 添加主网站链接
- [ ] 在 About 页面添加 Matrix Lab 介绍
- [ ] 博客文章中引用主网站研究
- [ ] 确保 sitemap 包含所有页面
- [ ] 添加主网站到结构化数据

### SEO 工具
- [ ] Google Search Console 验证两个网站
- [ ] 提交两个网站的 sitemap
- [ ] 设置 Google Analytics
- [ ] 配置百度站长平台

### 内容
- [ ] 撰写整合公告文章
- [ ] 在两站发布
- [ ] 社交媒体宣传

---

## 🛠️ 技术实现

### 主网站添加子网站链接的代码

创建 `_includes/ecosystem-links.html`:

```html
<!-- Ecosystem Links -->
<div class="ecosystem-section" style="margin: 40px 0; padding: 30px; background: #f8f9fa; border-radius: 8px;">
  <h3 style="margin-top: 0;">🌐 Matrix Lab Ecosystem</h3>
  
  <div class="ecosystem-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-top: 20px;">
    
    <!-- Ke Entropy Technology -->
    <div class="ecosystem-card" style="padding: 20px; background: white; border-radius: 6px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
      <h4 style="margin-top: 0; color: #123456;">🏢 Ke Entropy Technology</h4>
      <p style="font-size: 14px; color: #666;">Blockchain security and Web3 solutions</p>
      <a href="https://develop.matrixlab.work" target="_blank" rel="noopener" style="display: inline-block; margin-top: 10px; padding: 8px 16px; background: #123456; color: white; text-decoration: none; border-radius: 4px; font-size: 14px;">
        Visit Website →
      </a>
    </div>
    
    <!-- MatrixTrace -->
    <div class="ecosystem-card" style="padding: 20px; background: white; border-radius: 6px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
      <h4 style="margin-top: 0; color: #123456;">🔍 MatrixTrace</h4>
      <p style="font-size: 14px; color: #666;">Blockchain analysis platform</p>
      <a href="https://develop.matrixlab.work/zh/products/trace" target="_blank" rel="noopener" style="display: inline-block; margin-top: 10px; padding: 8px 16px; background: #556e1e; color: white; text-decoration: none; border-radius: 4px; font-size: 14px;">
        Learn More →
      </a>
    </div>
    
    <!-- Technical Blog -->
    <div class="ecosystem-card" style="padding: 20px; background: white; border-radius: 6px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
      <h4 style="margin-top: 0; color: #123456;">📝 Technical Blog</h4>
      <p style="font-size: 14px; color: #666;">Latest insights and tutorials</p>
      <a href="https://develop.matrixlab.work/zh/blog" target="_blank" rel="noopener" style="display: inline-block; margin-top: 10px; padding: 8px 16px; background: #556e1e; color: white; text-decoration: none; border-radius: 4px; font-size: 14px;">
        Read Blog →
      </a>
    </div>
    
  </div>
</div>
```

---

## 📞 支持

如有问题，请查看：
- 主网站 SEO 文档: `SEO_README.md`
- 子网站 SEO 文档: `/home/ubuntu/yz/Web3/刻熵科技官网/SEO-QUICK-START.md`

---

**最后更新**: 2025-01-07  
**状态**: 待实施
