# nixos

NixOS config for my home server, `waznix`. It is a flake with one host, an x86_64 machine that boots with GRUB from `/dev/sda`.

## Layout

```
flake.nix                 inputs (nixpkgs 26.05, sops-nix) and the waznix host
hosts/waznix/             host settings, hardware config, sops setup, secrets.yaml
modules/                  one file per concern
```

The modules:

- `users.nix`: the `wasath` user, in the wheel group
- `ssh.nix`: OpenSSH on port 22, only `wasath` can log in, no root
- `wifi.nix`: wpa_supplicant with the network password pulled from sops
- `tailscale.nix`: Tailscale, joins the tailnet at boot with an auth key from sops
- `power.nix`: ignores the lid switch and disables suspend, since the box is a laptop that stays on
- `boot.nix`, `nix-settings.nix`, `base-packages.nix`, `neovim.nix`

## Secrets

The WiFi password and Tailscale auth key live in `hosts/waznix/secrets.yaml`, encrypted with sops. They are decrypted on the machine using its SSH host key (`/etc/ssh/ssh_host_ed25519_key`), so no extra key has to be copied over.

To edit them you need the age private key that matches the public key in `.sops.yaml`:

```
sops hosts/waznix/secrets.yaml
```

## Applying it

On the server:

```
git clone https://github.com/WasathTheekshana/nixos ~/nixos
cd ~/nixos
sudo nixos-rebuild switch --flake .#waznix
```

`hardware-configuration.nix` is specific to my machine. On different hardware, regenerate it with `nixos-generate-config` and replace the file.

## CI

GitHub Actions builds the system closure on every push to `main` and on pull requests (`.github/workflows/build.yml`). It only checks that the config evaluates and builds. It does not deploy anything.
