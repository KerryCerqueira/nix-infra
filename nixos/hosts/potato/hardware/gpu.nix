{ config, ... }:

{
	hardware.graphics.enable = true;
	hardware.nvidia = {
		package = config.boot.kernelPackages.nvidiaPackages.stable;
		modesetting.enable = true;
		powerManagement.enable = false;
		powerManagement.finegrained = false;
		open = false;
		nvidiaSettings = true;
		prime = {
			intelBusId = "PCI:0:02:0";
			nvidiaBusId = "PCI:59:00:0";
			offload = {
				enable = true;
				enableOffloadCmd = true;
			};
		};
	};
}
