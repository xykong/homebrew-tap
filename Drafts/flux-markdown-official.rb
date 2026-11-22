cask "flux-markdown" do
  version "1.59.907"
  sha256 "a1f9fb122e2fe1ff29bfc4c4ed84503ce68da67620f2ebc7a2acbe0c5eacd488"

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
