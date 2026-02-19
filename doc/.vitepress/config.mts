import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'Neovim Config',
  description: 'Personal Neovim configuration reference',
  themeConfig: {
    nav: [
      { text: 'Configuration', link: '/configuration' },
      { text: 'Flutter Guide', link: '/flutter-guide' },
    ],
    sidebar: [
      {
        text: 'Documentation',
        items: [
          { text: 'Configuration Reference', link: '/configuration' },
          { text: 'Flutter Guide', link: '/flutter-guide' },
        ],
      },
    ],
    search: {
      provider: 'local',
    },
    outline: {
      level: [2, 3],
    },
  },
})
