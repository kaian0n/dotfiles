return {
  "sphamba/smear-cursor.nvim",
  config = function()
    local smear = require("smear_cursor")
    smear.setup({
      cursor_color = "#ff8800",
      stiffness = 0.3,
      trailing_stiffness = 0.1,
      damping = 0.5,
      trailing_exponent = 5,
      never_draw_over_target = true,
      hide_target_hack = true,
      gamma = 1,
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      scroll_buffer_space = true,
      legacy_computing_symbols_support = false,
      smear_insert_mode = true,
    })
    smear.enabled = true  -- Explicitly enable on load

    -- Reddit workaround for disabling on buffer switches
    vim.api.nvim_create_autocmd("BufLeave", {
      callback = function()
        smear.enabled = false
      end,
    })
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        vim.fn.timer_start(70, function()
          smear.enabled = true
        end)
      end,
    })
  end,
}
