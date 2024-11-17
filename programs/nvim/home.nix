{ pkgs, ... }:

{
  xdg.configFile.nvim.source = ./config;
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  home.packages = with pkgs; [
    lua-language-server
  ];
}
