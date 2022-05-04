with import <nixpkgs> {};

mkShell {
  nativeBuildInputs = [ pkg-config cmake ];
}
