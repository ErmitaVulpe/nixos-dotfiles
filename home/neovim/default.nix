{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      ripgrep

      # Just for easier config editing
      lua-language-server
    ];

    initLua = ''
      ${builtins.readFile ./opts.lua}
      ${builtins.readFile ./remap.lua}
      ${builtins.readFile ./lsp.lua}
    '';

    plugins =
      with pkgs.vimPlugins;
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
            p.css
            p.dockerfile
            p.html
            p.javascript
            p.json
            p.lua
            p.nix
            p.python
            p.rust
            p.sql
            p.tmux
            p.toml
            p.typescript
            p.yaml
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
            plugin = conform-nvim;
            config = builtins.readFile ./plugins/conform.lua;
          }
          {
            plugin = gitsigns-nvim;
            config = "require(\"gitsigns\").setup {}";
          }
          {
            plugin = lualine-nvim;
            config = builtins.readFile ./plugins/lualine.lua;
          }
          {
            plugin = nvim-autopairs;
            config = builtins.readFile ./plugins/autopairs.lua;
          }
          {
            plugin = nvim-colorizer-lua;
            config = builtins.readFile ./plugins/colorizer.lua;
          }
          {
            plugin = nvim-surround;
            config = "require(\"nvim-surround\").setup()";
          }
          { plugin = nvim-web-devicons; }
          {
            plugin = oil-git-nvim;
            config = "require(\"oil-git\").setup()";
          }
          {
            plugin = oil-lsp-diagnostics-nvim;
            config = "require(\"oil-lsp-diagnostics\").setup()";
          }
          {
            plugin = oil-nvim;
            config = builtins.readFile ./plugins/oil.lua;
          }
          # Sadly, as of 01.03.26 telescope-nvim doesnt specify this as a dep
          { plugin = plenary-nvim; }
          {
            plugin = render-markdown-nvim;
            config = "require(\"render-markdown\").setup()";
          }
          {
            plugin = telescope-nvim;
            config = builtins.readFile ./plugins/telescope.lua;
          }
          {
            plugin = tiny-inline-diagnostic-nvim;
            config = builtins.readFile ./plugins/tiny-inline-diagnostic.lua;
          }
          {
            plugin = undotree;
            config = "vim.keymap.set(\"n\", \"<leader>u\", vim.cmd.UndotreeToggle)";
          }
          {
            plugin = vim-fugitive;
            config = "vim.keymap.set(\"n\", \"<leader>gs\", vim.cmd.Git)";
          }
          { plugin = vim-tmux-navigator; }
        ];
      in
      list;
  };
}
