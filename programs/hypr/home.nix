{ pkgs, ... }:

let
  wallpaper = pkgs.fetchurl {
    url = "https://cloud.jeschek.eu/s/6MJ6kZ3itQ5Ea73/download/rivendell.png";
    hash = "sha256-AE3wqoOKXyWsoeUFsVlYqTPDkqpAsQdk3k7qGAn0cmc=";
  };
  screenshotDir = "/home/josh/Pictures/Screenshots";
in

{
  imports = [ ./binds.nix ];

  home.packages = with pkgs; [
    wl-clipboard
    hyprpicker
    hyprshot
    grimblast
    cinnamon.nemo
    bemoji
    rofi
    fuzzel
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      workspace = [
        "6, monitor:HDMI-A-1, default: true"
      ];
      monitor = [
        "HDMI-A-1,1920x1080@60,0x0,1,transform,3"
        "HDMI-A-2,1920x1080@60,0x0,1,transform,3"
        "DP-1,3440x1440@100,1080x250,1"
        "DP-2,3440x1440@100,1080x250,1"
      ];
      env = [
        "GTK_THEME,Adwaita:dark"
      ];
      exec-once = [
        "~/.config/eww/scripts/init"
        "waybar"
      ];
      input = {
        kb_layout = "de";
        kb_variant = "nodeadkeys";
        kb_options = "caps:escape";
        follow_mouse = 2;
        sensitivity = -0.2;
      };
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(ffffff99)";
        layout = "dwindle";
      };
      group = {
        "col.border_active" = "rgba(7c8e76ff)";
        "col.border_inactive" = "rgba(7c8e76aa)";
        groupbar = {
          font_size = 10;
          text_color = "rgba(ebdbb2ff)";
          "col.active" = "rgba(7c8e76ff)";
          "col.inactive" = "rgba(7c8e76aa)";
        };
      };
      cursor = {
        no_hardware_cursors = false;
        inactive_timeout = 0;
        persistent_warps = true;
      };
      misc = {
        font_family = "CaskaydiaCove Nerd Font Mono";
        disable_hyprland_logo = true;
      };
      decoration = {
        rounding = 20;
        blur = {
            size = 5;
            xray = false;
            noise = 0.15;
            brightness = 0.65;
            passes = 2;
        };
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        dim_inactive = false;
        dim_strength = 0.1;
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };
      animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
	    "windows, 1, 5, myBezier"
            "windowsOut, 1, 5, default, popin 80%"
            "border, 1, 10, default"
            "fade, 1, 7, default"
            "workspaces, 1, 3, default"
	  ];
      };
      dwindle = {
          pseudotile = true;
          preserve_split = true;
          force_split = 2;
      };
      master = {
          new_status = "inherit";
      };
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      preload = [
        (builtins.toString wallpaper)
      ];

      wallpaper = [
        "HDMI-A-1,${builtins.toString wallpaper}"
        "HDMI-A-2,${builtins.toString wallpaper}"
        "DP-1,${builtins.toString wallpaper}"
        "DP-2,${builtins.toString wallpaper}"
      ];
    };
  };

  home.sessionVariables = {
    HYPRSHOT_DIR = screenshotDir;
  };
}
