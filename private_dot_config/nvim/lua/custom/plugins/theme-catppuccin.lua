-- Catppuccin
-- A pastel theme https://github.com/catppuccin/nvim

return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
