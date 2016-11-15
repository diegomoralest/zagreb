{ config, pkgs, ... }:
let
  myPkgs = import ./pkgs.nix { inherit pkgs lib myLib; };
  myLib  = import ./lib.nix  { inherit pkgs lib; };

  dimo = myLib.dimo;

in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./fs.nix
    ];

  # Services to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable DBus
  services.dbus.enable    = true;

  # Replace nptd by timesyncd
  services.timesyncd.enable = true;
  
  # kvm
  boot.kernelModules = [ "kvm-amd" "tun" "virtio" ];

  # Enable Xen virtualisation
  virtualisation.xen.enable = true;

  # Memory size
  virtualisation.xen.domain0MemorySize = 768;

  networking = {
    hostName = "zagreb"; # Define your hostname.
    interfaceMonitor.enable = true; # Watch for plugged cable.
    firewall.enable = true;
    wireless.enable = true;
    enableWLAN = true;  # Enables Wireless.
  };

  programs.ssh.startAgent = false;

  environment.systemPackages = with pkgs;
    let
      basePkgs = [
        curl              # transfer data to/from a URL
        dos2unix          # text file conversion
        file              # file information
        findutils
        git               # version control system
        htop              # top replacement
        iputils
        jq                # json parsing
        kvm
        manpages          # system manpages (not included by default)
        mkpasswd          # UNIX password creator
        myPkgs.syntastic
        myPkgs.vim        # slight improvement over vi
        myPkgs.vimshell 
        myPkgs.vundle 
        myPkgs.youcompleteme 
        netcat
        nettools
        nmap              # stats about clients in the network
        rsync
        rsync             # file syncing tool
        silver-searcher   # file content searcher, > ack > grep
        smartmontools     # check disk state
        stow              # dotfile management
        tmux              # detachable terminal multiplexer
        traceroute        # trace ip routes
        wget              # the other URL file fetcher
        wirelesstools     # iwlist (wifi scan)
      ];
  in basePkgs;

  # custom packages
  nixpkgs.config.packageOverrides = pkgs: rec {
    dotfiles = pkgs.callPackage ./dotfiles.nix { };
  };

  security.sudo.configFile =
    ''
      Defaults:root,%wheel env_keep+=LOCALE_ARCHIVE
      Defaults:root,%wheel env_keep+=NIX_PATH
      Defaults:root,%wheel env_keep+=TERMINFO_DIRS
      Defaults env_keep+=SSH_AUTH_SOCK
      Defaults lecture = never
      root   ALL=(ALL) SETENV: ALL
      %wheel ALL=(ALL) NOPASSWD: ALL, SETENV: ALL
    '';

  ###########
  # Services

  services.openssh.enable = true;

  time.timeZone = "America/Bogota";

  # bounded journal size
  services.journald.extraConfig = "SystemMaxUse=50M";

  ########
  # Users
  users.mutableUsers = false;
  users.users = { 
    inherit root;
    inherit dimo; 
  };
}
