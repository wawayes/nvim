return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      -- Explorer is a picker; configure it under picker.sources.explorer
      picker = {
        sources = {
          explorer = {
            hidden = true,   -- show dotfiles by default
            ignored = true, -- also show files ignored by VCS (e.g. .env)
          },
        },
      },
    },
  },
}
