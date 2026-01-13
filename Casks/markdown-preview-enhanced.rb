cask 'markdown-preview-enhanced' do
  version '1.3.73'
  sha256 'ca72b7201410962f0f5d272149b2405a5d191a8e692d9526f23ecad3882cd306'

  url "https://github.com/xykong/markdown-quicklook/releases/download/v#{version}/MarkdownPreviewEnhanced.dmg"
  name 'Markdown Preview Enhanced'
  desc 'Markdown Preview Enhanced for macOS QuickLook'
  homepage 'https://github.com/xykong/markdown-quicklook'

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
