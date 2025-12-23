# Matrix Lab 网站服务管理脚本

## 📁 文件说明

### 可执行脚本
- `start` - 启动 Nginx 网站服务
- `stop` - 停止 Nginx 网站服务
- `restart` - 重启 Nginx 网站服务
- `status` - 查看网站服务状态

## 🚀 使用方法

### 1. 启动网站
```bash
cd /home/ubuntu/yz/网站/Matrix_Lab1.0/网站开启关闭快捷方式
./start
```

### 2. 停止网站
```bash
./stop
```

### 3. 重启网站
```bash
./restart
```

### 4. 查看状态
```bash
./status
```

## 📊 功能特点

- ✅ 自动检查服务状态
- ✅ 彩色输出和格式化信息
- ✅ 详细的日志记录（保存到 `/var/log/matrixlab-website-control.log`）
- ✅ 错误提示和故障排查指导
- ✅ 显示网站地址和访问日志

## 🌐 网站地址

- 主页: https://matrixlab.work
- Publications: https://matrixlab.work/publications.html
- People: https://matrixlab.work/people.html
- Admin Panel: https://matrixlab.work/admin-panel.html

## 📝 日志文件

### 服务控制日志
```bash
tail -f /var/log/matrixlab-website-control.log
```

### Nginx 访问日志
```bash
sudo tail -f /var/log/nginx/matrixlab_access.log
```

### Nginx 错误日志
```bash
sudo tail -f /var/log/nginx/matrixlab_error.log
```

## 🔧 常见操作

### 修改网站配置后重新加载
```bash
./restart
```

### 临时停止网站维护
```bash
./stop
# 进行维护操作
./start
```

### 检查网站是否正常运行
```bash
./status
```

## ⚠️ 注意事项

1. 停止网站后，所有用户将无法访问 https://matrixlab.work
2. 重启操作会有短暂的服务中断（约1-2秒）
3. 日志文件需要 sudo 权限查看
4. 如果服务启动失败，请检查 Nginx 配置文件是否正确

## 🔗 相关服务

- **后台管理服务**: `/home/ubuntu/yz/网站/Matrix_Lab1.0/后台开启关闭快捷方式/`
- **Nginx 配置**: `/etc/nginx/sites-available/matrixlab.conf`
- **网站文件**: `/home/ubuntu/yz/网站/Matrix_Lab1.0/_site/`

