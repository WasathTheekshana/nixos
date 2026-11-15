{ config, pkgs, ... }:

{
  networking.networkmanager.enable = false;

  sops.secrets.wifi_psk_home = { };

  sops.templates."wifi-secrets.env".content = ''
    psk_home=${config.sops.placeholder.wifi_psk_home}
  '';

  networking.wireless = {
    enable = true;
    secretsFile = config.sops.templates."wifi-secrets.env".path;

    networks = {
      "Wazath_2.4GHz" = {
        pskRaw = "ext:psk_home"; # looks up psk_home in the rendered secrets file
      };

      # Add more networks as needed; higher priority wins when several are in range
      # "BackupSSID" = {
      #   pskRaw = "ext:psk_backup";
      #   priority = 5;
      # };
    };
  };

  systemd.services.wifi-powersave-off = {
    description = "Disable Wi-Fi power saving";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'for i in /sys/class/net/*/wireless; do ${pkgs.iw}/bin/iw dev $(basename $(dirname $i)) set power_save off || true; done'";
    };
  };
}
