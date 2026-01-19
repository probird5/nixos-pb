# Neovim Configuration

A Neovim IDE setup managed via NixOS/Home Manager with Lazy.nvim plugin management.

Requires Neovim 0.11+.

## Supported Languages

| Language | LSP Server | Formatter | Linter |
|----------|------------|-----------|--------|
| Go | gopls | gofumpt, goimports | golangci-lint |
| Python | pyright | ruff | ruff |
| Bash | bash-language-server | shfmt | bash-language-server |
| YAML | yaml-language-server | prettierd | - |
| Rust | rust-analyzer | rustfmt | clippy |
| C/C++ | clangd | clang-format | - |
| JavaScript/TypeScript | typescript-language-server | prettierd | - |
| Markdown | marksman | prettierd | - |
| Nix | nixd | nixfmt | - |
| Lua | lua-language-server | stylua | - |
| HTML/CSS/JSON | vscode-langservers-extracted | prettierd | - |

## Keybindings

Leader key: `<Space>`

### LSP Navigation

| Key | Mode | Action |
|-----|------|--------|
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `gi` | Normal | Go to implementation |
| `gr` | Normal | Find references |
| `gt` | Normal | Go to type definition |
| `K` | Normal | Hover documentation |
| `<C-k>` | Insert | Signature help |

### Code Actions

| Key | Mode | Action |
|-----|------|--------|
| `<leader>ca` | Normal/Visual | Code action |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>gf` | Normal | Format buffer |

### Diagnostics

| Key | Mode | Action |
|-----|------|--------|
| `<leader>d` | Normal | Show diagnostic float |
| `[d` | Normal | Previous diagnostic |
| `]d` | Normal | Next diagnostic |
| `<leader>q` | Normal | Diagnostics to location list |

### Window Navigation

| Key | Mode | Action |
|-----|------|--------|
| `<C-h>` | Normal | Move to left window |
| `<C-j>` | Normal | Move to window below |
| `<C-k>` | Normal | Move to window above |
| `<C-l>` | Normal | Move to right window |
| `<leader>h` | Normal | Previous buffer |
| `<leader>l` | Normal | Next buffer |

### Completion (nvim-cmp)

| Key | Mode | Action |
|-----|------|--------|
| `<C-Space>` | Insert | Trigger completion |
| `<CR>` | Insert | Confirm selection |
| `<Tab>` | Insert | Next item |
| `<S-Tab>` | Insert | Previous item |
| `<C-b>` | Insert | Scroll docs up |
| `<C-f>` | Insert | Scroll docs down |
| `<C-e>` | Insert | Abort completion |

### Treesitter

| Key | Mode | Action |
|-----|------|--------|
| `<C-Space>` | Normal | Init/increment selection |
| `<BS>` | Normal | Decrement selection |

## Plugins

- **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim)
- **LSP**: [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- **Completion**: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) + [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- **Syntax**: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- **Formatting/Linting**: [none-ls.nvim](https://github.com/nvimtools/none-ls.nvim)
- **Fuzzy Finder**: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- **File Explorer**: [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim), [oil.nvim](https://github.com/stevearc/oil.nvim)
- **Statusline**: [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- **Theme**: [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
- **Autopairs**: [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- **Dashboard**: [alpha-nvim](https://github.com/goolord/alpha-nvim)
- **Tmux Integration**: [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)

## File Structure

```
nvim/
├── init.lua                 # Entry point, loads lazy.nvim
├── lua/
│   ├── vim-options.lua      # Core vim settings
│   └── plugins/
│       ├── lsp-config.lua   # LSP configuration and keymaps
│       ├── completions.lua  # nvim-cmp setup
│       ├── treesitter.lua   # Syntax highlighting
│       ├── none-ls.lua      # Formatters and linters
│       ├── telescope.lua    # Fuzzy finder
│       ├── neo-tree.lua     # File explorer
│       ├── oil.lua          # File explorer (buffer-style)
│       ├── lualine.lua      # Statusline
│       ├── tokyonight.lua   # Theme
│       ├── autopairs.lua    # Auto-close brackets
│       ├── alpha.lua        # Dashboard
│       └── ...
└── lazy-lock.json           # Plugin version lock file
```

## Installation

LSP servers and tools are provided via Nix in `modules/nvim.nix`. After modifying the config:

```bash
# NixOS
sudo nixos-rebuild switch

# Home Manager standalone
home-manager switch
```

## Features

- **Format on save**: Enabled by default (disable in `plugins/none-ls.lua`)
- **Diagnostics**: Inline virtual text with signs in gutter
- **Autocompletion**: LSP-powered with snippet support
- **Treesitter**: Syntax highlighting, indentation, incremental selection
