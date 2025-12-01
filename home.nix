{ config, pkgs, username, ... }:

{
  home.file."${config.xdg.configHome}/zsh/functions/spectrum" = {
    source = ./zsh/functions/spectrum;
  };
  home.file."${config.xdg.configHome}/zsh/functions/promptori" = {
    source = ./zsh/functions/promptori;
  };
  home.packages = with pkgs; [
    ghq
    peco
    tig
    vscode
  ];
  home.sessionVariables = {
    EDITOR = "emacs -nw";
  };
  home.stateVersion = "25.11";
  home.shellAliases = {
    e = "cd $(ghq root)/$(ghq list | peco)";
    emacs = "emacs -nw";
  };
  home.username = "${username}";
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.emacs.enable = true;
  programs.emacs.extraPackages = epkgs:
    with epkgs; [
      magit
    ];
  programs.gh.enable = true;
  programs.gh.hosts = {
    "github.com" = {
      git_protocol = "https";
      user = "hanachin";
      users = {
        hanachin = {};
      };
    };
  };
  programs.git.attributes = [
    "Gemfile diff=ruby"
    "*.rake diff=ruby"
    "*.rb diff=ruby"
  ];
  programs.git.enable = true;
  programs.git.settings = {
    alias = {
      delete-merged-branches = "!git branch --merged | grep -v \\* | xargs -I % git branch -d %";
    };
    ghq = {
      root = "~/src";
    };
    user = {
      name = "Seiei Miyagi";
      email = "hanachin@gmail.com";
    };
    init = {
      defaultBranch = "main";
    };
  };
  programs.git.signing.signByDefault = true;
  programs.git.lfs.enable = true;
  programs.gpg.enable = true;
  programs.gpg.publicKeys = [
    {
      source = ./hanachin.gpg;
      trust = 5;
    }
  ];
  programs.zsh.autocd = true;
  programs.zsh.completionInit = "autoload -U compinit && compinit -i";
  programs.zsh.defaultKeymap = "emacs";
  programs.zsh.enable = true;
  programs.zsh.history.extended = true;
  programs.zsh.history.size = 600000;
  programs.zsh.history.save = 600000;
  programs.zsh.initContent = ''
    fpath=(${config.xdg.configHome}/zsh/functions $fpath)
    autoload -Uz promptori
    promptori
  '';
  programs.zsh.profileExtra = ''
    if [ -x /opt/homebrew/bin/brew ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  '';
  programs.zsh.setOptions = [
    "AUTO_PUSHD"
    "CORRECT"
  ];
}
