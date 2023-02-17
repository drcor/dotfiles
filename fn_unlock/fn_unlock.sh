#!/bin/bash
# Fix the Asus dysfunctional FN key on Linux Mint. 2022-10-20;
H=fnlock_default;
G=asus_wmi;
L=/etc/modprobe.d/alsa-base.conf;
E="\n** $G $H";
F=" **\n"

# Get distribution name
if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
elif type lsb_release >/dev/null 2>&1; then
    OS=$(lsb_release -si)
elif [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    OS=$DISTRIB_ID
fi

echo -e "$OS"

if [ -f /sys/module/$G/parameters/$H ]; then
    I="INSTALLED"
    grep -q "$H=N" $L
    if [ $? -eq 0 ]; then
        echo -e "$E $I ALREADY$F"
        exit 0
    fi
    O="options $G ${H}=N"
    echo -e "#Toggle $H at boot (Y/N)\n$O\n" | sudo tee -a $L
    echo -e "\nPlease WAIT ...\n"

    case $OS in
        "openSUSE Tumbleweed")
            sudo mkinitrd -k all
            ;;

        "ManjaroLinux" | "Manjaro Linux" | "Arch")
            sudo mkinitcpio -P
            ;;

        *)
            echo "Operating system not suported!!"
            exit 1
            ;;
    esac

    echo -e "$E $I NOW$F"
    exit 0
fi

echo -e "$E NOT FOUND$F"
exit 1

