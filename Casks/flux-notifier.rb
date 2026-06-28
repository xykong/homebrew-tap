cask "flux-notifier" do
  version "0.1.0"
  sha256 "3237a4fc7756fd0301c13a2766cb48fdde26f08d5412ee970b105fdb9be84824"

  url "https://github.com/xykong/flux-notifier/releases/download/v#{version}/FluxNotifier.zip"
  name "FluxNotifier"
  desc "AI event notification system — push to all your devices from any AI program"
  homepage "https://github.com/xykong/flux-notifier"

  depends_on macos: :ventura

  app "FluxNotifier.app"

  zap trash: [
    "~/.flux-notifier",
    "~/Library/Application Support/FluxNotifier",
    "~/Library/Caches/dev.flux-notifier.app",
    "~/Library/Preferences/dev.flux-notifier.app.plist",
  ]

  caveats <<~EOS
    FluxNotifier runs as a Menu Bar app (no Dock icon).

    After installation, launch it once to start the notification listener:
      open /Applications/FluxNotifier.app

    To enable at login: click the Menu Bar icon → Preferences → Launch at Login.

    Install the Python CLI to send notifications:
      pip install flux-notifier
      # or
      uv tool install flux-notifier
  EOS
end
