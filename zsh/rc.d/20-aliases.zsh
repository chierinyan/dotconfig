export EDITOR=nvim
alias vi=$EDITOR
alias vim=$EDITOR

alias tree='tree --dirsfirst --filelimit=32 -F'
alias lsblk='lsblk -o NAME,FSTYPE,FSVER,FSSIZE,FSUSED,FSAVAIL,MOUNTPOINTS'
alias truecrypt='veracrypt -t'

alias rmeol="sed -i -z 's/\n*$//'"
alias oneeol="sed -i -z 's/\n*$/\n/'"
alias rmbom="sed -i -z $'s/^\uFEFF//'"

export UA='Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.3'
alias wget="wget -U '$UA' --content-disposition -e robots=off"
alias wclone='wget --mirror --convert-links --adjust-extension --page-requisites --no-parent'
alias curl="curl -A '$UA' --location"

alias convmv='convmv -r -t utf-8'

alias socks='ALL_PROXY=socks5://localhost:9000'

alias virsh='sudo virsh'
alias virt-viewer='sudo virt-viewer'

unalias scp 2>/dev/null
unalias rsync 2>/dev/null

function pg() { ps -ef | grep -i "$@" | grep -v grep; }

function termbl () {
    sudo zsh -c "echo $(( $(cat /sys/class/backlight/*/max_brightness) * $1 / 100 )) > /sys/class/backlight/*/brightness"
}

function shaname() {
    local extension="${1##*.}"
    local sha=`shasum -a 256 "$1"`
    local dir=$(dirname "$1")
    mv -f "$1" "$dir/${sha:0:16}.${extension:l}"
}

# > getpwd 0 0 0
# Ay00-7Ofr/mL0J-cpEB
function getpwd() {
    if [ "$#" -ne 2 ]; then return 1; fi
    >&2 echo "Account: $2@$1"
    >&2 read "key?Master Key: "
    local b64=`echo -n "$@ $key Ciallo~" | openssl dgst -binary -sha256 | openssl base64 -A`
    echo Ay00-${b64:0:4}/${b64:4:4}-${b64:8:4} | sed 's/+/-/g'
    unset key
}
: <<'JS'
const encoder = new TextEncoder();
const keystr = prompt('Host User MasterKey:') + ' Ciallo~';
const keybuf = encoder.encode(keystr);
crypto.subtle.digest('SHA-256', keybuf).then(sha256 => {
    const b64 = btoa(String.fromCharCode(...new Uint8Array(sha256)));
    console.log(`Ay00-${b64.slice(0,4)}/${b64.slice(4, 8)}-${b64.slice(8, 12)}`.replaceAll('+', '-'));
});
JS

function conn-qcow2() {
    sudo modprobe nbd nbds_max=1
    sudo qemu-nbd --aio=io_uring --discard=unmap -c /dev/nbd0 "$1"
}

function disconn-qcow2() {
    sudo qemu-nbd -d /dev/nbd0
    sudo modprobe -r nbd
}

function mrdp() {
    local rdp=xfreerdp3
    # if [ $XDG_SESSION_TYPE = "wayland" ]; then rdp=sdl-freerdp3; fi
    $rdp /tls:seclevel:0 /timeout:60000 /size:1600x900 /sound /v:$@[-1] /d: ${=@[1,-2]}
}

function pdf-merge() { pdftk "$@" cat output merged.pdf }
function pdf-rmpwd() { pdftk "$1" input_pw PROMPT output /tmp/unlocked && mv -f /tmp/unlocked "$1" }
function pdf-rotate() {
    declare -A directions=( [u]=north [r]=east [d]=south [l]=west )
    local direction=$directions[$1]
    pdftk "$2" cat 1-end${direction} output /tmp/rotated.pdf && mv -f /tmp/rotated.pdf "$2"
}
function pdf-compress() {
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH \
        -dPDFSETTINGS=/ebook -sOutputFile="$2" "$1"
}

function zipa() {
    local extra_args="$@[1,-2]"
    local src="$@[-1]"
    local archive=`basename "$src"`.zip
    noglob zip \
        $extra_args \
        --test \
        -9 `#compress level 9 (0-9)` \
        -X `#ignore extra file attrs` \
        -x */._* \
        -x */.DS_Store \
        -x */.DocumentRevisions-V100 \
        -x */.FBC* \
        -x */.Spotlight-V100 \
        -x */.TemporaryItems \
        -x */.VolumeIcon.icns \
        -x */.background \
        -x */.com.apple.timemachine.* \
        -x */.fseventsd \
        -x */.localized \
        -x */Icon \
        -x */\$RECYCLE.BIN* \
        -x */*~ \
        -x */.directory \
        -x */.fuse_hidden* \
        -x */.Trash* \
        -x */.nfs* \
        -x */'System Volume Information' \
        -r "$archive" "$src"
}

function rara() {
    local extra_args="$@[1,-2]"
    local src="$@[-1]"
    local archive=`basename "$src"`.rar
    local RAR="
        -cfg-    `# ignore config file`
        -ep1     `# exclude base directory`
        -htb     `# use BLAKE2`
        -k       `# lock modification`
        -m5      `# compression level 5 (0-5)`
        -md256m  `# dictionary size 256M`
        -oi2     `# check identical files`
        -qo      `# add quick open information`
        -rr5p    `# recovery record 5%`
        -s       `# solid archive`
        -t       `# test`
    "
    RAR="${RAR//$'\n'/}" noglob rar a \
        ${=extra_args} \
        -x*/._* \
        -x*/.DS_Store \
        -x*/.DocumentRevisions-V100 \
        -x*/.FBC* \
        -x*/.Spotlight-V100 \
        -x*/.TemporaryItems \
        -x*/.VolumeIcon.icns \
        -x*/.background \
        -x*/.com.apple.timemachine.* \
        -x*/.fseventsd \
        -x*/.localized \
        -x*/Icon \
        -x*/\$RECYCLE.BIN* \
        -x*/*~ \
        -x*/.directory \
        -x*/.fuse_hidden* \
        -x*/.Trash* \
        -x*/.nfs* \
        -x*/'System Volume Information' \
        -r "$archive" "$src"
}

function spcue() {
    cue="$1"
    aud="$2"
    disc="$3"
    if [ -z "$cue" ]; then
        cue=`find . -maxdepth 1 -name '*.cue' -print -quit`
    fi
    if [ -z "$aud" ]; then
        aud=`find . -maxdepth 1 \( -name '*.flac' -o -name '*.wav' \) -print -quit`
    fi

    rmbom "$cue"
    shnsplit -f "$cue" -o flac -t "${3}%n-%t" "$aud"
    rm 00-pregap.flac 2>/dev/null
    if [ $? -eq 0 ]; then
        rm "$aud"
    else
        return 1
    fi
    cuetag.sh "$cue" *.flac
}

function to_alac() {
    if [ $# -eq 1 ]; then
        ffmpeg -i "$1" -c:a alac -c:v copy "${1%.*}.m4a"
    elif [ $# -eq 2 ]; then
        ffmpeg -i "$1" -i "$2" -c:a alac -c:v:0 png -disposition:v:0 attached_pic "${1%.*}.m4a"
    else
        >&2 echo "Usage: to_alac <input> [cover]"
        return 1
    fi
}

function stripdir() {
    find . -mindepth 2 -maxdepth 2 -type d -exec bash -c 'mv -i "$1"/* "$1"/.. && rmdir "$1"' stripdir {} \;
}

function zfill() {
    ls | while read -r f; do mv -i "$f" `printf "%04d" ${f%.*}`.${f##*.}; done
}

alias hcheck='mkdir -p completed && find . -mindepth 2 -maxdepth 2 -name "galleryinfo.txt" -exec dirname {} \; | parallel --jobs 1 mv {} completed'

function garchive() {
    pbd=`basename "$PWD"`
    mkdir -p "$pbd"
    find . -mindepth 1 -maxdepth 1 -type d ! -name "$pbd" | parallel --jobs 50% --quote zip -0 --junk-sfx --junk-paths --test -r "$pbd"/{}.cbz {}
}

function lsgid() {
    perl -e 'my @gids=(); foreach my $g (split("\n", `find .`)) {if ($g=~/\[(\d+)\](.cbz)?$/) {push @gids, $1}} print join(",", @gids);'
}
