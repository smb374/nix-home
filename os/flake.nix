{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nix-ld-rs = {
      url = "github:nix-community/nix-ld-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-ld-rs, ... }@attrs:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.smb374-nix = nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = attrs;
      modules = [
        ./configuration.nix
	{ programs.nix-ld.package = nix-ld-rs.packages.${system}.nix-ld-rs; }
      ];
    };
  };
}
