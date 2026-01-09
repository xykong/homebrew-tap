cask 'markdown-preview-enhanced' do
  version '1.1.61'
  sha256 '2d2b3e0ffbd6cde8125cd7457f1265e6fdf6a87ab659e345e6eeb22d49f07221'

  url "https://github.com/xykong/markdown-quicklook/releases/download/v#{version}/MarkdownPreviewEnhanced.dmg"
  name 'Markdown Preview Enhanced'
  desc 'Markdown Preview Enhanced for macOS QuickLook'
  homepage 'https://github.com/xykong/markdown-quicklook'

  app 'Markdown Preview Enhanced.app'

  zap trash: [
    '~/Library/Application Scripts/com.xykong.Markdown',
    '~/Library/Containers/com.xykong.Markdown',
    '~/Library/Application Scripts/com.xykong.Markdown.QuickLook',
    '~/Library/Containers/com.xykong.Markdown.QuickLook'
  ]
end
