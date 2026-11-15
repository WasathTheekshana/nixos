{ pkgs, ... }:

{
  users.users.wasath = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ tree ];
  };
}
