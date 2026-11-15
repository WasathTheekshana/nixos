{ ... }:

{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    openFirewall = true;
    settings = {
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
      # AllowUsers already excludes root, so there's no need to also permit
      # root login at the ssh daemon level.
      PermitRootLogin = "no";
      AllowUsers = [ "wasath" ];
    };
  };
}
