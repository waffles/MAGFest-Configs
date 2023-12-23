# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.magfest = {
    isNormalUser = true;
    description = "magfest";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; 
    [

    ];
    openssh.authorizedKeys.keys =
    [ 
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDjmMxX/Iu+n6ngK018U9zj+tpqmbZZ+RSOPh7OTnp4YfbtAx4qGEdjNhxmZTrUWukOJbdf16W7yRQi0rOGz4XjcWH6Q//53LHTHon7yLApVRIQXEa6ed1DLaGm8f6aXn1L6W6xQ1BGcR/hzL12C11CcF4H3Dc6nV6T7MoDCESr0umxian2PZ3p1B5qbaW26L7P2Zm6ZhYCPDfZfGmEQPGDnY1vYpZfG2Y3r5lOsnz01JCWpB2Nviws/t/JpwfjxRqZobtDDRlo1l3PTVNvDgwucrE4wUthI1jYMj310LD8TToJWQ8WrNwGLdw1iL3AnY9ok9nBos5wBWFNdOLNn/1cKs9rEPMdyaqSvunbJgV0kSDuJYsU7m4QR/lHOApd9ANOkwTQqQ4LLlpiDFbmUNKoZ+Kr+TitfiGzxTIUHnsnB0ahYDNnaCDGj4oh4j4mlqHIYa9sTnyX1K2ZusLixMdhD2gdjIrWw8pXz9jcJ2Dp5WoNwVs+JHhNLyUVcboJ/DHyNjqc07/ZoONaXDHBP3UXlgDJ8PhMMQEilFlwfoodEyHYAEpSQNUR9oeGOteM8J1IUY3rQY8aHTwYitd9Xf7O7fjMXraWJ4UuBQc3ihoPIEgZLdPdfEDkRt9aWB2V08Mf2rOGz7nY3f0ovH2POaR/Skm7cdeZAvr+BQWoipLnBw== waffles@w4f7z.net" 
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    htop
    tmux
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = 
  {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  users.users."root".openssh.authorizedKeys.keys =
  [ 
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDjmMxX/Iu+n6ngK018U9zj+tpqmbZZ+RSOPh7OTnp4YfbtAx4qGEdjNhxmZTrUWukOJbdf16W7yRQi0rOGz4XjcWH6Q//53LHTHon7yLApVRIQXEa6ed1DLaGm8f6aXn1L6W6xQ1BGcR/hzL12C11CcF4H3Dc6nV6T7MoDCESr0umxian2PZ3p1B5qbaW26L7P2Zm6ZhYCPDfZfGmEQPGDnY1vYpZfG2Y3r5lOsnz01JCWpB2Nviws/t/JpwfjxRqZobtDDRlo1l3PTVNvDgwucrE4wUthI1jYMj310LD8TToJWQ8WrNwGLdw1iL3AnY9ok9nBos5wBWFNdOLNn/1cKs9rEPMdyaqSvunbJgV0kSDuJYsU7m4QR/lHOApd9ANOkwTQqQ4LLlpiDFbmUNKoZ+Kr+TitfiGzxTIUHnsnB0ahYDNnaCDGj4oh4j4mlqHIYa9sTnyX1K2ZusLixMdhD2gdjIrWw8pXz9jcJ2Dp5WoNwVs+JHhNLyUVcboJ/DHyNjqc07/ZoONaXDHBP3UXlgDJ8PhMMQEilFlwfoodEyHYAEpSQNUR9oeGOteM8J1IUY3rQY8aHTwYitd9Xf7O7fjMXraWJ4UuBQc3ihoPIEgZLdPdfEDkRt9aWB2V08Mf2rOGz7nY3f0ovH2POaR/Skm7cdeZAvr+BQWoipLnBw== waffles@w4f7z.net" 
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
