local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "gopls",
        "bash-language-server",
        "shellcheck",
        "gofumpt",
        "golines",
        "goimports",
        "gomodifytags",
        "goimports-reviser",
        "clangd",
        "clang-format",
        "sql-formatter",
        "typescript-language-server",
        "rust-analyzer",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require('plugins.configs.lspconfig')
      require('custom.configs.lspconfig')
    end,
  },
  {
    "mfussenegger/nvim-dap",
    init = function()
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    init = function()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
    config = function()
      require("dapui").setup()
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "mfussenegger/nvim-dap",
    },
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require('dap-go').setup(opts)
      require('core.utils').load_mappings("dap_go")

      local dap = require("dap")
      dap.configurations.go = {
        {
          name = 'Launch test function',
          type = 'go',
          cwd = '${workspaceFolder}',
          request = 'launch',
          mode = 'auto',
          program = '${workspaceFolder}/cmd/server/main.go',
          env = {
            CONFIG_FILE = 'config/config.yml',
          }
        },
        {
          type = 'go',
          request = 'launch',
          name = 'Launch file with arguments (console = integratedTerminal, justMyCode = false)',
          program = '${workspaceFolder}/cmd/server/main.go',
          console = 'integratedTerminal',
          justMyCode = false,
          env = {
            CONFIG_FILE = 'config/config.yml',
          },
          -- pythonPath = opts.pythonPath,
          args = function()
            local args_string = vim.fn.input('Arguments: ')
            return vim.split(args_string, ' +')
          end,
        },
      }
    end,
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    opts = {
      commands = {
        go = "go",
        gomodifytags = "gomodifytags",
        gotests = "~/go/bin/gotests",
        impl = "impl",
        iferr = "iferr",
      },
    },
    config = function(_, opts)
      require('gopher').setup(opts)
      require('core.utils').load_mappings("gopher")
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    ft = {"cpp", "go"},
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "ray-x/go.nvim",
    config = function()
      require("go").setup()
    end,
    event = {"CmdlineEnter"},
    ft = {"go", "gomod"},
    build = ':lua require("go.install").update_all_sync()',
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
}

return plugins

