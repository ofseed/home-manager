{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ofseed";
  home.homeDirectory = "/home/ofseed";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # Programs
    lazydocker

    # Fonts
    (nerdfonts.override {
      fonts = [
        "CascadiaCode"
        "NerdFontsSymbolsOnly"
      ];
    })
    cascadia-code
    noto-fonts-color-emoji
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".ideavimrc".source = dotfiles/ideavimrc;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ofseed/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.shellAliases = {
    hm = "home-manager";
  };

  fonts = {
    fontconfig = {
      enable = true;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs = {
    fish = {
      enable = true;
    };
    starship = {
      enable = true;
    };

    zoxide = {
      enable = true;
    };
    lsd = {
      enable = true;
      enableAliases = true;
    };
    btop = {
      enable = true;
      settings = {
        vim_keys = true;
      };
    };
    fzf = {
      enable = true;
      colors = {
        # Catppuccin
        "bg+"="#313244";
        bg="#1e1e2e";
        spinner="#f5e0dc";
        hl="#f38ba8";
        fg="#cdd6f4";
        header="#f38ba8";
        info="#cba6f7";
        pointer="#f5e0dc";
        marker="#f5e0dc";
        "fg+"="#cdd6f4";
        prompt="#cba6f7";
        "hl+"="#f38ba8";
      };
    };
    ripgrep = {
      enable = true;
    };

    git = {
      enable = true;
      aliases = {
        co = "checkout";
        br = "branch";
        ci = "commit";
        st = "status";
      };
      userEmail = "ofseed@foxmail.com";
      userName = "Yi Ming";
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
    };
    gh = {
      enable = true;
      settings = {
        # Workaround for https://github.com/nix-community/home-manager/issues/4744
        version = 1;
      };
    };
    gh-dash = {
      enable = true;
    };
    lazygit = {
      enable = true;
    };

    mpv = {
      package = pkgs.nix;
      enable = true;
    };
    kitty = {
      package = pkgs.nix;
      enable = true;
      font = {
        name = "CaskaydiaCove Nerd Font";
      };
      theme = "Catppuccin-Mocha";
      extraConfig = builtins.readFile ./dotfiles/config/kitty/kitty.conf;
    };
  };
}
