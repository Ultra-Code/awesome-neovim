local function total_num_lines()
    return vim.fn.expand(vim.fn.line('$'))
end

require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {},
    padding = 1, -- adds padding to the left and right of components
    left_padding = 1, -- adds padding to the left of components
    right_padding =1, -- adds padding to the right of components
    upper = false, -- displays components in uppercase
    lower = false, -- displays components in lowercase
    format = nil -- format function, formats component's output
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch','diff'},
    lualine_c = {
    {
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
    }
  },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {}, --'progress' is the default
    lualine_z = {
      {'location',
      left_padding = 0, -- adds padding to the left of components
      right_padding =0, -- adds padding to the right of components
      icon = nil, -- displays icon in front of the component
      separator = ':', -- overwrites component_separators for component
      condition = nil, -- condition function, component is loaded when function returns true
      -- custom color for component in format
      -- color = {fg = '#rrggbb', bg= '#rrggbb', gui='style'}
      -- or highlight group
      -- color = "WarningMsg"
      color = nil
      },
      total_num_lines
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
    }
