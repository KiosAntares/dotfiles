{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;

    commandLineArgs = [
      "--ignore-gpu-blocklist"
      "--enable-gpu-rasterization"
      "--enable-zero-copy"
      "--disable-gpu-driver-bug-workarounds"
      "--force-dark-mode"
      "--enable-features=WebUIDarkMode"
      "--enable-features=VaapiVideoDecoder"
      "--enable-features=Vulkan"
      "--use-vulkan"
      "--use-gl=egl"
    ];

    extensions = [
      {id = "nngceckbapebfimnlniiiahkandclblb";} # bitwarden
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
      {id = "dbepggeogbaibhgnhhndojpepiihcmeb";} # vimium
      {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # dark reader
      {id = "pcgmedbmchghfgikplcimdmfldfnecec";} # inkah
      {id = "clngdbkpkpeebahjckkjfobafhncgmne";} # stylus
      {id = "mnjggcdmjocbbbhaepdhchncahnbgone";} # sponsorblock
      {id = "gebbhagfogifgggkldgodflihgfeippi";} # return YT dislikes
      {id = "ajopnjidmegmdimjlfnijceegpefgped";} # BTTV
      {id = "ammjkodgmmoknidbanneddgankgfejfh";} # 7TV
      {id = "fadndhdgpmmaapbmfcknlfgcflmmmieb";} # ffz
      {id = "fjbponfbognnefnmbffcfllkibbbobki";} # Eight Dollars (twt)
    ];
  };
}
