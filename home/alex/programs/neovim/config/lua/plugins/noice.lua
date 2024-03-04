return {
  "folke/noice.nvim",
  opts = function(_, opts)
    table.insert(opts.routes, {
      filter = {
        event = "notify",
        find = "No information available",
      },
      opts = { skip = true },
    })

    opts.presets = {
      lsp_doc_border = true,
      bottom_search = false,
      inc_rename = true,
    }
  end,
}, {
  "rcarriga/nvim-notify",
  opts = {
    timeout = 3000,
  },
}
