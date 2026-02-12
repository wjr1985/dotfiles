-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      -- Ruby / Rails
      "ruby",
      "embedded_template",
      -- Web (Rails views)
      "html",
      "css",
      "javascript",
      -- Data / config
      "yaml",
      "json",
      "sql",
    },
  },
}
