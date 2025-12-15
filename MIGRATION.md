# Tap 重命名迁移指南

## 更改说明

为了提供更好的用户体验，我们将 tap 名称从 `homebrew-xykong` 重命名为 `homebrew-tap`。

### 更改前后对比

| 项目 | 旧名称 | 新名称 |
|------|--------|--------|
| 仓库名 | `homebrew-xykong` | `homebrew-tap` |
| Tap 命令 | `brew tap xykong/xykong` | `brew tap xykong/tap` |
| Formula 引用 | `xykong/xykong/macos-sensor-exporter` | `xykong/tap/macos-sensor-exporter` |
| Service 命令 | `brew services start xykong/xykong/macos-sensor-exporter` | `brew services start xykong/tap/macos-sensor-exporter` |

### 优势

✅ **更简洁**: `brew tap xykong/tap` 比 `brew tap xykong/xykong` 更短、更易读  
✅ **避免冗余**: 不再重复用户名  
✅ **更专业**: 符合 Homebrew 社区的常见命名习惯  
✅ **更通用**: `tap` 名称表明这是一个通用的 formula 集合

## 迁移步骤

如果你之前使用过旧的 tap 名称，请按以下步骤迁移：

### 1. 移除旧的 tap

```bash
brew untap xykong/xykong
```

### 2. 添加新的 tap

```bash
# 从 GitHub 添加（推荐）
brew tap xykong/tap

# 或者本地开发
brew tap xykong/tap /Users/xykong/workspace/xykong/macos-sensor-exporter-project/homebrew-tap
```

### 3. 重新安装或更新

```bash
# 如果已经安装，可以继续使用（不影响）
# 或者重新安装以确保使用新的 tap
brew reinstall xykong/tap/macos-sensor-exporter
```

### 4. 更新服务引用（如果使用了 brew services）

```bash
# 停止旧服务
brew services stop macos-sensor-exporter

# 启动新服务
brew services start xykong/tap/macos-sensor-exporter
```

## GitHub 仓库重命名

如果你需要在 GitHub 上重命名仓库：

1. 进入 GitHub 仓库设置页面
2. 在 "Repository name" 部分，将 `homebrew-xykong` 改为 `homebrew-tap`
3. 点击 "Rename" 按钮
4. GitHub 会自动设置重定向，旧的 URL 仍然可以访问

### 更新本地 Git remote

```bash
cd /Users/xykong/workspace/xykong/macos-sensor-exporter-project/homebrew-tap

# 查看当前 remote
git remote -v

# 如果需要更新 remote URL（假设重命名后的仓库地址）
git remote set-url origin https://github.com/xykong/homebrew-tap.git
# 或者使用 SSH
git remote set-url origin git@github.com:xykong/homebrew-tap.git
```

## 常见问题

### Q: 我已经安装了 macos-sensor-exporter，需要重新安装吗？

A: 不需要。已安装的软件可以继续正常使用。只是在将来安装或更新时使用新的 tap 名称。

### Q: brew services 会受影响吗？

A: 不会。如果服务已经在运行，可以继续使用。在重启服务时使用新的名称即可。

### Q: 旧的 tap 还能用吗？

A: 如果你移除了旧的 tap (`brew untap xykong/xykong`)，就无法再使用旧名称。建议迁移到新名称。

### Q: 这会影响已经部署的系统吗？

A: 不会。这只是命名的更改，不影响已安装软件的功能。

## 相关链接

- [README.md](README.md) - 使用说明
- [INSTALL_GUIDE.md](INSTALL_GUIDE.md) - 安装指南
- [GitHub: homebrew-tap](https://github.com/xykong/homebrew-tap)
