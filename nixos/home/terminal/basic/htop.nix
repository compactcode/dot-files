{ ... }:

{
  programs.htop = {
    enable = true;
    fields = [
       "PID" "USER" "M_SIZE" "M_RESIDENT" "PERCENT_CPU" "PERCENT_MEM" "TIME" "COMM"
    ];
    showProgramPath = false;
  };
}
