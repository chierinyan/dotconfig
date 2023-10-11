source env_parallel.zsh

alias endsession='/usr/lib/qt6/bin/qdbus org.kde.Shutdown /Shutdown org.kde.Shutdown.logout'
alias reset-plasma='kquitapp6 plasmashell || killall plasmashell; kstart plasmashell >/dev/null'

function open {
    if [[ -e "$1" ]]; then
        xdg-open "$1" >/dev/null 2>&1
    else
        return 233
    fi
}

function trash {
    kioclient move "$@" 'trash:/'
}

if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    alias y='wl-copy --trim-newline'
    alias p='wl-paste -t text --no-newline'
else
    alias y='xclip -selection c -r'
    alias p='xclip -selection c -o'
fi
