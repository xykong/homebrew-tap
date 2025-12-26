cask "markdown-preview-enhanced" do
  version "1.0.0"
  sha256 :no_check

  url "https://github.com/xykong/markdown-quicklook/releases/download/v#{version}/MarkdownPreviewEnhanced.dmg"
  name "Markdown Preview Enhanced"
  desc "Markdown Preview Enhanced for macOS QuickLook"
  homepage "https://github.com/xykong/markdown-quicklook"

  app "Markdown Preview Enhanced.app"

  zap trash: [
    "~/Library/Application Scripts/com.xykong.Markdown",
    "~/Library/Containers/com.xykong.Markdown",
    "~/Library/Application Scripts/com.xykong.Markdown.QuickLook",
    "~/Library/Containers/com.xykong.Markdown.QuickLook",
  ]
end