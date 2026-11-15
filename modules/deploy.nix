{ ... }:

{
  users.users.deploy = {
    isSystemUser = true;
    group = "deploy";
    useDefaultShell = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB4yowTcxFrxOuX8/ZeHgZNn5G2QC6TnQ7X1hrnyvRmA ci-deploy@waznix"
    ];
  };
  users.groups.deploy = { };

  security.sudo.extraRules = [
    {
      users = [ "deploy" ];
      commands = [ { command = "ALL"; options = [ "NOPASSWD" ]; } ];
    }
  ];
}
