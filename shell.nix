let nixpkgs = import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/66acfa3d16eb599f5aa85bda153a24742f683383.tar.gz") {};

    pkgs = nixpkgs.pkgs;

    customizedOpencv4 = pkgs.opencv4.override {
      enableGtk3 = true;
      enableFfmpeg = true;
      enableGStreamer = true;
    };

in pkgs.mkShell rec {
  name = "librealsense";
  buildInputs = with pkgs; [
    llvmPackages_11.clang
    cmake
    cmakeCurses
    pkgconfig

    xorg.libX11
    xorg.libXrandr
    xorg.libXinerama
    xorg.libXcursor
    xorg.libXi
    xorg.libXext
    nlohmann_json
    libGLU
    libusb
    spdlog
    eigen # >= 3.3
    libyamlcpp
    customizedOpencv4
    suitesparse
    openblas
    pangolin

    gperftools
  ];
  shellHook = ''
    export PS1="$(echo -e '\uf277') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
    export CC=clang
    export CXX=clang++
  '';
}
