-- Ruby on Rails development support
-- LSP, formatters, navigation, testing, debugging, and keybindings

---@type LazySpec
return {
  -- =============================================
  -- AstroLSP: ruby-lsp configuration
  -- =============================================
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      -- Use system-installed ruby-lsp (gem install ruby-lsp), skip Mason
      servers = { "ruby_lsp" },
      config = {
        ruby_lsp = {
          init_options = {
            formatter = "auto", -- auto-detects RuboCop from Gemfile
          },
        },
      },
      formatting = {
        format_on_save = {
          allow_filetypes = {
            "ruby",
            "eruby",
          },
        },
      },
    },
  },

  -- =============================================
  -- none-ls: ERB formatting and linting
  -- (RuboCop for .rb is handled natively by ruby-lsp)
  -- =============================================
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local null_ls = require "null-ls"
      opts.sources = require("astrocore").list_insert_unique(opts.sources, {
        null_ls.builtins.formatting.erb_format,
        null_ls.builtins.diagnostics.erb_lint,
      })
    end,
  },

  -- =============================================
  -- vim-rails: Rails navigation
  -- :A (alternate), :R (related), :Emodel, :Eview, :Econtroller, etc.
  -- Enhanced gf for Rails paths
  -- =============================================
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby" },
    dependencies = { "tpope/vim-projectionist" },
  },

  -- =============================================
  -- vim-bundler: Bundler integration
  -- :Bundle, :Bopen
  -- =============================================
  {
    "tpope/vim-bundler",
    ft = { "ruby", "eruby" },
    dependencies = { "tpope/vim-projectionist" },
  },

  -- =============================================
  -- nvim-treesitter-endwise: Auto-insert `end`
  -- Modern treesitter-based replacement for vim-endwise
  -- =============================================
  {
    "RRethy/nvim-treesitter-endwise",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "InsertEnter",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup {
        endwise = { enable = true },
      }
    end,
  },

  -- =============================================
  -- nvim-dap-ruby: Ruby debugger via rdbg
  -- Requires: gem install debug (included in Ruby 3.1+)
  -- =============================================
  {
    "suketa/nvim-dap-ruby",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = "ruby",
    config = function() require("dap-ruby").setup() end,
  },

  -- =============================================
  -- Neotest with RSpec adapter (optional)
  -- Structured test runner UI for RSpec
  -- =============================================
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "olimorris/neotest-rspec" },
    opts = function(_, opts)
      if not opts.adapters then opts.adapters = {} end
      table.insert(opts.adapters, require "neotest-rspec")
    end,
  },

  -- =============================================
  -- AstroCore: keybindings, filetypes, and options
  -- =============================================
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      -- Soft line wrapping
      options = {
        opt = {
          wrap = true,
          linebreak = true,
          breakindent = true,
        },
      },
      -- Filetype detection for Ruby/Rails files
      filetypes = {
        extension = {
          erb = "eruby",
          jbuilder = "ruby",
          rake = "ruby",
          gemspec = "ruby",
          ru = "ruby",
          thor = "ruby",
          builder = "ruby",
        },
        filename = {
          ["Gemfile"] = "ruby",
          ["Rakefile"] = "ruby",
          ["Guardfile"] = "ruby",
          ["Capfile"] = "ruby",
          ["Thorfile"] = "ruby",
          ["Vagrantfile"] = "ruby",
          ["Berksfile"] = "ruby",
          ["Podfile"] = "ruby",
          ["Fastfile"] = "ruby",
          [".rubocop.yml"] = "yaml",
          [".ruby-version"] = "text",
        },
      },
      -- Keybindings
      mappings = {
        n = {
          -- Rails navigation group
          ["<Leader>r"] = { desc = "Rails" },
          ["<Leader>rm"] = { "<Cmd>Emodel<CR>", desc = "Go to model" },
          ["<Leader>rv"] = { "<Cmd>Eview<CR>", desc = "Go to view" },
          ["<Leader>rc"] = { "<Cmd>Econtroller<CR>", desc = "Go to controller" },
          ["<Leader>ri"] = { "<Cmd>Emigration<CR>", desc = "Go to migration" },
          ["<Leader>rs"] = { "<Cmd>Espec<CR>", desc = "Go to spec" },
          ["<Leader>rl"] = { "<Cmd>Elocale<CR>", desc = "Go to locale" },
          ["<Leader>rh"] = { "<Cmd>Ehelper<CR>", desc = "Go to helper" },
          ["<Leader>rj"] = { "<Cmd>Ejavascript<CR>", desc = "Go to javascript" },
          ["<Leader>ry"] = { "<Cmd>Estylesheet<CR>", desc = "Go to stylesheet" },
          ["<Leader>rr"] = { "<Cmd>edit config/routes.rb<CR>", desc = "Go to routes" },
          ["<Leader>rg"] = { "<Cmd>edit Gemfile<CR>", desc = "Go to Gemfile" },
          ["<Leader>rd"] = { "<Cmd>edit config/database.yml<CR>", desc = "Go to database config" },
          ["<Leader>ra"] = { "<Cmd>A<CR>", desc = "Alternate file" },
          ["<Leader>rR"] = { "<Cmd>R<CR>", desc = "Related file" },

          -- RSpec via toggleterm
          ["<Leader>rT"] = {
            function()
              local file = vim.fn.expand "%"
              require("astrocore").toggle_term_cmd("bundle exec rspec " .. file)
            end,
            desc = "RSpec current file",
          },
          ["<Leader>rn"] = {
            function()
              local file = vim.fn.expand "%"
              local line = vim.fn.line "."
              require("astrocore").toggle_term_cmd("bundle exec rspec " .. file .. ":" .. line)
            end,
            desc = "RSpec nearest test",
          },
        },
      },
    },
  },
}
