local M = {}

M.general = {
  n = {
    ["<leader>y"] = {
      "\"+y",
      "Copy to clipboard"
    },
    ["<leader>pp"] = {
      "\"+p",
      "Paste from clipboard"
    },
    ["<leader>ke"] = {
      function()
        vim.diagnostic.open_float()
      end,
      "Open diagnostic float window",
    },
  },

  v = {
    ["<leader>y"] = {
      "\"+y",
      "Copy to clipboard"
    },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dus"] = {
      function()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      "Open debugging sidebar",
    },
    ["<leader>ds"] = {
      function()
        require('dap').continue()
      end,
      "Start debugging",
    },
  },
}

M.lspconfig = {
  plugin = true,
  n = {
    ["<leader>lr"] = {
      function()
        vim.lsp.buf.rename()
      end,
      "Renames variable and references",
    },
  },
}

M.telescope = {
  plugin = true,
  n = {
    -- lsp
    ["<leader>gr"] = { "<cmd> Telescope lsp_references <CR>", "Find LSP references" },
    ["<leader>gO"] = { "<cmd> Telescope lsp_document_symbols <CR>", "telescope lps document symbols" },
    ["<leader>gT"] = { "<cmd> Telescope lsp_dynamic_workspace_symbols <CR>", "telescope lps workspace symbols" },
  },
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function()
        require('dap-go').debug_test()
      end,
      "Debug go test",
    },
    ["<leader>dgl"] = {
      function()
        require('dap-go').debug_last()
      end,
      "Debug last go test",
    },
  },
}

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add JSON tags",
    },
    ["<leader>gsy"] = {
      "<cmd> GoTagAdd yaml <CR>",
      "Add YAML tags",
    },
    ["<leader>gie"] = {
      "<cmd> GoIfErr <CR>",
      "Add if err snippet",
    },
  },
}

return M

