{ pkgs
, stdenv
, fetchurl
, curl
, widevine-installer
}:

stdenv.mkDerivation rec {
  name = "widevine-cdm-lacros";
  version = "120.0.6098.0";
  buildInputs = [ curl widevine-installer ];

  src = fetchurl {
    urls = [ "https://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/chromeos-lacros-arm64-squash-zstd-${version}" ];
    hash = "sha256-OKV8w5da9oZ1oSGbADVPCIkP9Y0MVLaQ3PXS3ZBLFXY=";
  };

  unpackPhase = "true";
  installPhase = ''
    mkdir -p "$out/"
    COPY_CONFIGS=0 INSTALL_BASE="$out" DISTFILES_BASE="file://$src" widevine-installer
    '';
}
