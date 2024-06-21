# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PS1='[\u@\h \W[$?]]\$ '

export PATH="$HOME/usr/zeek/bin:$HOME/Android/Sdk/emulator:$HOME/Android/Sdk/platform-tools:$HOME/usr/bin:$PATH"

export LIBVIRT_DEFAULT_URI=qemu:///system

source "$HOME/lib/asdf/asdf.sh"
source "$HOME/lib/asdf/completions/asdf.bash"

## Useful aliases

# Replace some more things with better alternatives
alias cat='bat --style header --style snip --style changes --style header'

# Common use
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias grep='ugrep --color=auto'
alias fgrep='ugrep -F --color=auto'
alias egrep='ugrep -E --color=auto'
alias hw='hwinfo --short'                          # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl"     # Sort installed packages according to size in MB (expac must be installed)
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages
alias ip='ip -color'

# Get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Help people new to Arch
alias tb='nc termbin.com 9999'
alias pacdiff='sudo -H DIFFPROG=meld pacdiff'

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

alias ls="ls --color=always --group-directories-first"

alias rm="rm --verbose --interactive=once"
alias cd="cd -P"

alias vi="nvim -p"
alias vd="nvim -dO"

printf "\e[5 q"

ub() {
    unbuffer "$@" | less -R
}

rawurlencode() {
    local string="$*"
    local strlen=${#string}
    local encoded=""
    local pos c o
    for ((pos = 0; pos < strlen; pos++)); do
        c=${string:$pos:1}
        case "$c" in
            [-_.~a-zA-Z0-9])
                o="${c}"
                ;;
            *)
                printf -v o '%%%02x' "'$c"
                ;;
        esac
        encoded+="${o}"
    done
    echo "${encoded}"
}

help() {
    local u
    u="$(rawurlencode "$@")"
    ub curl "https://cheat.sh/$u"
}
fastfetch -l garuda
