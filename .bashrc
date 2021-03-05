# -------------------- GENERAL -------------------- #

## if user is not root, pass all commands via sudo #
if [ $UID -ne 0 ]; then
    alias reboot="sudo reboot"
    alias update="sudo apt-get upgrade"
fi



# -------------------- CONSOLE -------------------- #

## Reload Bash
alias reload="source ~/.bashrc"

## Clear Screen
alias c="clear"

## Colorize the ls output ##
alias ls="ls --color=auto"
 
## Use a long listing format ##
alias ll="ls -la"

## a quick way to get out of current directory ##
alias ..="cd .."
alias ...="cd ../../../"


# -------------------- DEVELOPER TOOLS -------------------- #

## HTTP Server from directory
alias www="python -m SimpleHTTPServer 8000"

## External & Internal IP
alias ipi="ipconfig getifaddr en0"
alias ipe="curl ipinfo.io/ip"

## Downloader
alias wget="wget -c "

# ------------------- QUICK SSH ----------------- #
QuickSSH() {
  HOST=$1
  CMD=$2
  echo $1 $2

  if [ "$CMD" = "poweroff" ]; then 
    eval "ssh –t $HOST 'sudo poweroff'"
  elif [ "$CMD" = "reboot" ]; then 
    eval "ssh –t $HOST 'sudo reboot'"
  else
    echo "Use 'poweroff' or 'reboot'"
  fi

  echo $RESULT
  
}

alias qs="QuickSSH "

# ----------------- TIME MACHINE ---------------- #
TimeMachine() {
  OP=$1 || "help"
  MOD=$2 || 1

  # Set Defaults
  if [ -z "$OP" ]; then OP="-h"; fi
  if [ -z "$MOD" ]; then MOD=1; fi

  # Optimize
  if [ "$OP" = "optimize" ] || [ "$OP" = "-o" ]; then
    eval "sudo sysctl debug.lowpri_throttle_enabled=$MOD"

    check_status=$(sysctl debug.lowpri_throttle_enabled)
    if [ "$check_status" != "debug.lowpri_throttle_enabled: 1" ]; then
      echo "TM: Optimization - ENABLED"
    else
      echo "TM: Optimization - DISABLED"
    fi
  fi

  # Start / Stop Backup
  if [ "$OP" = "auto" ]  || [ "$OP" = "-a" ]; then
    if [ $MOD ]; then
      eval "sudo tmutil enable"
      echo "TM: Automatic Backups - ENABLED"
    else
      eval "sudo tmutil disable"
      echo "TM: Automatic Backups - DISABLED"
    fi
  fi

  # Start / Stop Backup
  if [ "$OP" = "manual" ]  || [ "$OP" = "-m" ]; then
    if [ $MOD ]; then
      eval "sudo tmutil startbackup --block"
      echo "TM: Backup - FINISHED"
    else
      eval "sudo tmutil startbackup --auto"
      echo "TM: Backup - IN BACKGROUND"
    fi
  fi

  # Help
  if [ "$OP" = "help" ]  || [ "$OP" = "-h" ]; then
    echo "optimize  [-o]  -  Optimize Backups  (1: on, 0: off)"
    echo "auto      [-a]  -  Toggle Automatic Backups (1: on, 0: off)"
    echo "manual    [-m]  -  Start Manual Backup (1: blocking, 0: background)"
    echo "help      [-h]  -  Show this help paragraph"
  fi
}

alias tm="TimeMachine "


# ------------------ SPEEDTEST ------------------ #
speed() {
  if [ "$1" = "up" ]; then
    eval "speedtest-cli --no-download"
  elif [ "$1" = "up" ]; then
    eval "speedtest-cli --no-upload"
  else
    eval "speedtest-cli"
  fi
  echo $CMD
}



