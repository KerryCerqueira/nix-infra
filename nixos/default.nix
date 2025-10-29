{ self, inputs, ... }:

{
	flake.nixosConfigurations = {
		claudius = inputs.nixpkgs.lib.nixosSystem {
			specialArgs = {
				inherit inputs;
			};
			modules = [
				./hosts/claudius
				inputs.sops-nix.nixosModules.sops
				inputs.home-manager.nixosModules.home-manager {
					home-manager = {
						extraSpecialArgs = {
							inherit inputs;
						};
						useGlobalPkgs = true;
						useUserPackages = true;
						users.kerry = self.homeModules."kerry@claudius";
						backupFileExtension = "bkp";
						sharedModules = [
							inputs.sops-nix.homeManagerModules.sops
							inputs.catppuccin.homeModules.catppuccin
						];
					};
				}
			];
		};
		lazarus = inputs.nixpkgs.lib.nixosSystem {
			specialArgs = {
				inherit inputs;
			};
			modules = [
				./hosts/lazarus
				inputs.sops-nix.nixosModules.sops
				inputs.home-manager.nixosModules.home-manager {
					home-manager = {
						extraSpecialArgs = {
							inherit inputs;
						};
						useGlobalPkgs = true;
						useUserPackages = true;
						users.julie = self.homeModules."julie@lazarus";
						users.kerry = self.homeModules."kerry@lazarus";
						backupFileExtension = "bkp";
						sharedModules = [
							inputs.sops-nix.homeManagerModules.sops
							inputs.catppuccin.homeModules.catppuccin
						];
					};
				}
			];
		};
		panza = inputs.nixpkgs.lib.nixosSystem {
			specialArgs = {
				inherit inputs;
			};
			modules = [
				./hosts/panza
				inputs.sops-nix.nixosModules.sops
				inputs.home-manager.nixosModules.home-manager {
					home-manager = {
						extraSpecialArgs = {
							inherit inputs;
						};
						useGlobalPkgs = true;
						useUserPackages = true;
						users.kerry = self.homeModules."kerry@panza";
						users.erika = self.homeModules."erika@panza";
						backupFileExtension = "bkp";
						sharedModules = [
							inputs.sops-nix.homeManagerModules.sops
							inputs.catppuccin.homeModules.catppuccin
						];
					};
				}
			];
		};
		potato = inputs.nixpkgs.lib.nixosSystem {
			specialArgs = {
				inherit inputs;
			};
			modules = [
				inputs.sops-nix.nixosModules.sops
				./hosts/potato
				inputs.home-manager.nixosModules.home-manager
				{
					home-manager = {
						extraSpecialArgs = {
							inherit inputs;
						};
						useGlobalPkgs = true;
						useUserPackages = true;
						users.erika = self.homeModules."erika@potato";
						users.kerry = self.homeModules."kerry@potato";
						backupFileExtension = "bkp";
						sharedModules = [
							inputs.sops-nix.homeManagerModules.sops
							inputs.catppuccin.homeModules.catppuccin
						];
					};
				}
			];
		};
		sigmund = inputs.nixpkgs.lib.nixosSystem {
			specialArgs = {
				inherit inputs;
			};
			modules = [
				./hosts/sigmund
				inputs.sops-nix.nixosModules.sops
				inputs.home-manager.nixosModules.home-manager {
					home-manager = {
						extraSpecialArgs = {
							inherit inputs;
						};
						useGlobalPkgs = true;
						useUserPackages = true;
						users.kerry = self.homeModules."kerry@sigmund";
						backupFileExtension = "bkp";
						sharedModules = [
							inputs.sops-nix.homeManagerModules.sops
							inputs.catppuccin.homeModules.catppuccin
						];
					};
				}
			];
		};
	};
}
