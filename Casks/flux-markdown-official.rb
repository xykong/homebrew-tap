cask "flux-markdown-official" do
  version "1.33.436"
  sha256 "8f30de561e01ee59d743f4b07f935f25f424546544f4d09c68bc38e8b19a6a91"

  url "https://github.com/xykong/flux-markdown/releases/download/v#{version}/FluxMarkdown.dmg"
  name "FluxMarkdown"
  desc "Markdown previews in Finder QuickLook with diagrams and math"
  homepage "https://github.com/xykong/flux-markdown"

  livecheck do
    url :stable
    strategy :github_latest
  end

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

    system_command "/usr/bin/pluginkit",
                   args: ["-a", "#{appdir}/FluxMarkdown.app/Contents/PlugIns/MarkdownPreview.appex"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Scripts/com.xykong.Markdown",
    "~/Library/Application Scripts/com.xykong.Markdown.QuickLook",
    "~/Library/Containers/com.xykong.Markdown",
    "~/Library/Containers/com.xykong.Markdown.QuickLook",
  ]

  caveats <<~EOS
    If the QuickLook extension does not work immediately:
      1. Run 'qlmanage -r' in Terminal.
      2. Restart Finder (Force Quit > Finder > Relaunch).
  EOS
end
