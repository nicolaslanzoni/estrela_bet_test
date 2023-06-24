with (import <nixpkgs> {});
let
  gems = bundlerEnv {
    name = "gems-for-some-project";
    gemdir = ./.;
  };
in mkShell { 
    nativeBuildInputs = with pkgs.buildPackages; [conftest bundix  ];
    #packages = [ gems gems.wrappedRuby  ]; 
    
    }