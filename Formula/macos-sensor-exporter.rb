class MacosSensorExporter < Formula
  desc "Prometheus exporter for macOS hardware sensors"
  homepage "https://github.com/xykong/macos-sensor-exporter"
  version "1.1.0"
  license "MIT"

  on_arm do
    url "https://github.com/xykong/macos-sensor-exporter/releases/download/v1.1.0/macos-sensor-exporter_1.1.0_Darwin_arm64.tar.gz"
    sha256 "1160c195442373c60891ea342b02b3d363a33ed90016a151e8638942edf88c12"
  end

  on_intel do
    url "https://github.com/xykong/macos-sensor-exporter/releases/download/v1.1.0/macos-sensor-exporter_1.1.0_Darwin_x86_64.tar.gz"
    sha256 "8f4a4d09fb84c2c11c8868eb3911982e3d6642d16897fdfc3803ff38038b7103"
  end

  depends_on :macos

  def install
    bin.install "macos-sensor-exporter"
  end

  def caveats
    <<~EOS
      To start the exporter:
        macos-sensor-exporter start

      To run as a service:
        brew services start macos-sensor-exporter

      To view sensor data:
        macos-sensor-exporter show
    EOS
  end

  service do
    run [opt_bin/"macos-sensor-exporter", "start"]
    keep_alive true
    log_path var/"log/macos-sensor-exporter.log"
    error_log_path var/"log/macos-sensor-exporter.log"
    working_dir var
  end
end
