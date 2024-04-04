# nixos-aarch64-widevine

This is a small overlay that wraps the Asahi Linux widevine-installer scripts to create an aarch64-linux compatible Widevine derivation. Made to be a quick fix for tpwrules/nixos-apple-silicon#145.

Currently a flake only.

## Installation

1. Add this repo as a flake input in your flake.nix:

```nix
{
  description = "My system flake";

  inputs = {
    nixos-aarch64-widevine.url = "github:epetousis/nixos-aarch64-widevine";
  };

  outputs = {
    self,
    [...],
    nixos-aarch64-widevine
  }:
  {
    nixosConfigurations."my-aarch64-device" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        [...],
        {
          nixpkgs.overlays = [ nixos-aarch64-widevine.overlays.default ];
        }
      ];
    };
  };
```

2. Add Firefox to your system or user-level packages.

3. In your `configuration.nix`, add the Widevine module to the MOZ_GMP_PATH:

```nix
environment.sessionVariables.MOZ_GMP_PATH = [ "${pkgs.widevine-cdm-lacros}/gmp-widevinecdm/system-installed" ];
```

## Acknowledgements

Mostly adopted from @afilini and @diegobfernandez's work.
