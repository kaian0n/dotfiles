return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require('lualine').setup({
      options = {
        theme = {
          normal = {
            a = { fg = '#d6c3a5', bg = '#ff3f00' },  -- Beige on red
            b = { fg = '#d6c3a5', bg = '#d6c3a5' },  -- Beige on tan (changed from grey)
            c = { fg = '#d6c3a5', bg = '#772953' },  -- Beige on maroon
          },
          insert = {
            a = { fg = '#772953', bg = '#00bb00' },  -- Maroon on green
          },
          visual = {
            a = { fg = '#772953', bg = '#ff3f00' },  -- Maroon on red (changed from orange/yellow)
          },
          replace = {
            a = { fg = '#772953', bg = '#ff55ff' },  -- Maroon on magenta
          },
          inactive = {
            a = { fg = '#a08c7a', bg = '#d6c3a5' },  -- Dimmed beige on tan (changed from dark/grey)
            b = { fg = '#a08c7a', bg = '#d6c3a5' },
            c = { fg = '#a08c7a', bg = '#d6c3a5' },  -- Solid tan avoids black artifacts
          },
        },
      },
      sections = {
        lualine_x = {
          { "encoding", color = { fg = '#d6c3a5' } },
          {
            "fileformat",
            symbols = {
              unix = "\u{F179}", -- Apple logo
              dos = "\u{F17A}",  -- Windows logo
              mac = "\u{F179}"   -- Apple logo again for Mac
            },
            color = { fg = '#d6c3a5' }
          },
          { "filetype", color = { fg = '#d6c3a5' } },
        }
      }
    })
  end
}
