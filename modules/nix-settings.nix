{ ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Keep the store from growing unbounded on a small disk-constrained box.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
}
