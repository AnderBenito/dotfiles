-- n, v, i, t = mode names

local M = {}

M.general = {
  i = {
    -- go to  beginning and end
    ["<C-b>"] = { "<ESC>^i", "Beginning of line" },
    ["<C-e>"] = { "<End>", "End of line" },

    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "Move left" },
    ["<C-l>"] = { "<Right>", "Move right" },
    ["<C-j>"] = { "<Down>", "Move down" },
    ["<C-k>"] = { "<Up>", "Move up" },
  },

  n = {
    ["<Esc>"] = { ":noh <CR>", "Clear highlights" },
    -- switch between windows
    ["<C-h>"] = { "<Cmd>call VSCodeCall('workbench.action.navigateLeft')<CR>", "Window left" },
    ["<C-l>"] = { "<Cmd>call VSCodeCall('workbench.action.navigateRight')<CR>", "Window right" },
    ["<C-j>"] = { "<Cmd>call VSCodeCall('workbench.action.navigateDown')<CR>", "Window down" },
    ["<C-k>"] = { "<Cmd>call VSCodeCall('workbench.action.navigateUp')<CR>", "Window up" },

    -- save
    ["<C-s>"] = { "<cmd> w <CR>", "Save file" },

    -- Copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

    -- line numbers
    ["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line number" },
    ["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },

    -- new buffer
    ["<leader>b"] = { "<cmd> enew <CR>", "New buffer" },
    ["<leader>ch"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },

    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
    },
  },

  t = {
    ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
  },

  v = {
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
  },

  x = {
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
  },
}

M.vscode = {
  n = {
    ["<tab>"] = {
      "<Cmd>call VSCodeCall('workbench.action.nextEditor')<CR>",
      "Go to next editor",
    },

    ["<S-tab>"] = {
      "<Cmd>call VSCodeCall('workbench.action.previousEditor')<CR>",
      "Go to previous editor",
    },

    ["gI"] = {
      "<Cmd>call VSCodeCall('editor.action.goToImplementation')<CR>",
      "Go to implementaworkbench.action.nextEditortion",
    },

    ["gr"] = {
      "<Cmd>call VSCodeCall('editor.action.goToReferences')<CR>",
      "Go to references",
    },

    ["<leader>/"] = {
      "<Cmd>call VSCodeCall('editor.action.commentLine')<CR>",
      "Toggle comment",
    },

    ["<leader>ff"] = {
      "<Cmd>call VSCodeCall('workbench.action.quickOpen')<CR>",
      "Quick open file",
    },

    ["<leader>fw"] = {
      "<Cmd>call VSCodeCall('workbench.action.findInFiles')<CR>",
      "Search in files",
    },

    ["<leader>fz"] = {
      "<Cmd>call VSCodeCall('actions.find')<CR>",
      "Search in current file",
    },

    ["<leader>lr"] = {
      "<Cmd>call VSCodeCall('editor.action.rename')<CR>",
      "Rename symbol",
    },
  },

  v = {
    ["<leader>/"] = {
      "<Cmd>call VSCodeCall('editor.action.commentLine')<CR>",
      "Toggle comment",
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
