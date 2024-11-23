{ modulesPath, pkgs, ... }:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    "${modulesPath}/installer/cd-dvd/channel.nix"
  ];

  # Enables copy / paste when running in a KVM with spice.
  # services.spice-vdagentd.enable = true;

  users.users.nixos.shell = pkgs.zsh;
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    mkpasswd
    nixpkgs-fmt
    ripgrep
    tree
    xclip # for clipboard support in neovim
    git
    curl
    rsync
  ];

  services = {
    qemuGuest.enable = true;
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings.PermitRootLogin = "yes";
    };
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    warn-dirty = false;
  };

  system.stateVersion = "23.11";

  home-manager.users.nixos = {
    home.stateVersion = "23.11";

    programs = {
      alacritty.enable = true;
      fzf.enable = true; # enables zsh integration by default
      starship.enable = true;

      zsh = {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = true;
      };

      neovim = {
        enable = true;
      };
    };
  };

  # Use faster squashfs compression
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}
