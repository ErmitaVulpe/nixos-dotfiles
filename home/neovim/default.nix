{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      ripgrep
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./opts.lua}
      ${builtins.readFile ./remap.lua}
      ${builtins.readFile ./lsp.lua}

      lspConfigurator("lua-language-server", "lua_ls")
      lspConfigurator("nixd", "nixd")
      lspConfigurator("pyright", "pyright")
      lspConfigurator("rust-analyzer", "rust_analyzer")
      lspConfigurator("vscode-css-language-server", "cssls")
      lspConfigurator("vscode-eslint-language-server", "eslint")
      lspConfigurator("vscode-html-language-server", "html")
      lspConfigurator("vscode-json-language-server", "jsonls")

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "nix",
        command = "setlocal shiftwidth=2 tabstop=2"
      })
    '';

    plugins = with pkgs.vimPlugins;
      let
        list = map (obj: obj // { type = "lua"; }) [
          {
            plugin = nvim-treesitter;
            config = builtins.readFile ./plugins/treesitter.lua;
          }
          # treesitter grammar packages
          (nvim-treesitter.withPlugins (p: [
            p.bash
            p.c
            p.javascript
            p.lua
            p.nix
            p.python
            p.rust
            p.typescript
          ]))

          # LSP
          cmp-nvim-lsp
          cmp_luasnip
          luasnip
          nvim-cmp
          nvim-lspconfig

          # theme
          {
            plugin = nightfox-nvim;
            config = builtins.readFile ./themes/carbonfox.lua;
          }

          # other plugins
          {
            plugin = nvim-autopairs;
            config = builtins.readFile ./plugins/autopairs.lua;
          }
          {
            plugin = nvim-colorizer-lua;
            config = builtins.readFile ./plugins/colorizer.lua;
          }
          {
            plugin = vim-fugitive;
            config = "vim.keymap.set(\"n\", \"<leader>gs\", vim.cmd.Git)";
          }
          {
            plugin = gitsigns-nvim;
            config = "require(\"gitsigns\").setup {}";
          }
          {
            plugin = tiny-inline-diagnostic-nvim;
            config = builtins.readFile ./plugins/tiny-inline-diagnostic.lua;
          }
          {
            plugin = harpoon2;
            config = builtins.readFile ./plugins/harpoon.lua;
          }
          {
            plugin = oil-nvim;
            config = builtins.readFile ./plugins/oil.lua;
          }
          {
            plugin = render-markdown-nvim;
            config = "require(\"render-markdown\").setup()";
          }
          {
            plugin = lualine-nvim;
            config = builtins.readFile ./plugins/lualine.lua;
          }
          {
            plugin = telescope-nvim;
            config = builtins.readFile ./plugins/telescope.lua;
          }
          {
            plugin = undotree;
            config = "vim.keymap.set(\"n\", \"<leader>u\", vim.cmd.UndotreeToggle)";
          }
          {
            plugin = nvim-web-devicons;
          }
        ];
      in list;
  };
}

