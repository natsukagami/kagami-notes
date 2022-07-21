{
  inputs.nixpkgs.url = github:nixOS/nixpkgs;
  inputs.flake-utils.url = github:numtide/flake-utils;

  outputs = inputs: inputs.flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import inputs.nixpkgs { inherit system; };

      tools = with pkgs; [
        # Hugo site generator
        hugo
      ];
    in
    rec
    {
      devShells.default = pkgs.mkShell {
        buildInputs = tools;
      };

      # For compat
      devShell = devShells.default;
    });
}
