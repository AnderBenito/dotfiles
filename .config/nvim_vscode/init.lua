if vim.g.vscode then
  -- VSCode extension
  vim.g.mapleader = " "
  vim.opt.clipboard = "unnamedplus"

  require("core.utils").load_mappings()

  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end

  vim.opt.rtp:prepend(lazypath)

  local plugins = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-treesitter/nvim-treesitter",
      init = function()
        require("core.utils").lazy_load "nvim-treesitter"
      end,
      cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
      build = ":TSUpdate",
      opts = function()
        return require "plugins.configs.treesitter"
      end,
      config = function(_, opts)
        -- dofile(vim.g.base46_cache .. "syntax")
        require("nvim-treesitter.configs").setup({
          commands = {
              go = "go",
              gomodifytags = "gomodifytags",
              gotests = "~/go/bin/gotests",
              impl = "impl",
              iferr = "iferr",
            },
        })
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
  }

  require("lazy").setup(plugins, {
    defaults = { lazy = true },
  })

else
    -- ordinary Neovim
end
