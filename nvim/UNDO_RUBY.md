# How to Undo Ruby/Rails Support

## 1. Restore modified files

### `lua/plugins/mason.lua`
Add `if true then return {} end` as the first line, and remove the `"ruby-lsp"` and `"rubocop"` entries from `ensure_installed`.

### `lua/plugins/treesitter.lua`
Add `if true then return {} end` as the first line, and remove all parsers except `"lua"` and `"vim"`.

## 2. Delete new files

```sh
rm lua/plugins/ruby.lua
rm RUBY_SETUP.md
rm UNDO_RUBY.md  # this file
```

## 3. Clean up installed artifacts in Neovim

- `:Lazy sync` — removes plugins no longer referenced (vim-rails, vim-bundler, nvim-treesitter-endwise, nvim-dap-ruby, neotest-rspec, vim-projectionist)
- `:Mason` — manually uninstall `ruby-lsp` and `rubocop` if desired
- `:TSUninstall ruby embedded_template html css javascript yaml json sql` — remove treesitter parsers if desired
