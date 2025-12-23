# Admin Panel 访问说明

## 📅 更新日期：2025年10月25日

---

## 🔐 访问方式

Admin Panel 已从主页侧边栏移除，仅支持通过直接URL访问，增强安全性。

### 访问地址

```
https://matrixlab.work/admin-panel.html
```

**注意**：此地址不会在主页上显示，需要手动输入或收藏。

---

## 🚀 后台服务管理

### 启动后台服务

```bash
cd /home/ubuntu/yz/网站/Matrix_Lab1.0/后台开启关闭快捷方式
./start
```

### 停止后台服务

```bash
cd /home/ubuntu/yz/网站/Matrix_Lab1.0/后台开启关闭快捷方式
./stop
```

### 查看服务状态

```bash
sudo systemctl status matrixlab-admin
```

---

## 🔑 登录凭据

**存储位置**：`admin-server.py` 文件中

```python
ADMIN_CREDENTIALS = {
    'username': 'admin',
    'password': 'matrixlab2025'
}
```

**安全建议**：建议定期修改密码

---

## 📋 功能说明

### Admin Panel 提供的功能

1. **出版物管理**
   - 添加新出版物
   - 编辑现有出版物
   - 删除出版物
   - 查看所有出版物

2. **实时统计**
   - 总出版物数量
   - 最近出版物数量
   - 实时数据更新

3. **安全认证**
   - Bearer Token 认证
   - 自动Token管理
   - 安全的API调用

---

## ⚠️ 注意事项

### 1. 访问限制

- Admin Panel 不在主页显示
- 仅通过直接URL访问
- 提高安全性

### 2. 服务管理

- 不需要管理功能时，停止后台服务以提升网站速度
- 需要管理时，运行 `./start` 启动后台
- 管理完成后，运行 `./stop` 停止后台

### 3. API超时设置

- 后台关闭时，页面会在3秒后显示服务不可用提示
- 避免长时间等待
- 提供友好的错误信息

---

## 🌐 网站结构

### 公开页面（主页侧边栏显示）

- Home - 主页
- People - 团队成员
- Publications - 出版物列表
- View on GitHub - GitHub仓库

### 管理页面（仅通过URL访问）

- Admin Panel - 后台管理
  - URL: https://matrixlab.work/admin-panel.html
  - 不在侧边栏显示
  - 需要登录认证

---

## 🔧 技术细节

### 后台架构

- **服务器**：Python Flask
- **端口**：3003
- **服务名**：matrixlab-admin
- **日志位置**：
  - `/var/log/matrixlab-admin.log`
  - `/var/log/matrixlab-admin-error.log`

### 前端特性

- 单页面应用（SPA）
- 响应式设计
- 实时数据更新
- 3秒API超时机制

### Nginx配置

- 静态文件：直接服务
- API请求：代理到 Flask 后端
- 缓存策略：5分钟缓存

---

## 📝 使用流程

### 完整管理流程

1. **启动后台服务**
   ```bash
   cd 后台开启关闭快捷方式 && ./start
   ```

2. **访问管理面板**
   - 打开浏览器
   - 输入：`https://matrixlab.work/admin-panel.html`

3. **登录系统**
   - 用户名：admin
   - 密码：matrixlab2025

4. **管理出版物**
   - 添加/编辑/删除出版物
   - 查看统计信息

5. **完成后停止服务**
   ```bash
   cd 后台开启关闭快捷方式 && ./stop
   ```

---

## 🛡️ 安全措施

### 已实施的安全措施

1. **隐藏入口**
   - 不在主页显示链接
   - 需要知道确切URL

2. **认证机制**
   - Bearer Token认证
   - 密码加密存储

3. **API保护**
   - 所有管理操作需要Token
   - 超时自动断开

4. **按需运行**
   - 不使用时关闭后台
   - 降低攻击面

### 建议的额外措施

1. **定期更换密码**
2. **限制IP访问**（如需要）
3. **启用HTTPS**（已启用）
4. **监控访问日志**

---

## 📚 相关文档

- `ADMIN_PANEL_FIX.md` - Admin Panel延迟问题修复
- `ADMIN_PANEL_OPTIMIZATION.md` - 性能优化详情
- `DEPLOYMENT_SUMMARY.md` - 完整部署文档
- `后台开启关闭快捷方式/README.md` - 快捷脚本使用说明

---

## 💬 常见问题

### Q: 为什么Admin Panel不在主页显示？

**A**: 为了增强安全性，管理后台仅通过直接URL访问，避免暴露在公开页面。

### Q: 如何找到Admin Panel？

**A**: 直接访问 `https://matrixlab.work/admin-panel.html` 或收藏此地址。

### Q: 后台服务必须一直运行吗？

**A**: 不需要。只有在管理出版物时才需要启动，平时可以关闭以提升网站速度。

### Q: 如果忘记密码怎么办？

**A**: 查看 `admin-server.py` 文件中的 `ADMIN_CREDENTIALS` 配置。

---

*最后更新：2025-10-25 23:20*

