{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    lua-language-server
    mustache-go
    nodePackages.prettier
    stylua
    vivid
  ];
}
