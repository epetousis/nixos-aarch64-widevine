final: prev: {
  widevine-installer = final.callPackage ./widevine-installer.nix {};
  widevine-cdm-lacros = final.callPackage ./widevine-cdm-lacros.nix {};

  firefox = prev.firefox.overrideAttrs (old: {
    extraPrefsFiles = [ "${final.widevine-installer}/conf/gmpwidevine.js" ];
    MOZ_GMP_PATH = "${final.widevine-cdm-lacros}/gmp-widevinecdm/system-installed";
  });

  chromium = prev.chromium.overrideAttrs (old: {
    buildCommand = builtins.replaceStrings [ "${prev.chromium.browser}" ] [ "${(final.callPackage ./chromium/chromium-wv.nix {})}" ] old.buildCommand;
  });
}
