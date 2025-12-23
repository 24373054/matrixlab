# Matrix Lab 生产环境 HTTPS 部署指南

## 🎉 部署完成！

您的网站已成功部署并启用了 HTTPS！

**网站地址**: https://matrixlab.work

---

## 📋 配置信息

### SSL 证书
- **证书文件**: `/home/ubuntu/yz/网站/Matrix_Lab1.0/matrixlab.work_nginx/matrixlab.work_bundle.crt`
- **私钥文件**: `/home/ubuntu/yz/网站/Matrix_Lab1.0/matrixlab.work_nginx/matrixlab.work.key`
- **证书类型**: TLS 1.2 / 1.3

### Nginx 配置
- **配置文件**: `/etc/nginx/sites-available/matrixlab.work`
- **网站根目录**: `/home/ubuntu/yz/网站/Matrix_Lab1.0/_site`
- **HTTP 端口**: 80 (自动重定向到 HTTPS)
- **HTTPS 端口**: 443

### 域名解析
- **主域名**: matrixlab.work → 140.143.183.163
- **www子域名**: www.matrixlab.work → 140.143.183.163

---

## 🚀 服务管理

### 使用管理脚本

项目提供了便捷的管理脚本：`production_server.sh`

```bash
# 查看服务状态
sudo ./production_server.sh status

# 启动服务
sudo ./production_server.sh start

# 停止服务
sudo ./production_server.sh stop

# 重启服务
sudo ./production_server.sh restart

# 重新加载配置（无需重启）
sudo ./production_server.sh reload

# 查看日志
sudo ./production_server.sh logs

# 测试连接
sudo ./production_server.sh test
```

### 直接使用 systemctl

```bash
# 查看状态
sudo systemctl status nginx

# 启动服务
sudo systemctl start nginx

# 停止服务
sudo systemctl stop nginx

# 重启服务
sudo systemctl restart nginx

# 重新加载配置
sudo systemctl reload nginx
```

---

## 🔍 检查和测试

### 1. 检查服务状态
```bash
sudo systemctl status nginx
```

### 2. 检查端口监听
```bash
sudo netstat -tlnp | grep nginx
```

应该看到：
- 0.0.0.0:80 (HTTP)
- 0.0.0.0:443 (HTTPS)

### 3. 测试 HTTPS 访问
```bash
# 测试 HTTPS
curl -I https://matrixlab.work

# 测试 HTTP 重定向
curl -I http://matrixlab.work
```

### 4. 浏览器访问
直接在浏览器中访问：https://matrixlab.work

---

## 📝 日志文件

### 访问日志
```bash
# 查看访问日志
sudo tail -f /var/log/nginx/matrixlab_access.log

# 查看最近100行
sudo tail -100 /var/log/nginx/matrixlab_access.log
```

### 错误日志
```bash
# 实时查看错误日志
sudo tail -f /var/log/nginx/matrixlab_error.log

# 查看最近的错误
sudo tail -100 /var/log/nginx/matrixlab_error.log
```

---

## 🔧 常见操作

### 更新网站内容

1. 修改源文件（markdown、html等）
2. 重新构建网站（如果使用 Jekyll）
   ```bash
   cd /home/ubuntu/yz/网站/Matrix_Lab1.0
   bundle exec jekyll build
   ```
3. Nginx 会自动提供更新后的文件

### 修改 Nginx 配置

1. 编辑配置文件：
   ```bash
   sudo nano /etc/nginx/sites-available/matrixlab.work
   ```

2. 测试配置：
   ```bash
   sudo nginx -t
   ```

3. 重新加载配置：
   ```bash
   sudo systemctl reload nginx
   ```

### 更新 SSL 证书

1. 替换证书文件：
   ```bash
   # 备份旧证书
   sudo cp /home/ubuntu/yz/网站/Matrix_Lab1.0/matrixlab.work_nginx/matrixlab.work_bundle.crt{,.bak}
   
   # 复制新证书
   # ...
   ```

2. 重新加载 Nginx：
   ```bash
   sudo systemctl reload nginx
   ```

---

## 🔐 安全特性

### 已启用的安全特性：

✅ **SSL/TLS 加密**: TLSv1.2 和 TLSv1.3  
✅ **HTTP 自动重定向**: 所有 HTTP 请求自动重定向到 HTTPS  
✅ **HTTP/2 支持**: 提升性能  
✅ **安全头部**:
- X-Frame-Options: SAMEORIGIN
- X-Content-Type-Options: nosniff
- X-XSS-Protection: 1; mode=block
- Referrer-Policy: no-referrer-when-downgrade

✅ **静态资源缓存**: 图片、CSS、JS 等文件启用 1 年缓存  
✅ **隐藏文件保护**: 禁止访问以 . 开头的文件

---

## 🆘 故障排查

### 网站无法访问

1. 检查 Nginx 服务状态：
   ```bash
   sudo systemctl status nginx
   ```

2. 检查错误日志：
   ```bash
   sudo tail -50 /var/log/nginx/matrixlab_error.log
   ```

3. 检查端口是否被占用：
   ```bash
   sudo netstat -tlnp | grep -E ':(80|443)'
   ```

### 403 Forbidden 错误

检查文件权限：
```bash
sudo chmod -R 755 /home/ubuntu/yz/网站/Matrix_Lab1.0/_site
```

### 证书错误

1. 检查证书文件是否存在：
   ```bash
   ls -l /home/ubuntu/yz/网站/Matrix_Lab1.0/matrixlab.work_nginx/
   ```

2. 测试 Nginx 配置：
   ```bash
   sudo nginx -t
   ```

---

## 📊 性能优化

### 已配置的优化：

- ✅ HTTP/2 协议
- ✅ Gzip 压缩（Nginx 默认）
- ✅ 静态资源缓存
- ✅ SSL 会话缓存

### 可选优化：

如需进一步优化，可以：
1. 启用 Brotli 压缩
2. 配置 CDN
3. 启用页面缓存

---

## 🔄 开机自启

Nginx 已设置为开机自动启动，无需手动干预。

检查自启状态：
```bash
sudo systemctl is-enabled nginx
```

---

## 📞 支持信息

### 相关文件位置

- **项目目录**: `/home/ubuntu/yz/网站/Matrix_Lab1.0`
- **网站文件**: `/home/ubuntu/yz/网站/Matrix_Lab1.0/_site`
- **SSL 证书**: `/home/ubuntu/yz/网站/Matrix_Lab1.0/matrixlab.work_nginx`
- **Nginx 配置**: `/etc/nginx/sites-available/matrixlab.work`
- **管理脚本**: `/home/ubuntu/yz/网站/Matrix_Lab1.0/production_server.sh`

### 有用的命令

```bash
# 查看 Nginx 版本
nginx -v

# 查看 Nginx 编译参数
nginx -V

# 查看当前连接数
ss -s

# 查看服务器资源使用
htop
```

---

## ✨ 完成！

您的网站现在已经：
- ✅ 启用 HTTPS 安全访问
- ✅ 支持 HTTP/2 协议
- ✅ 配置了自动重定向
- ✅ 设置了开机自启
- ✅ 具备完善的安全防护

**访问您的网站**: https://matrixlab.work

祝您使用愉快！🎊

