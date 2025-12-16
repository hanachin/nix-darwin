{
  pkgs,
  username,
  ...
}:
{
  environment.systemPackages = with pkgs; [];

  homebrew.enable = true;
  homebrew.casks = [
    { name = "docker-desktop"; }
    { name = "logi-options+"; }
    { name = "keybase"; }
    { name = "firefox"; }
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  programs._1password-gui.enable = true;
  programs.zsh.enableGlobalCompInit = false;

  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults.dock.wvous-tl-corner = 2;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;
  system.keyboard.swapLeftCtrlAndFn = true;
  system.keyboard.swapLeftCommandAndLeftAlt = true;

  system.primaryUser = username;
  system.stateVersion = 6;

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };
}
