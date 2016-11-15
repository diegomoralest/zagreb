{stdenv, fetchgit}:

stdenv.mkDerivation (rec {

  name = "dotfiles";
  src = fetchgit {
    "url" = "https://github.com/diegomoralest/dotfiles";
    "rev" = "22d182c50988eae10a19f20254efbc8ede37d536";
    "date" = "2016-11-14T19:12:58-05:00";
    "sha256" = "0aibjhx96g9g0sm91kflsd82cgd9pra3a4g0lddypcg0fqpkq3i2";
  };

  meta = {
    description = "Dotfiles for home network";
  };

})
