{
  lib,
  config,
  ...
}: {
  options = {
    networkModule.enable = lib.mkEnableOption "Enable the custom network module";
    networkModule.hostName = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
      description = "The hostname";
    };
  };

  config = lib.mkIf config.networkModule.enable {
    services.nextdns.enable = true;
    services.nextdns.arguments = ["-config" "10.0.3.0/24=abcdef" "-cache-size" "10MB"];
    # environment.etc = {
    #   "resolv.conf".text = "nameserver 1.1.1.1\n";
    # };

    services.resolved = {
      enable = true;
      dnssec = "true";
      domains = ["~."];
      fallbackDns = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
      dnsovertls = "true";
    };

    systemd = {
      # allow for the system to boot without waiting for the network interfaces are online
      network.wait-online.enable = false;

      services = {
        # https://github.com/systemd/systemd/blob/e1b45a756f71deac8c1aa9a008bd0dab47f64777/NEWS#L13
        NetworkManager-wait-online.enable = false;

        # disable networkd and resolved from being restarted on configuration changes
        # also prevents failures from services that are restarted instead of stopped
        systemd-networkd.stopIfChanged = false;
        systemd-resolved.stopIfChanged = false;
      };
    };
    networking = {
      useDHCP = false;
      useNetworkd = true;

      # interfaces are assigned names that contain topology information (e.g. wlp3s0) and thus should be consistent across reboots
      # this already defaults to true, we set it in case it changes upstream
      usePredictableInterfaceNames = true;

      # dns
      nameservers = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];

      enableIPv6 = true;

      hostName = config.networkModule.hostName;
      networkmanager.enable = true;
      # Allow for `http://👻` thx to @elmo@chaos.social
      hosts = {
        "127.0.0.1" = ["xn--9q8h" "localghost"];
      };
    };
  };
}
