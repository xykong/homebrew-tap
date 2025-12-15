# macos-sensor-exporter 安装指南

## 快速开始

### 1. 添加本地 tap（开发环境）

```bash
brew tap xykong/tap /Users/xykong/workspace/xykong/macos-sensor-exporter-project/homebrew-tap
```

### 2. 安装 macos-sensor-exporter

```bash
# 从 HEAD 安装（最新开发版本）
brew install --HEAD xykong/tap/macos-sensor-exporter

# 或者从 stable 版本安装（需要先打 tag）
brew install xykong/tap/macos-sensor-exporter
```

### 3. 使用

#### 方式一：直接运行

```bash
# 查看传感器信息
macos-sensor-exporter show

# 以表格形式显示
macos-sensor-exporter show -o table

# 以 JSON 格式显示
macos-sensor-exporter show -o json

# 启动 exporter 服务器
macos-sensor-exporter start

# 自定义端口
macos-sensor-exporter start --port 8080
```

#### 方式二：使用 brew services（推荐）

```bash
# 启动服务（开机自动启动）
brew services start xykong/tap/macos-sensor-exporter

# 查看服务状态
brew services list

# 停止服务
brew services stop xykong/tap/macos-sensor-exporter

# 重启服务
brew services restart xykong/tap/macos-sensor-exporter

# 查看日志
tail -f /usr/local/var/log/macos-sensor-exporter.log
# 或者在 Apple Silicon 上：
tail -f /opt/homebrew/var/log/macos-sensor-exporter.log
```

### 4. 测试

```bash
# 测试 exporter 是否正常运行
curl http://localhost:9101/metrics

# 健康检查
curl http://localhost:9101/healthz
```

### 5. Prometheus 配置

在你的 `prometheus.yml` 中添加：

```yaml
scrape_configs:
  - job_name: 'macos-sensors'
    static_configs:
      - targets: ['localhost:9101']
```

### 6. 卸载

```bash
# 停止服务
brew services stop xykong/tap/macos-sensor-exporter

# 卸载
brew uninstall macos-sensor-exporter

# 移除 tap
brew untap xykong/tap
```

## 开发者指南

### 推送到远程仓库

```bash
cd /Users/xykong/workspace/xykong/macos-sensor-exporter-project/homebrew-tap
git push origin master
```

### 使用远程 tap

一旦推送到 GitHub，用户可以这样使用：

```bash
# 添加远程 tap
brew tap xykong/tap

# 安装
brew install macos-sensor-exporter

# 使用 brew services
brew services start macos-sensor-exporter
```

### 更新 formula

当 macos-sensor-exporter 有新版本时：

1. 在 macos-sensor-exporter 项目中打 tag：
   ```bash
   cd /Users/xykong/workspace/xykong/macos-sensor-exporter-project/macos-sensor-exporter
   git tag -a v0.2.0 -m "Release v0.2.0"
   git push origin v0.2.0
   ```

2. 更新 formula 中的版本号：
   ```ruby
   url "https://github.com/xykong/macos-sensor-exporter.git",
       tag:      "v0.2.0",
       revision: "<commit-sha>"
   ```

3. 提交并推送：
   ```bash
   cd /Users/xykong/workspace/xykong/macos-sensor-exporter-project/homebrew-tap
   git add Formula/macos-sensor-exporter.rb
   git commit -m "Update macos-sensor-exporter to v0.2.0"
   git push origin master
   ```

### 测试 formula

```bash
# 语法检查
brew audit --strict --online xykong/tap/macos-sensor-exporter

# 测试安装
brew install --build-from-source xykong/tap/macos-sensor-exporter

# 运行测试
brew test xykong/tap/macos-sensor-exporter
```

## 故障排查

### 无法找到 formula

```bash
# 更新 tap
brew update

# 检查 tap 是否正确添加
brew tap

# 重新添加 tap
brew untap xykong/tap
brew tap xykong/tap
```

### 构建失败

```bash
# 清理缓存
brew cleanup -s

# 重新安装
brew reinstall --build-from-source xykong/tap/macos-sensor-exporter
```

### 服务无法启动

```bash
# 查看日志
tail -f $(brew --prefix)/var/log/macos-sensor-exporter.log

# 检查端口是否被占用
lsof -i :9101

# 手动运行查看错误
macos-sensor-exporter start -v
```

## 相关链接

- [macos-sensor-exporter GitHub](https://github.com/xykong/macos-sensor-exporter)
- [Homebrew 文档](https://docs.brew.sh/)
- [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
