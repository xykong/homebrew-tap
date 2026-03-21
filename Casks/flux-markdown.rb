cask 'flux-markdown' do
  version '1.19.253'
  sha256 '17962558da62ae0bf26a1dd4e43d2521bff13063796a75e8ae3ba31a12eed5a0'

  url "https://github.com/xykong/flux-markdown/releases/download/v#{version}/FluxMarkdown.dmg"
  name 'FluxMarkdown'
  desc 'Beautiful Markdown previews in macOS Finder QuickLook'
  homepage 'https://github.com/xykong/flux-markdown'

  auto_updates true

  livecheck do
    url 'https://raw.githubusercontent.com/xykong/flux-markdown/master/appcast.xml'
    strategy :sparkle, &:short_version
  end

  app 'FluxMarkdown.app'

  postflight do
    system_command '/usr/bin/xattr',
                   args: ['-cr', "#{appdir}/FluxMarkdown.app"],
                   sudo: false

    system_command '/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister',
                   args: ['-f', "#{appdir}/FluxMarkdown.app"],
                   sudo: false

    system_command '/usr/bin/qlmanage',
                   args: ['-r'],
                   sudo: false

    # Open the app in background to trigger QuickLook extension registration
    system_command '/usr/bin/open',
                   args: ['-g', "#{appdir}/FluxMarkdown.app", '--args', '--register-only'],
                   sudo: false
  end

  caveats <<~EOS
    If the QuickLook extension does not work immediately:
      1. Run 'qlmanage -r' in Terminal.
      2. Restart Finder (Force Quit > Finder > Relaunch).
      3. Set 'FluxMarkdown.app' as the default app for .md files.
  EOS

  zap trash: [
    '~/Library/Application Scripts/com.xykong.Markdown',
    '~/Library/Containers/com.xykong.Markdown',
    '~/Library/Application Scripts/com.xykong.Markdown.QuickLook',
    '~/Library/Containers/com.xykong.Markdown.QuickLook'
  ]
end
