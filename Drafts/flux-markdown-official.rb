cask "flux-markdown" do
  version "1.35.525"
  sha256 "abba51a66a00f7b914c4d0d80940d2ecd2358867e0c215bc5ecac93ba6d45c6d"

  url "https://github.com/xykong/flux-markdown/releases/download/v#{version}/FluxMarkdown.dmg"
  name "FluxMarkdown"
  desc "Markdown previews in Finder QuickLook with diagrams and math"
  homepage "https://github.com/xykong/flux-markdown"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on macos: :big_sur

  app "FluxMarkdown.app"

  # Requires a signed/notarized release before official submission.
  # App placement uses Homebrew's supported artifact; repair is available in-app.

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
