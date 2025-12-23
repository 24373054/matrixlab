# Matrix Lab 后台管理快捷脚本

## 📋 功能说明

本目录包含一键启动和停止管理后台服务的快捷脚本，方便快速管理网站后台功能。

## 🚀 使用方法

### 启动管理后台

```bash
./start
```

启动后，可以通过以下地址访问：
- 管理面板: https://matrixlab.work/admin-panel.html
- API 健康检查: https://matrixlab.work/api/health

### 停止管理后台

```bash
./stop
```

停止后台服务可以释放服务器资源，提升网站访问速度。

## 💡 使用建议

1. **日常访问**：如果不需要使用管理功能，可以停止后台服务以提升网站速度
2. **管理时启动**：需要管理出版物时，运行 `./start` 启动后台
3. **管理完停止**：管理操作完成后，运行 `./stop` 停止后台

## 📊 查看服务状态

```bash
sudo systemctl status matrixlab-admin
```

## 📝 查看日志

```bash
# 实时查看日志
sudo journalctl -u matrixlab-admin -f

# 查看最近50条日志
sudo journalctl -u matrixlab-admin -n 50
```

## ⚠️ 注意事项

- 脚本需要 sudo 权限执行系统命令
- 停止后台不会影响主网站的访问
- 启动失败时会自动显示错误日志

