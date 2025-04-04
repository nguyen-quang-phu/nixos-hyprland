{
  pkgs,
  ags,
  spicetify-nix,
  inputs,
  config,
  ...
}: {
  imports = [
    ./secrets.nix
    ./hardware-configuration.nix
  ];

  bootloader = {
    enableSystemdBoot = true;
    enableRaspberryPi = false;
  };
  fontsModule.enable = true;
  powerOff.enable = true;

  networkModule = {
    enable = true;
    hostName = "nixos";
  };

  virtualisation.docker.enable = true;
  users.users.keynold = {
    isNormalUser = true;
    description = "keynold";
    hashedPasswordFile = config.age.secrets.password-keynold.path;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };
  users.defaultUserShell = pkgs.zsh;

  locale.enable = true;
  programs.nix-ld.enable = true;

  program = {
    cliMinimal.enable = true;
    cliRandom.enable = true;
    funCli.enable = true;
    desktop = {
      browsers.enable = true;
      chatting.enable = true;
      graphics.enable = true;
      misc.enable = true;
      terms.enable = true;
      utils.enable = true;
    };
    dev.enable = true;
    hypr.enable = true;
    river.enable = false;
    lsp.enable = true;
    utils.enable = true;
    uwu.enable = true;
    school.enable = true;
    zsh.enable = true;
  };

  nixModule.enable = true;

  airplay.enable = false;
  firewall = {
    enable = true;
    tcp = [];
    udp = [];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services = {
    blueman.enable = true;

    power-profiles-daemon.enable = true;
    ollama = {
      enable = false;
      acceleration = "cuda";
      # Optional: load models on startup
    };

    fprintd.enable = true;
  };
  virtualisation.waydroid.enable = false;

  mime = {
    enable = true;
    apps = with pkgs; {
      "application/pdf" = zathura;
      "image/svg+xml" = inkscape;

      "image/bmp" = eog;
      "image/gif" = eog;
      "image/jpeg" = eog;
      "image/jpg" = eog;
      "image/jxl" = eog;
      "image/pjpeg" = eog;
      "image/png" = eog;
      "image/tiff" = eog;
      "image/webp" = eog;
      "image/x-bmp" = eog;
      "image/x-gray" = eog;
      "image/x-icb" = eog;
      "image/x-ico" = eog;
      "image/x-png" = eog;
      "image/x-portable-anymap" = eog;
      "image/x-portable-bitmap" = eog;
      "image/x-portable-graymap" = eog;
      "image/x-portable-pixmap" = eog;
      "image/x-xbitmap" = eog;
      "image/x-xpixmap" = eog;
      "image/x-pcx" = eog;
      "image/svg+xml-compressed" = eog;
      "image/vnd.wap.wbmp" = eog;
      "image/x-icns" = eog;

      "video/qicktime" = mpv;
      "application/ogg" = mpv;
    };
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs ags spicetify-nix;};
    users.keynold = {...}: {
      imports = [
        ./home.nix
        ./spicetify.nix
      ];
    };
    backupFileExtension = "backup";
  };
}
