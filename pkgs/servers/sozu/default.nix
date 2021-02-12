{ lib, stdenv, rustPlatform, fetchFromGitHub, darwin }:

rustPlatform.buildRustPackage rec {
  pname = "sozu";
  version = "0.11.50";

  src = fetchFromGitHub {
    owner = "sozu-proxy";
    repo = pname;
    rev = version;
    sha256 = "1srg2b8vwc4vp07kg4fizqj1rbm9hvf6hj1mjdh6yvb9cpbw3jz7";
  };

  cargoSha256 = "ut9yrguIJ5F49/O/z5xpkWh4vRZmcD1lXmfVlxG46Tk=";

  buildInputs =
    lib.optional stdenv.isDarwin darwin.apple_sdk.frameworks.Security;

  meta = with lib; {
    description =
      "Open Source HTTP Reverse Proxy built in Rust for Immutable Infrastructures";
    homepage = "https://www.sozu.io";
    license = licenses.agpl3;
    maintainers = with maintainers; [ Br1ght0ne ];
  };
}
