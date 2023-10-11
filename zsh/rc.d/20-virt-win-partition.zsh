function assemble-win-vdisk() {
    local img_dir="$HOME/ws/win-virt"
    local win_partition='/dev/nvme0n1p3'

    local table=''
    local start_sector=0
    local loop size

    loop=$(losetup -f)
    sudo losetup $loop $img_dir/win-efi-0.img
    size=$(sudo blockdev --getsz $loop)
    table+="$start_sector $size linear $loop 0\n"
    start_sector=$((start_sector+size))

    size=$(sudo blockdev --getsz $win_partition)
    table+="$start_sector $size linear $win_partition 0\n"
    start_sector=$((start_sector+size))

    loop=$(losetup -f)
    sudo losetup $loop $img_dir/win-efi-1.img
    size=$(sudo blockdev --getsz $loop)
    table+="$start_sector $size linear $loop 0"

    echo "$table" | sudo dmsetup create win-vdisk
}

function disassemble-win-vdisk() {
    sudo dmsetup remove win-vdisk
    losetup | grep win-efi | awk '{print $1}' | xargs sudo losetup -d
}


: <<'INIT'

1. Create image files for EFI partition

    ``` sh
    truncate -s 100m win-efi-0.img
    truncate -s 1m   win-efi-1.img
    ```


2. `assemble-win-vdisk`


3. Create partition table

    ``` sh
    sudo parted /dev/mapper/win-vdisk
    (parted) unit s
    (parted) mktable gpt
    (parted) mkpart primary fat32 2048 204799
    (parted) mkpart primary ntfs 204800 -2049
    (parted) set 1 boot on
    (parted) set 1 esp on
    (parted) name 1 EFI
    (parted) quit
    ```


4. Boot Windows ISO


5. Format the EFI partition


6. Write boot files

    `Shift-F10`

    ```cmd
    diskpart
    DISKPART> select volume *  # Select EFI volume
    DISKPART> assign letter=B  # Assign B: to EFI volume
    DISKPART> exit
    bcdboot C:\Windows /s B: /f UEFI
    ```


## References

https://simgunz.org/posts/2021-12-12-boot-windows-partition-from-linux-kvm/
https://bbs.archlinux.org/viewtopic.php?id=294005
INIT
