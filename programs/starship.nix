{
  programs.starship = {
    enable = true;
    settings = {
      format = "$character";
      right_format = ''
        $jobs
        $cmd_duration
        $conda
        $haskell
        $git_state
        $git_status
        $git_branch
        $directory
      '';
      palette = "josh";
      add_newline = false;
      command_timeout = 1000;
      directory = {
        format = "[ ](bg)[$path ](bg:bg)[](fg:dir bg:bg)[](bg:dir)[](dir)";
        truncation_length = 3;
        truncate_to_repo = false;
        truncation_symbol = "…/";
      };
      git_status = {
        format = "[ ](bg)[$all_status](bg:bg)[$ahead_behind ](bg:bg fg:red)";
      };
      git_state = {
        format = "[$state ($progress_current of $progress_total) ](bg:bg)";
      };
      git_branch = {
        symbol = "";
        format = "[$branch ](bg:bg)[](fg:git bg:bg)[$symbol](bg:git)[](git)";
      };
      cmd_duration = {
        min_time = 1;
        format = "[ ](bg)[$duration ](bg:bg)[](fg:dur bg:bg)[󰚭](bg:dur)[](dur)";
      };
      jobs = {
        symbol = "";
      };
      fill = {
        symbol = " ";
      };
      haskell = {
        symbol = "";
        format = "[ ](bg)[$version ](bg:bg)[](fg:lng bg:bg)[$symbol](bg:lng)[](lng)";
      };
      conda = {
        symbol = "";
        format = "[ ](bg)[$environment ](bg:bg)[](fg:lng bg:bg)[$symbol](bg:lng)[](lng)";
      };
      palettes.josh = {
        bg = "#3C3836";
        dir = "#989719";
        git = "#448488";
        dur = "#B16185";
        lng = "#689D69";
      };
    };
  };
}
