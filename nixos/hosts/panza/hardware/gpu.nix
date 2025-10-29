{ pkgs, config, lib, ... }:

{
	boot.kernelParams = ["i915.enable_guc=2"];
	boot.initrd.kernelModules = [ "i915" ];
	environment.variables = {
		VDPAU_DRIVER = lib.mkIf config.hardware.graphics.enable (lib.mkDefault "va_gl");
	};
	hardware.graphics.extraPackages = with pkgs; [
		intel-vaapi-driver
		libvdpau-va-gl
		intel-media-driver
	];
	hardware.graphics.extraPackages32 = with pkgs.driversi686Linux; [
		intel-vaapi-driver
		libvdpau-va-gl
		intel-media-driver
	];
}
