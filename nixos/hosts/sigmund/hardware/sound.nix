{ ... }:

{
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		extraConfig.pipewire = {
			"context.properties" = {
				"default.clock.rate" = 48000;
				"default.clock.quantum" = 4092;
				"default.clock.min-quantum" = 4092;
				"default.clock.max-quantum" = 8192;
			};
		};

		extraConfig.pipewire-pulse."92-low-latency" = {
			"context.properties" = [
				{
					name = "libpipewire-module-protocol-pulse";
					args = { };
				}
			];
			"pulse.properties" = {
				"pulse.min.req" = "4092/48000";
				"pulse.default.req" = "4092/48000";
				"pulse.max.req" = "4092/48000";
				"pulse.min.quantum" = "4092/48000";
				"pulse.max.quantum" = "8192/48000";
			};
			"stream.properties" = {
				"node.latency" = "4092/48000";
				"resample.quality" = 1;
			};
		};
	};
}
