final: prev: {
  widevine-installer = final.callPackage ./widevine-installer.nix {};
  widevine-cdm-lacros = final.callPackage ./widevine-cdm-lacros.nix {};

  # TODO: wrap the Firefox binary without triggering a rebuild
  /* firefox-unwrapped = prev.firefox-unwrapped.overrideAttrs (p: {
    postFixup = ''
      wrapProgram $out/bin/firefox --set MOZ_GMP_PATH "${final.widevine-cdm-lacros}/gmp-widevinecdm/system-installed"
    '';
  }); */

  firefox = prev.firefox.override (p: {
    extraPrefsFiles = [ "${final.widevine-installer}/conf/gmpwidevine.js" ];
  });

  chromium = prev.chromium.overrideAttrs (old: {
    buildCommand = builtins.replaceStrings [ "${prev.chromium.browser}" ] [ "${(final.callPackage ./chromium/chromium-wv.nix {})}" ] old.buildCommand;
  });
}
