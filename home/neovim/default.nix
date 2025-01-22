{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraLuaConfig = ''
      ${builtins.readFile ./opts.lua}
      ${builtins.readFile ./remap.lua}
    '';

    plugins = with pkgs.vimPlugins;
    let
      list = map (obj: obj // { type = "lua"; }) [
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
          plugin = vim-devicons;
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
          plugin = nvim-treesitter;
          config = builtins.readFile ./plugins/treesitter.lua;
        }
        # {
        #   plugin = ;
        #   config = "";
        # }
        # {
        #   plugin = ;
        #   config = "";
        # }
        # {
        #   plugin = ;
        #   config = "";
        # }
        # {
        #   plugin = ;
        #   config = "";
        # }
        # {
        #   plugin = ;
        #   config = "";
        # }
      ];
    in list;
  };
}
