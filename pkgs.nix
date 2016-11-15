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
  syntastic = pkgs.vimPlugins.Syntastic;
in
{ inherit vim youcompleteme vimshell vundle syntastic; }
