{ pkgs, lib }:

with pkgs;
let
  vim = pkgs.vim_configurable.override {
    config.vim = {
      python = true;
    };
    python = python;
  };

  youcompleteme = pkgs.vimPlugins.YouCompleteMe;
  vimshell = pkgs.vimPlugins.vimshell;
  vundle = pkgs.vimPlugins.vundle;
in
{ inherit vim fast-init youcompleteme vimshell vundle; }
