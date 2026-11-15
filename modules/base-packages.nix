{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
  ];

  # Skip the default extras (perl, rsync, strace, ...) and the manual builds.
  environment.defaultPackages = [ ];
  documentation.enable = false;
  programs.nano.enable = false;
}
