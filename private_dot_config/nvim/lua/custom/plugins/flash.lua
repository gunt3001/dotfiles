-- flash.nvim
-- fast navigation / jumping around the screen

return {
  { -- Fast navigation with flash.nvim
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
    -- stylua:ignore
    keys = {
      -- Only enable the standard Flash key here. No fancy tresitter navigation, for now.
      {
        '<leader>f',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
