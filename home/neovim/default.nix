{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      ripgrep
      wl-clipboard
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./opts.lua}
      ${builtins.readFile ./remap.lua}
      ${builtins.readFile ./lsp.lua}
      lspConfigurator("rustup --version > /dev/null 2>&1", "rust_analyzer")
      lspConfigurator("nixd --version > /dev/null 2>&1", "nixd")

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
        nvim-lspconfig
        nvim-cmp
        cmp-nvim-lsp
        luasnip

        # other plugins
        {
          plugin = nvim-autopairs;
          config = "require(\"nvim-autopairs\").setup {}";
        }
        {
          plugin = nvim-colorizer-lua;
          config = "require(\"colorizer\").setup()";
        }
        {
          plugin = vim-fugitive;
          config = "vim.keymap.set(\"n\", \"<leader>gs\", vim.cmd.Git)";
        }
        {
          plugin = harpoon2;
          config = builtins.readFile ./plugins/harpoon.lua;
        }
        {
          plugin = lualine-nvim;
          config = builtins.readFile ./plugins/lualine.lua;
        }
        {
          plugin = nvim-surround;
          config = "require(\"nvim-surround\").setup()";
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
