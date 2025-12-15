# homebrew-tap

xykong 的 Homebrew tap，包含自定义的 formula。

## 如何使用

### 添加 tap

```bash
brew tap xykong/tap
```

如果是本地开发，可以添加本地 tap：

```bash
brew tap xykong/tap /Users/xykong/workspace/xykong/macos-sensor-exporter-project/homebrew-tap
```

### 安装软件

#### macos-sensor-exporter

Prometheus exporter for macOS hardware sensors（macOS 硬件传感器的 Prometheus 导出器）

**安装：**

```bash
brew install macos-sensor-exporter
```

**使用：**

```bash
# 查看传感器信息
macos-sensor-exporter show

# 启动 exporter 服务器
macos-sensor-exporter start

# 使用 brew service 管理（推荐）
brew services start xykong/tap/macos-sensor-exporter

# 查看服务状态
brew services list

# 停止服务
brew services stop xykong/tap/macos-sensor-exporter

# 重启服务
brew services restart xykong/tap/macos-sensor-exporter
```

**配置：**

服务日志位置：`/usr/local/var/log/macos-sensor-exporter.log`

默认配置：
- 端口：9101
- 路径：/metrics
- 健康检查：/healthz

**Prometheus 配置：**

```yaml
scrape_configs:
  - job_name: 'macos-sensors'
    static_configs:
      - targets: ['localhost:9101']
```

## 开发

### 本地测试 formula

```bash
# 安装本地 formula
brew install --build-from-source ./Formula/macos-sensor-exporter.rb

# 测试 formula
brew test macos-sensor-exporter

# 审计 formula
brew audit --strict xykong/tap/macos-sensor-exporter
```

### 更新 formula

当上游项目有新版本时，更新 formula 中的 `tag` 和 `revision`。

## License

MIT
