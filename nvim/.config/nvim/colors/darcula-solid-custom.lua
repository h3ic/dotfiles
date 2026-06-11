vim.g.colors_name = 'darcula-solid-custom'

local lush = require('lush')
local darcula_solid = require('lush_theme.darcula-solid')
local spec = lush.extends({ darcula_solid }).with(function()
  return {
    -- Normal { bg = "NONE" },
  }
end)

lush(spec)
