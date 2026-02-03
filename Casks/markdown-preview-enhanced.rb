cask 'markdown-preview-enhanced' do
  version '1.6.99'
  sha256 'b533010c57e7882cfa6e03b0b96ec18347ea1d7260811dcb37828a6194e06a7c'

  url "https://github.com/xykong/markdown-quicklook/releases/download/v#{version}/MarkdownPreviewEnhanced.dmg"
  name 'Markdown Preview Enhanced'
  desc 'Markdown Preview Enhanced for macOS QuickLook'
  homepage 'https://github.com/xykong/markdown-quicklook'

  auto_updates true

  livecheck do
    url "https://xykong.github.io/markdown-quicklook/appcast.xml"
    strategy :sparkle, &:short_version
  end

  app 'Markdown Preview Enhanced.app'

  postflight do
    system_command '/usr/bin/xattr',
                   args: ['-cr', "#{appdir}/Markdown Preview Enhanced.app"],
                   sudo: false

    system_command '/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister',
                   args: ['-f', "#{appdir}/Markdown Preview Enhanced.app"],
                   sudo: false

    system_command '/usr/bin/qlmanage',
                   args: ['-r'],
                   sudo: false

    # Open the app in background to trigger QuickLook extension registration
    system_command '/usr/bin/open',
                   args: ['-g', "#{appdir}/Markdown Preview Enhanced.app", '--args', '--register-only'],
                   sudo: false
  end

  caveats <<~EOS
    If the QuickLook extension does not work immediately:
      1. Run 'qlmanage -r' in Terminal.
      2. Restart Finder (Force Quit > Finder > Relaunch).
      3. Set 'Markdown Preview Enhanced.app' as the default app for .md files.
  EOS

  zap trash: [
    '~/Library/Application Scripts/com.xykong.Markdown',
    '~/Library/Containers/com.xykong.Markdown',
    '~/Library/Application Scripts/com.xykong.Markdown.QuickLook',
    '~/Library/Containers/com.xykong.Markdown.QuickLook'
  ]
end
