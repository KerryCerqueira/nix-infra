{...}: {
  flake.homeModules.easyeffects = {pkgs, ...}: let
    ee-presets = pkgs.fetchFromGitHub {
      owner = "JackHack96";
      repo = "EasyEffects-Presets";
      rev = "a1a2dc6f5052ca14dccbed8228f7b29ae90e4238";
      hash = "sha256-9lSYaWGIQ9K53NwQULmbdDxnS4NijmnOEUvFQWjEF08=";
    };
      in {
    services.easyeffects = {
      enable = true;
      preset = "AdvancedAutoGain";
    };
    xdg.configFile = {
      "easyeffects/output/Advanced Auto Gain.json".source = "${ee-presets}/Advanced Auto Gain.json";
      "easyeffects/output/Bass Boosted.json".source = "${ee-presets}/Bass Boosted.json";
      "easyeffects/output/Bass Enhanced + Perfect EQ.json".source = "${ee-presets}/Bass Enhanced + Perfect EQ.json";
      "easyeffects/output/Boosted.json".source = "${ee-presets}/Boosted.json";
      "easyeffects/output/Loudness+Autogain.json".source = "${ee-presets}/Loudness+Autogain.json";
      "easyeffects/output/Perfect EQ.json".source = "${ee-presets}/Perfect EQ.json";
    };
  };
}
