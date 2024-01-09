{ config, pkgs, ... }:
let 
  sshKeys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAgEAhszcJofDlEtWlPJAbkCLB+v4Pcp6Wj3FvuHnKOKxalCXL1JbsN53cHG3zvca81E3BJwzBA/8BC4iuIO6xZTcgEwU5Uqt5U6NRsB5kV4F9j1fAIfApe0xPMpkALOvcYmJdQg3hIvNyept4vQGq1GtWy5qyf2wIxXy6OM07CXxDPxYCDFCI2DKglDQ+qrABz+8ONY+e1MhqeQw0hejzDHGIcCBB8+iOwp/iIn6QMvSlCxG+8qSl2jL3FPqF93jR28i16uMjQsxGFNEyhIthj8MSpLWl98Dr/VHkfwRyJ0jfB3I3uG+gjzbCNF1wsUkEW8D55vJ2RuX+q0QmQyTSlLTALUA8PGCT4scF1TcRPDatA7Q6K0MufA7xwCs16fm2cvZHDY96TFgP19BqcH9hkwTauNODRVCQ9QRvrqJ45ZUBxjIjEtieGI/vYNtohCmipPNhuKDSX35ngjeF28Te9+/0yr8PKXcBaUqi9cxD6LkO+GiyZyp42lfFK6p7BJSQwIFgKBC4lY4cxxJ2HI45UIaN1R8Hx060RKRX4SLDtinMRLWRnoPQ1qJ4oaFAqiFg3WI/qb75geaFe82AOWqh0+mQ3UjOO6noTFvgsn8XPYSlb9b3VU6Gtrwg+KHHS4MFJZI4299E2izNiG8MgDSmlwHzF4Rq3LS/V3o8obBY4NEv58= cmchick-4096.rsa"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDBgvmfr23k7jjiQNfd2WfWYf0wzl1swTwIzIrcRUqmI greg"
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAILrypPc78fSwWaB8+QRxqIAnYNssrobyObPSOZ9TYNb0AAAABHNzaDo= waffles-green@w4f7z.net"
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIAy6VHgLr3lBvY7Utp9m4A/7a5CPn6VSUb3nYW0SzKS5AAAABHNzaDo= waffles-blue@w4f7z.net"
  ];
in
{
  time.timeZone = "America/New_York";

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

  users.users.magfest = {
    isNormalUser = true;
    description = "magfest";
    extraGroups = [ "wheel" ];
    packages = with pkgs; 
    [
      neofetch
    ];

    openssh.authorizedKeys.keys = sshKeys;
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    htop
    btop
    tmux
    screen
    dnsutils
  ];

  services.openssh = 
  {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  services.openiscsi = {
    enable = true;
    name = "iqn.2017-04.net.magfest.lan.mgt:${config.networking.hostName}";
  };

  users.users."root".openssh.authorizedKeys.keys = sshKeys;

  networking.firewall.enable = false;

  # and stay down
  networking.enableIPv6 = false;
  boot.kernelParams = [ "ipv6.disable=1" ];
  boot.kernel.sysctl."net.ipv6.conf.all.disable_ipv6" = true;

    # Enable BBR congestion control
  boot.kernelModules = [ "tcp_bbr" ];
  boot.kernel.sysctl."net.ipv4.tcp_congestion_control" = "bbr";
  boot.kernel.sysctl."net.core.default_qdisc" = "fq"; # see https://news.ycombinator.com/item?id=14814530

  networking.search = 
  [
      "lan.magfest.net"
      "mgt.lan.magfest.net"
  ];
}
