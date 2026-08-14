cask "flux-markdown" do
  version "1.34.475"
  sha256 "1deaaf9fa37b54f6cd5da3cd868c43fb6d9a85f99644d846d746f19104946f01"

  url "https://github.com/xykong/flux-markdown/releases/download/v#{version}/FluxMarkdown.dmg"
  name "FluxMarkdown"
  desc "Markdown previews in Finder QuickLook with diagrams and math"
  homepage "https://github.com/xykong/flux-markdown"

  livecheck do
    url "https://raw.githubusercontent.com/xykong/flux-markdown/master/appcast.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true
  depends_on macos: :big_sur
  depends_on formula: "duti"

  app "FluxMarkdown.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/FluxMarkdown.app"],
                   sudo: false

    lsregister = "/System/Library/Frameworks/CoreServices.framework" \
                 "/Frameworks/LaunchServices.framework/Support/lsregister"
    system_command lsregister,
                   args: ["-f", "#{appdir}/FluxMarkdown.app"],
                   sudo: false

    system_command "/usr/bin/qlmanage",
                   args: ["-r"],
                   sudo: false

    # Register the QuickLook extension directly via pluginkit.
    # This works in headless/non-GUI sessions (e.g. a different admin user running brew).
    # Replaces the previous `open --register-only` approach which required a GUI login
    # session and caused the entire installation to be rolled back on failure (issue #20).
    system_command "/usr/bin/pluginkit",
                   args: ["-a", "#{appdir}/FluxMarkdown.app/Contents/PlugIns/MarkdownPreview.appex"],
                   sudo: false

    # Set FluxMarkdown as the default handler for Markdown file types.
    # Use file extensions (.md, .markdown) rather than UTIs to avoid
    # "does not conform to any UTI hierarchy" errors on clean systems.
    duti_bin = ["/opt/homebrew/bin/duti", "/usr/local/bin/duti"].find { |p| File.exist?(p) }
    if duti_bin
      %w[.md .markdown].each do |ext|
        system_command duti_bin,
                       args:         ["-s", "com.xykong.Markdown", ext, "all"],
                       sudo:         false,
                       print_stderr: false
      end
    end
  end

  zap trash: [
    "~/Library/Application Scripts/com.xykong.Markdown",
    "~/Library/Application Scripts/com.xykong.Markdown.QuickLook",
    "~/Library/Containers/com.xykong.Markdown",
    "~/Library/Containers/com.xykong.Markdown.QuickLook",
  ]

  caveats <<~EOS
    FluxMarkdown has been set as the default app for .md and .markdown files.

    If the QuickLook extension does not work immediately:
      1. Run 'qlmanage -r' in Terminal.
      2. Restart Finder (Force Quit > Finder > Relaunch).
  EOS
end
