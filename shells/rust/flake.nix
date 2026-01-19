{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };

        rustToolchain = pkgs.rust-bin.stable.latest.default.override {
          targets = [ "x86_64-pc-windows-gnu" ];
          extensions = [ "rust-src" "rust-analyzer" ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            rustToolchain
            pkg-config
            openssl
            gcc
            libiconv
            pkgsCross.mingwW64.stdenv.cc
            pkgsCross.mingwW64.windows.pthreads
            wine64
          ];

          CARGO_TARGET_X86_64_PC_WINDOWS_GNU_LINKER =
            "${pkgs.pkgsCross.mingwW64.stdenv.cc}/bin/x86_64-w64-mingw32-gcc";

          # Linker flags for Windows pthread
          CARGO_TARGET_X86_64_PC_WINDOWS_GNU_RUSTFLAGS =
            "-L ${pkgs.pkgsCross.mingwW64.windows.pthreads}/lib";

          shellHook = ''
            echo "Rust development environment loaded"
            echo "rustc: $(rustc --version)"
            echo ""
            echo "Windows cross-compilation ready:"
            echo "  Build: cargo build --target x86_64-pc-windows-gnu"
            echo "  Test:  wine64 target/x86_64-pc-windows-gnu/debug/your_binary.exe"
          '';
        };
      }
    );
}
