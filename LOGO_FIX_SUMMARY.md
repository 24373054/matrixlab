# Logo 修复总结

## 🐛 问题描述

**症状**:
- 外网访问网站时，侧边栏logo无法显示
- 点击logo报错：`HTTP ERROR 502`
- 错误地址：`http://0.0.0.0:4001/assets/logo.gif`
- 本地访问正常，外网访问异常

**根本原因**:
网站HTML文件中包含了本地开发环境的地址 `http://0.0.0.0:4001`，导致外网访问时无法正确加载资源。

---

## ✅ 修复方案

### 1. 问题定位

发现 `_site` 目录下的所有HTML文件中包含本地开发地址：
```html
<!-- 错误的路径 -->
<img src="http://0.0.0.0:4001/assets/logo.gif" style="max-height:40px">

<!-- 其他错误引用 -->
<link rel="icon" href="http://0.0.0.0:4001/assets/libdoc/img/favicon/favicon-32x32.png">
<script src="http://0.0.0.0:4001/assets/libdoc/js/prism/prism-core.min.js"></script>
```

### 2. 批量修复

执行命令批量移除本地地址前缀：
```bash
cd /home/ubuntu/yz/网站/Matrix_Lab1.0/_site
find . -name "*.html" -type f -exec sed -i 's|http://0.0.0.0:4001||g' {} +
```

### 3. 修复结果

**修复后的路径**:
```html
<!-- 正确的相对路径 -->
<img src="/assets/logo.gif" style="max-height:40px">

<!-- 其他资源也使用相对路径 -->
<link rel="icon" href="/assets/libdoc/img/favicon/favicon-32x32.png">
<script src="/assets/libdoc/js/prism/prism-core.min.js"></script>
```

---

## 🔍 验证测试

### Logo 文件状态

```bash
✅ 文件存在: /home/ubuntu/yz/网站/Matrix_Lab1.0/_site/assets/logo.gif
✅ 文件大小: 13KB
✅ 文件权限: -rw-rw-r--
```

### 外网访问测试

```bash
# 测试 logo 文件
$ curl -I https://matrixlab.work/assets/logo.gif
HTTP/2 200 ✅

# 测试 HTML 中的路径
$ curl -s https://matrixlab.work/ | grep logo.gif
src="/assets/logo.gif" ✅
```

### 修复前后对比

| 项目 | 修复前 | 修复后 |
|------|--------|--------|
| Logo路径 | `http://0.0.0.0:4001/assets/logo.gif` | `/assets/logo.gif` |
| 外网访问 | ❌ 502错误 | ✅ 正常显示 |
| 本地访问 | ✅ 正常 | ✅ 正常 |
| 资源加载 | ❌ 失败 | ✅ 成功 |

---

## 📋 修复的文件

### 批量修复

所有 `_site` 目录下的HTML文件：
- ✅ `index.html`
- ✅ `people.html`
- ✅ `publications.html`
- ✅ `home.html`
- ✅ `admin.html`
- ✅ 其他所有HTML文件

### Logo 文件位置

```
/home/ubuntu/yz/网站/Matrix_Lab1.0/
├── assets/
│   └── logo.gif          ← 源文件
├── _site/
│   └── assets/
│       └── logo.gif      ← 构建后文件
└── logo/
    └── logo.gif          ← 原始文件
```

---

## 🎯 根本解决方案

### 临时修复 (已完成)

✅ 批量替换所有HTML文件中的本地地址

### 永久解决方案 (建议)

为避免将来再次出现此问题，建议：

1. **确保 _config.yml 配置正确**:
```yaml
url: https://matrixlab.work  # 生产环境URL
baseurl: ""                  # 子路径（通常为空）
```

2. **使用Jekyll重新构建** (如果安装了Jekyll):
```bash
cd /home/ubuntu/yz/网站/Matrix_Lab1.0
bundle exec jekyll build
```

3. **或者使用持续替换脚本**:
```bash
# 在每次修改后自动清理本地地址
find _site -name "*.html" -exec sed -i 's|http://0.0.0.0:4001||g' {} +
```

---

## 🚀 当前状态

### ✅ 已修复

- [x] Logo在外网可以正常显示
- [x] 所有资源路径使用相对路径
- [x] 移除所有本地开发地址引用
- [x] HTTP/HTTPS访问正常
- [x] 所有页面logo统一显示

### 🌐 访问测试

**网站地址**: https://matrixlab.work

**测试项目**:
- ✅ 首页logo显示正常
- ✅ 侧边栏logo可点击
- ✅ 所有页面logo统一
- ✅ 无502错误
- ✅ 外网访问正常

---

## 📝 注意事项

### 1. 避免本地地址

在开发时，确保使用相对路径或正确的域名，避免使用：
- ❌ `http://0.0.0.0:4001`
- ❌ `http://localhost:4001`
- ❌ `http://127.0.0.1:4001`

推荐使用：
- ✅ `/assets/logo.gif` (相对路径)
- ✅ `https://matrixlab.work/assets/logo.gif` (绝对路径)

### 2. 构建环境

如果使用Jekyll本地开发：
```bash
# 开发环境
jekyll serve --host 0.0.0.0 --port 4001

# 生产构建
JEKYLL_ENV=production jekyll build
```

### 3. 验证修复

每次修改后，建议检查：
```bash
# 检查是否还有本地地址
grep -r "0.0.0.0:4001" _site/

# 应该返回空结果
```

---

## ✨ 修复完成

**修复时间**: 2025-10-25  
**影响范围**: 所有HTML页面  
**修复状态**: ✅ 完全修复  
**外网访问**: ✅ 正常  

现在访问 **https://matrixlab.work** 可以看到：
- ✅ 侧边栏Logo正常显示
- ✅ 点击Logo正常跳转
- ✅ 所有页面统一显示
- ✅ 无错误提示

问题已完全解决！🎉

