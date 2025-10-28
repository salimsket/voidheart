{
  description = "Node.js development environment with pnpm";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nodejs_22
            nodePackages.pnpm
            patchelf
          ];

          shellHook = ''
            export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [
              pkgs.stdenv.cc.cc
              pkgs.openssl
              pkgs.zlib
            ]}

            # Create a pnpm wrapper that patches workerd after install
            mkdir -p .nix-shell
            cat > .nix-shell/pnpm-wrapper << 'EOF'
#!/usr/bin/env bash
${pkgs.nodePackages.pnpm}/bin/pnpm "$@"
if [[ "$1" == "install" ]] || [[ "$1" == "i" ]] || [[ "$1" == "add" ]]; then
  for workerd in node_modules/.pnpm/@cloudflare+workerd-linux-64@*/node_modules/@cloudflare/workerd-linux-64/bin/workerd; do
    if [ -f "$workerd" ]; then
      echo "Patching $workerd..."
      ${pkgs.patchelf}/bin/patchelf --set-interpreter "$(cat ${pkgs.stdenv.cc}/nix-support/dynamic-linker)" "$workerd"
      ${pkgs.patchelf}/bin/patchelf --set-rpath "${pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc pkgs.openssl pkgs.zlib ]}" "$workerd"
    fi
  done
fi
EOF
            chmod +x .nix-shell/pnpm-wrapper
            alias pnpm="$PWD/.nix-shell/pnpm-wrapper"

            echo "Node.js $(node --version)"
            echo "pnpm $(${pkgs.nodePackages.pnpm}/bin/pnpm --version)"
            echo ""
            echo "Development environment ready!"
          '';
        };
      }
    );
}