{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./secrets.nix

    ../../modules/boot.nix
    ../../modules/nix-settings.nix
    ../../modules/base-packages.nix
    ../../modules/users.nix
    ../../modules/deploy.nix
    ../../modules/ssh.nix
    ../../modules/tailscale.nix
    ../../modules/wifi.nix
    ../../modules/power.nix
    ../../modules/neovim.nix
  ];

  networking.hostName = "waznix";
  time.timeZone = "Asia/Colombo";

  # See https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  # Do not change after initial install.
  system.stateVersion = "26.05";
}
