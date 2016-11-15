{ lib, pkgs }:
rec {
  pkg = pkgs.bash;
  authKeys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD2ycwTgnF690uQxbRho7nv1XAswg/VhbcodEXwf58ssoKi+z3l6Bj1tzAraB+aRv51ZPHcQAGOKaIZNvYEa1R+FW3g6MLRnjIk41w3jeKN56MZNweLpmQ91R5ckCiincy2CTfhQ9G6ufQcaYWWGoMxiY2rjeXHVDBujGB1FKxNWM09WV1qJjaHthFKkjj/f+MPXYBmzHHdD/pcUQadaLy13J93e6M4sfxhmYDsR/01AHDPZEmtRrkV1e+/oNONW4T4w7EmJ6JlGozu+bN/M7lg08bMxeCJUFsCkQzir8le0gZDZXy0Q6l9jYoo792TBywwgBZV0C4Vw6XWDyIdKnhb dmoralest@Diegos-MacBook-Pro.local"];
  
  dimo = rec {
    name = "dimo";
    password = "dimo"; # Change this
    extraGroups = ["wheel" "networkmanager"];
    uid = 1000;
    createHome = true;
    home = "/home/dimo";
    passwordFile = "${home}/.config/passwd";
    shell = "${lib.getBin bash}/bin/bash";
    openssh.authorized.keys = authKeys;
  };

  root = rec {
    name = "root";
    password = "toor"; #change this
  };
}
