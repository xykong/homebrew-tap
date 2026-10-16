cask "flux-markdown" do
  version "1.36.561"
  sha256 "9c3eda663958094aea858cef2c2b8a378dd91f5b6658446d58899892ae18b0f7"

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

  # The vendor script owns application placement and registration. There is no
  # app artifact whose later execution could overwrite the registered bundle.
  installer script: {
    executable: "install-flux-markdown.sh",
    args:       ["--source", "#{staged_path}/FluxMarkdown.app", "--appdir", appdir.to_s],
    sudo:       false,
  }

  uninstall delete: "#{appdir}/FluxMarkdown.app"

  zap trash: [
    "~/Library/Application Support/FluxMarkdown",
    "~/Library/Containers/com.xykong.Markdown",
    "~/Library/Containers/com.xykong.Markdown.QuickLook",
  ]

  caveats <<~EOS
    Existing Markdown editor preferences are preserved.
    If previews need recovery, use FluxMarkdown → Help → Repair Quick Look.
  EOS
end
