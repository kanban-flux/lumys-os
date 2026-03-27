{
  description = "The Lumys OS Agent OS";
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-flake.url = "github:juspay/rust-flake";
  };
  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.rust-flake.flakeModules.default
        inputs.rust-flake.flakeModules.nixpkgs
      ];
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        lib,
        ...
      }: {
        rust-project.src = lib.sources.cleanSource ./.;
        rust-project.defaults.perCrate.crane.args.buildInputs = with pkgs; [
          clang
          openssl
          pkg-config
        ];
        rust-project.crates.lumys-desktop.crane.args.buildInputs = with pkgs; [
          atk
          glib
          gtk3
          openssl
          pkg-config
          webkitgtk_4_1
        ];

        packages.default = self'.packages.lumys-cli;
        apps = {
          lumys-cli = {
            program = "${self'.packages.lumys-cli}/bin/lumys";
            meta.description = "CLI tool for the Lumys OS Agent OS";
          };
          lumys-desktop = {
            program = "${self'.packages.lumys-desktop}/bin/lumys-desktop";
            meta.description = "Native desktop application for the Lumys OS Agent OS (Tauri 2.0)";
          };
          default = self'.apps.lumys-cli;
        };
      };
      flake = {
      };
    };
}
