# Ruby on Rails Development Setup

## Prerequisites

### System Requirements
- **Ruby** 3.1+ (for built-in `debug` gem)
- **Bundler** (`gem install bundler`)
- **Node.js** (for ERB formatter)

### Required Gems (global)
```sh
gem install debug           # Ruby debugger (built into Ruby 3.1+)
gem install erb-formatter   # ERB file formatting
gem install erb_lint        # ERB linting
```

### Mason Packages (installed automatically)
- `ruby-lsp` — Shopify's Ruby language server
- `rubocop` — Ruby linter/formatter (fallback; prefer project Gemfile)

## What's Included

| Plugin | Purpose |
|---|---|
| **ruby-lsp** (via Mason) | LSP: completion, diagnostics, formatting, go-to-definition |
| **none-ls** (erb_format + erb_lint) | ERB formatting and linting |
| **vim-rails** | Rails navigation (`:A`, `:R`, `:Emodel`, `:Econtroller`, etc.) |
| **vim-projectionist** | Project-aware alternate file navigation (vim-rails dependency) |
| **vim-bundler** | Bundler integration (`:Bundle`, `:Bopen`) |
| **nvim-treesitter-endwise** | Auto-insert `end` after Ruby blocks |
| **nvim-dap-ruby** | Debug adapter for Ruby (via `rdbg`) |
| **neotest-rspec** | Structured test runner for RSpec (optional) |

## Keybindings

### Rails Navigation (`<Leader>r`)

| Key | Action |
|---|---|
| `<Leader>rm` | Go to model |
| `<Leader>rv` | Go to view |
| `<Leader>rc` | Go to controller |
| `<Leader>ri` | Go to migration |
| `<Leader>rs` | Go to spec |
| `<Leader>rl` | Go to locale |
| `<Leader>rh` | Go to helper |
| `<Leader>rj` | Go to javascript |
| `<Leader>ry` | Go to stylesheet |
| `<Leader>rr` | Go to routes (`config/routes.rb`) |
| `<Leader>rg` | Go to Gemfile |
| `<Leader>rd` | Go to database config |
| `<Leader>ra` | Alternate file (`:A`) |
| `<Leader>rR` | Related file (`:R`) |

### Testing

| Key | Action |
|---|---|
| `<Leader>rT` | Run RSpec on current file (toggleterm) |
| `<Leader>rn` | Run RSpec on nearest test (toggleterm) |

### vim-rails Commands

| Command | Action |
|---|---|
| `:A` | Jump to alternate file (e.g., model <-> spec) |
| `:R` | Jump to related file |
| `:Emodel user` | Open `app/models/user.rb` |
| `:Econtroller users` | Open `app/controllers/users_controller.rb` |
| `:Eview users/index` | Open `app/views/users/index.html.erb` |
| `:Emigration` | Open latest migration |
| `:Espec` | Open corresponding spec |
| `gf` | Enhanced go-to-file for Rails paths (partials, models, etc.) |

## Per-Project Setup

### Recommended Gemfile Additions
```ruby
group :development do
  gem "ruby-lsp", require: false
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "debug", require: false
end

group :test do
  gem "rspec-rails"
end
```

Then run:
```sh
bundle install
```

ruby-lsp will automatically detect RuboCop from your Gemfile and use it for diagnostics and formatting.

## Verification

After setup, open Neovim and run:

1. `:Lazy sync` — installs new plugins
2. `:MasonToolsInstall` — installs ruby-lsp, rubocop
3. Open a `.rb` file in a Rails project, then `:LspInfo` — should show `ruby_lsp` attached
4. Open an `.erb` file — treesitter highlighting should work
5. `:A` — should toggle between model and spec
6. `<Leader>r` — should show Rails navigation menu in which-key
7. Type `def foo` + Enter — `end` should auto-insert

## Troubleshooting

### ruby-lsp not starting
- Check `:LspLog` for errors
- Ensure `ruby-lsp` is installed: `:Mason` and search for `ruby-lsp`
- Verify Ruby is on your PATH: `:!ruby --version`
- The project must have a `Gemfile` for ruby-lsp to activate

### RuboCop not detected
- ruby-lsp auto-detects RuboCop from the project's Gemfile
- Add `gem "rubocop"` to your Gemfile and run `bundle install`
- If using the Mason-installed RuboCop (fallback), it may not match your project's Ruby version

### ERB formatting not working
- Install erb-formatter globally: `gem install erb-formatter`
- Check `:NullLsInfo` to see if `erb_format` source is active

### Treesitter not highlighting ERB
- Run `:TSInstall embedded_template` manually if auto-install didn't work
- Check `:TSInstallInfo` to verify parser installation

### Endwise not inserting `end`
- Ensure you're in insert mode and pressing Enter after `def`, `do`, `if`, etc.
- Check that treesitter is active for the buffer: `:TSBufToggle highlight`

### Debug adapter not connecting
- Ensure `debug` gem is installed: `gem install debug`
- The debugger uses `rdbg` — verify it's on your PATH: `which rdbg`
- Start debugging with `:DapContinue` (or `<Leader>dc` in AstroNvim)
