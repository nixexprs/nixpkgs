{ lib, fetchFromGitHub, installShellFiles, rustPlatform, rustfmt, xorg
, pkg-config, llvmPackages, clang, protobuf, python3 }:

rustPlatform.buildRustPackage rec {
  pname = "clipcat";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "xrelkd";
    repo = pname;
    rev = "v${version}";
    sha256 = "0rxl3ksjinw07q3p2vjqg80k3c6wx2q7pzpf2344zyfb4gkqzx1c";
  };

  cargoSha256 = "16xxhnfjyghsmw15jsnrsiyxhcmnr3l2s86w3y5hd710d3b701w8";

  LIBCLANG_PATH = "${llvmPackages.libclang}/lib";

  # needed for internal protobuf c wrapper library
  PROTOC = "${protobuf}/bin/protoc";
  PROTOC_INCLUDE = "${protobuf}/include";

  nativeBuildInputs = [
    pkg-config

    clang
    llvmPackages.libclang

    rustfmt
    protobuf

    python3

    installShellFiles
  ];
  buildInputs = [ xorg.libxcb ];

  cargoBuildFlags = [ "--features=all" ];

  postInstall = ''
    installShellCompletion --bash completions/bash-completion/completions/*
    installShellCompletion --fish completions/fish/completions/*
    installShellCompletion --zsh  completions/zsh/site-functions/*
  '';

  meta = with lib; {
    description = "Clipboard Manager written in Rust Programming Language";
    homepage = "https://github.com/xrelkd/clipcat";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
    maintainers = with maintainers; [ xrelkd ];
  };
}
