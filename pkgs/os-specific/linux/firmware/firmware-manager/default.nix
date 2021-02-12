{ rustPlatform, lib, fetchFromGitHub, lzma, pkg-config, openssl, dbus, glib, udev, cairo, pango, atk, gdk-pixbuf, gtk3, wrapGAppsHook }:
rustPlatform.buildRustPackage rec {
  pname = "firmware-manager";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = pname;
    rev = version;
    sha256 = "0x9604jsflqxvbkfp139mzjicpyx8v21139jj8bp88c14ngvmdlw";
  };

  nativeBuildInputs = [ pkg-config wrapGAppsHook ];

  buildInputs = [ lzma openssl dbus glib udev cairo pango atk gdk-pixbuf gtk3 ];

  depsExtraArgs.postPatch = "make prefix='$(out)' toml-gen";

  postPatch = ''
    sed -i 's|etc|$(prefix)/etc|' Makefile
  '';

  buildPhase = "make prefix='$(out)'";

  installPhase = "make prefix='$(out)' install";

  cargoSha256 = "0jqy4xb6dlaw33s2bd7drw5dcmayd80vlwcb3fhs8j57dc3wdwd1";

  doCheck = false;

  meta = {
    description = "Graphical frontend for firmware management";
    homepage = "https://github.com/pop-os/firmware-manager";
    license = lib.licenses.gpl3;
    maintainers = [ lib.maintainers.shlevy ];
    platforms = lib.platforms.linux;
  };
}
