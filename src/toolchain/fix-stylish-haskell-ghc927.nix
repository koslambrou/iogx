{ pkgs, src, ... }:

pkgs.writeShellApplication {

  name = "fix-stylish-haskell";

  runtimeInputs = [
    pkgs.fd
    src.toolchain.stylish-haskell-ghc927
  ];

  text = ''
    if [ ! -f .stylish-haskell.yaml ]; then 
      echo ".stylish-haskell.yaml not found in the current directory, skipping"
    else 
      fd \
        --extension hs \
        --exclude 'dist-newstyle/*' \
        --exclude 'dist/*' \
        --exclude '.stack-work/*' \
        --exec bash -c "stylish-haskell -c .stylish-haskell.yaml -i {}"
    fi
  '';
}
