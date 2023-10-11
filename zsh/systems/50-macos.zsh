eval "$(/opt/homebrew/bin/brew shellenv)"

alias python='python3'
alias pip='pip3'
alias nproc='sysctl -n hw.logicalcpu'

alias y='pbcopy'
alias p='pbpaste'

function code() {
    if [[ $# = 0 ]]
    then
        open -a 'Visual Studio Code'
    else
        F=`readlink -f $1`
        open -a 'Visual Studio Code' --args "$F"
    fi
}

function tower() {
    if [[ $# = 0 ]]
    then
        open -a 'Tower'
    else
        F=`readlink -f $1`
        open -a 'Tower' --args "$F"
    fi
}

function prl() {
	open -a 'Parallels Desktop'
	sleep 2
	prlctl start ${1:-'win11'}
}
