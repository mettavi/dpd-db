{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          python311
          poetry
        ];
        env = {
          POETRY_VIRTUALENVS_IN_PROJECT = "true";
          POETRY_VIRTUALENVS_PATH = "{project-dir}/.venv";

          # Use python from path, so you can use a different version to the one bundled with poetry
          POETRY_VIRTUALENVS_PREFER_ACTIVE_PYTHON = "true";
        };
      };
    };
}
