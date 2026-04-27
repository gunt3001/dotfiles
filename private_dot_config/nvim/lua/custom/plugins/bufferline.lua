-- Bufferline
-- adds VSCode-like tab (buffer) bar to top of the screen

return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      vim.opt.termguicolors = true
      require('bufferline').setup {}
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
