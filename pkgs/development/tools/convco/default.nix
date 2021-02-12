{ lib, rustPlatform, fetchFromGitHub, stdenv, openssl, perl, pkg-config, libiconv, Security }:

rustPlatform.buildRustPackage rec {
  pname = "convco";
  version = "0.3.2";

  src = fetchFromGitHub {
    owner = "convco";
    repo = pname;
    rev = "v${version}";
    sha256 = "0fqq6irbq1aikhhw08gc9kp0vbk2aminfbvwdlm58cvywyq91bn4";
  };

  cargoSha256 = "0fbdnrgmviqns8ym3306wz9bfxzfixvxa18zbrspjhycy1sm3hzj";

  nativeBuildInputs = [ openssl perl pkg-config ];

  buildInputs = lib.optionals stdenv.isDarwin [ libiconv Security ];

  meta = with lib; {
    description = "A Conventional commit cli";
    homepage = "https://github.com/convco/convco";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ hoverbear ];
  };
}
