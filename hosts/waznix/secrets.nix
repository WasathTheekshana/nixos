{ ... }:

{
  # Decrypt using the host's existing SSH host key (converted to age),
  # so no separate key needs to be provisioned on the machine.
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  sops.defaultSopsFile = ./secrets.yaml;
}
