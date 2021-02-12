{ lib, fetchFromGitHub, rustPlatform, libX11, libXinerama, makeWrapper }:

let
    rpath = lib.makeLibraryPath [ libXinerama libX11 ];
in

rustPlatform.buildRustPackage rec {
  pname = "leftwm";
  version = "0.2.5";

  src = fetchFromGitHub {
    owner = "leftwm";
    repo = "leftwm";
    rev = version;
    sha256 = "03kk3vg0r88317zv8j2bj44wq2fwxi25rv1aasvayrh1i5j6zr10";
  };

  cargoSha256 = "1vjzg6rc6lqws265dapi62ncf0fs663apyllbwfh98h9aa2gw6cc";

  buildInputs = [ makeWrapper libX11 libXinerama ];

  postInstall = ''
    wrapProgram $out/bin/leftwm --prefix LD_LIBRARY_PATH : "${rpath}"
    wrapProgram $out/bin/leftwm-state --prefix LD_LIBRARY_PATH : "${rpath}"
    wrapProgram $out/bin/leftwm-worker --prefix LD_LIBRARY_PATH : "${rpath}"
  '';

  meta = with lib; {
    description = "A tiling window manager for the adventurer";
    homepage = "https://github.com/leftwm/leftwm";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [ mschneider ];
  };
}
