{
  description = "Enables Widevine on aarch64-linux hosts using AsahiLinux's widevine-installer";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {

    overlays = rec {
      nixos-aarch64-widevine-overlay = import ./packages/overlay.nix;
      default = nixos-aarch64-widevine-overlay;
    };

  };
}
