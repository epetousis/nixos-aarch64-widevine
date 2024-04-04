{ runCommand
, chromium
, widevine-cdm-lacros
}:

runCommand "chromium-wv" { version = chromium.version; }
  ''
    mkdir -p $out
    cp -a ${chromium.browser}/* $out/
    chmod u+w $out/libexec/chromium
    cp -Lr ${widevine-cdm-lacros}/WidevineCdm $out/libexec/chromium/
  ''
