{
  pkgs,
  user,
  host,
  unfree,
  flake,
  ...
}:

{
  imports = [ ./hardware-config.nix ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = unfree;

  swapDevices = [ { device = "/swap/swapfile"; } ];

  services.fstrim.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.supportedFilesystems = [ "xfs" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";

  boot.initrd.compressor = "zstd";
  boot.initrd.systemd.enable = true;

  hardware.enableAllFirmware = true;
  services.fwupd.enable = true;

  networking.hostName = host;
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  time.timeZone = "Asia/Shanghai";

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  users = {
    defaultUserShell = pkgs.fish;
    users.${user} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };

  programs.fish = {
    enable = true;
    vendor.config.enable = true;
    vendor.functions.enable = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      Ciphers = [
        "chacha20-poly1305@openssh.com"
        "aes256-gcm@openssh.com"
      ];
      KexAlgorithms = [
        "mlkem768x25519-sha256"
        "sntrup761x25519-sha512"
        "sntrup761x25519-sha512@openssh.com"
      ];
      Macs = [
        "hmac-sha2-512-etm@openssh.com"
        "hmac-sha2-256-etm@openssh.com"
      ];
    };
  };

  console.enable = false;

  environment.systemPackages = with pkgs; [
    git
  ];

  programs.gnupg.agent.enable = true;

  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "daily";
      extraArgs = "--nogcroots";
    };
    flake = flake;
  };

  i18n = {
    defaultLocale = "zh_CN.UTF-8";
    supportedLocales = [
      "zh_CN.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
  };

  documentation.man.generateCaches = false;

  system.stateVersion = "25.05";
}
