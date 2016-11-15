{stdenv, fetchgit}:

stdenv.mkDerivation (rec {

  name = "dotfiles";
  src = fetchgit {
    "url" = "https://github.com/diegomoralest/dotfiles";
    "rev" = "a900fceea66ab10c126fa0351be3bbe9e8704978";
    "date" = "2016-11-14T20:51:12-05:00";
    "sha256" = "1adinqny1883675di0d9scs1398mr725qp9s65vh12sji58x6kz3";
  };

  meta = {
    description = "Dotfiles for home network";
  };

})
