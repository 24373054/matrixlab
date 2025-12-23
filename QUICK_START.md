# Matrix Lab 快速开始指南

## 🎉 部署成功！

您的网站已经成功部署并运行在 HTTPS 生产环境中。

---

## 🌐 访问地址

| 服务 | 地址 | 说明 |
|------|------|------|
| **网站首页** | https://matrixlab.work | 主网站 |
| **管理面板** | https://matrixlab.work/admin.html | 管理员后台 |
| **API 文档** | https://matrixlab.work/api/health | API 健康检查 |

---

## 🔑 管理员登录信息

```
管理面板: https://matrixlab.work/admin.html
用户名: admin
密码: matrixlab2025
```

---

## ⚡ 常用命令

### 查看服务状态
```bash
cd /home/ubuntu/yz/网站/Matrix_Lab1.0
./manage.sh status
```

### 重启所有服务
```bash
./manage.sh restart
```

### 查看日志
```bash
./manage.sh logs
```

### 测试连接
```bash
./manage.sh test
```

---

## 🛠️ 服务管理

### Nginx (网站服务器)
```bash
sudo systemctl status nginx    # 查看状态
sudo systemctl restart nginx   # 重启
sudo systemctl reload nginx    # 重新加载配置
```

### 管理员后端
```bash
sudo systemctl status matrixlab-admin    # 查看状态
sudo systemctl restart matrixlab-admin   # 重启
```

---

## 📝 日志文件

```bash
# Nginx 日志
sudo tail -f /var/log/nginx/matrixlab_access.log
sudo tail -f /var/log/nginx/matrixlab_error.log

# 后端日志
sudo tail -f /var/log/matrixlab-admin.log
sudo tail -f /var/log/matrixlab-admin-error.log
```

---

## 🔧 配置文件位置

- **Nginx 配置**: `/etc/nginx/sites-available/matrixlab.work`
- **网站文件**: `/home/ubuntu/yz/网站/Matrix_Lab1.0/_site/`
- **SSL 证书**: `/home/ubuntu/yz/网站/Matrix_Lab1.0/matrixlab.work_nginx/`
- **后端代码**: `/home/ubuntu/yz/网站/Matrix_Lab1.0/admin-server.py`

---

## 🚨 紧急命令

### 停止所有服务
```bash
./manage.sh stop
```

### 启动所有服务
```bash
./manage.sh start
```

### 查看错误日志
```bash
sudo tail -50 /var/log/nginx/matrixlab_error.log
sudo tail -50 /var/log/matrixlab-admin-error.log
```

---

## 📚 完整文档

- **部署总结**: `cat DEPLOYMENT_SUMMARY.md`
- **生产环境指南**: `cat PRODUCTION_GUIDE.md`

---

## ✅ 快速检查清单

- [ ] 网站可以访问: https://matrixlab.work
- [ ] HTTPS 证书正常
- [ ] 管理面板可以打开
- [ ] API 响应正常
- [ ] 服务已设置开机自启

---

## 💡 提示

1. 所有 HTTP 请求会自动重定向到 HTTPS
2. 服务已配置开机自启，无需手动启动
3. 使用 `./manage.sh` 可以方便地管理所有服务
4. 建议定期查看日志，确保服务正常运行

---

祝您使用愉快！🎊

有问题请查看完整文档: `cat DEPLOYMENT_SUMMARY.md`

