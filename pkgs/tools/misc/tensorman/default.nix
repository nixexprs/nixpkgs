{ pkg-config, lib, rustPlatform, rustc, cargo, docker, openssl, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "tensorman";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "tensorman";
    rev = version;
    sha256 = "0ywb53snvymmwh10hm6whckz7dwmpqa4rxiggd24y178jdfrm2ns";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];
  cargoSha256 = "1cgwfz3wckknxn6cdy2msj063clzpczkv3rhzdv0xpp1bm6fdcgh";

  meta = with lib; {
    description = "Utility for easy management of Tensorflow containers";
    homepage = "https://github.com/pop-os/tensorman/";
    license = lib.licenses.gpl3;
    platforms =  [ "x86_64-linux" ];
    maintainers = with maintainers; [ thefenriswolf ];
  };
}
