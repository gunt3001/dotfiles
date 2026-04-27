-- Colorizer
-- High-performance hex color previewer https://github.com/norcalli/nvim-colorizer.lua

return {
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup({}, {
        names = false,
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
