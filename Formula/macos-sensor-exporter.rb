class MacosSensorExporter < Formula
  desc "Prometheus exporter for macOS hardware sensors"
  homepage "https://github.com/xykong/macos-sensor-exporter"
  url "https://github.com/xykong/macos-sensor-exporter.git",
      tag:      "v0.1.0",
      revision: "HEAD"
  license "MIT"
  head "https://github.com/xykong/macos-sensor-exporter.git", branch: "main"

  depends_on "go" => :build
  depends_on :macos

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}")
  end

  service do
    run [opt_bin/"macos-sensor-exporter", "start"]
    keep_alive true
    log_path var/"log/macos-sensor-exporter.log"
    error_log_path var/"log/macos-sensor-exporter.log"
    working_dir var
  end

  test do
    # 测试二进制文件是否能正常运行
    assert_match "macos-sensor-exporter", shell_output("#{bin}/macos-sensor-exporter --help")
    
    # 测试 show 命令
    system "#{bin}/macos-sensor-exporter", "show", "-o", "json"
  end
end
