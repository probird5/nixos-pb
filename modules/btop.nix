{ config, pkgs, lib, ... }:

{
  programs.btop = {
    enable = true;

    settings = {
      # --- Layout ---
      shown_boxes = "cpu gpu mem net proc";

      # --- GPU ---
      show_gpu = true;
      gpu_graph = true;
      gpu_mem_graph = true;
      gpu_mem_percent = true;
      gpu_name = true;
      gpu_power = true;
      gpu_temp = true;
      gpu_freq = true;

      # --- General ---
      vim_keys = true;
      theme_background = false;
      rounded_corners = true;
      update_ms = 1000;

      # --- Process ---
      proc_tree = true;
      proc_sorting = "cpu lazy";
    };
  };
}

