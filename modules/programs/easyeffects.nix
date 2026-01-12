{inputs, ...}: {
  flake.homeModules.easyeffects = {...}: let
    ee-presets = inputs.easyeffects-presets;
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
