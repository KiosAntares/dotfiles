self: super: rec {
  davis = super.callPackage ./davis {};
  an-anime-game-launcher = super.callPackage ./an-anime-game-launcher {};
  grimblast = super.callPackage ./grimblast {};
  lyrics-in-terminal = super.callPackage ./lyrics-in-terminal {};
  reminder = super.callPackage ./reminder {};
  podliner = super.callPackage ./podliner {};
  dawn = super.callPackage ./dawn {};
}
