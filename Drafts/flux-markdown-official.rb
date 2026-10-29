cask "flux-markdown" do
  version "1.42.645"
  sha256 "228e6065117584ce88056b1d126cc4b5988a661ac0b6a2072735ce4e80996d1a"

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
