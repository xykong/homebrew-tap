cask 'flux-markdown' do
  version '1.22.275'
  sha256 'f3588196c54d8a8915eb9bf53d33ac87a6c95207e8e1aec40d6ad96ec390929b'

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

  depends_on formula: 'duti'

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

    # Set FluxMarkdown as the default handler for Markdown file types.
    # Use file extensions (.md, .markdown) rather than UTIs to avoid
    # "does not conform to any UTI hierarchy" errors on clean systems.
    duti_bin = ['/opt/homebrew/bin/duti', '/usr/local/bin/duti'].find { |p| File.exist?(p) }
    if duti_bin
      %w[.md .markdown].each do |ext|
        system_command duti_bin,
                       args: ['-s', 'com.xykong.Markdown', ext, 'all'],
                       sudo: false,
                       print_stderr: false
      end
    end
  end

  caveats <<~EOS
    FluxMarkdown has been set as the default app for .md and .markdown files.

    If the QuickLook extension does not work immediately:
      1. Run 'qlmanage -r' in Terminal.
      2. Restart Finder (Force Quit > Finder > Relaunch).
  EOS

  zap trash: [
    '~/Library/Application Scripts/com.xykong.Markdown',
    '~/Library/Containers/com.xykong.Markdown',
    '~/Library/Application Scripts/com.xykong.Markdown.QuickLook',
    '~/Library/Containers/com.xykong.Markdown.QuickLook'
  ]
end
