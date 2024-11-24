{ pkgs, ... }:

let
  muttWizardMuttrc = builtins.fetchurl {
    name = "mutt-wizard.muttrc";
    url = "https://raw.githubusercontent.com/LukeSmithxyz/mutt-wizard/refs/heads/master/share/mutt-wizard.muttrc";
    sha256 = "sha256-Il3HWitdnwq5xoXS5pE8+Ve6iuXMaY/qNtrWwN7K8f0=";
  };

  configPath = "~/.config/mutt";
  mailPath = ".local/share/mail";
  cachePath = "~/.cache/mail";

  muttrc = ''
    source ${configPath}/mutt-wizard.muttrc

    source ${configPath}/mymuttrc

  '';

  defaults = {
    mbsync.enable = true;
    mbsync.create = "both";
    thunderbird.enable = true;
    neomutt.enable = true;
  };

  accounts = builtins.listToAttrs (builtins.map
    (account: { name = account.address; value = defaults // account; })
    (import ./../../private/_email.nix).accounts);

  debugAccounts = pkgs.runCommand "pretty-json" {} ''
    echo '${builtins.toJSON accounts}' | ${pkgs.jq}/bin/jq '.' > $out
  '';

in

{
  programs.thunderbird = {
    enable = true;
    profiles.default.isDefault = true;
  };
  accounts.email.maildirBasePath = mailPath;
  accounts.email.accounts = builtins.trace (builtins.readFile debugAccounts) accounts;

  programs.mbsync = {
    enable = true;
  };

  home.file = {
    ".config/mutt/mymuttrc".source = ./mymuttrc;
    ".config/mutt/mutt-wizard.muttrc".source = muttWizardMuttrc;
    ".config/mutt/next.muttrc".text = muttrc;
  };
}
