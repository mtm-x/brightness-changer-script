#!/bin/bash

#check for root permission
check_root() {

if [[ $EUID -ne 0 ]]; then
    echo " run as root"
    exit 1

fi
}
# reverting to old brightness
revert_old()
{
echo " Do you want to revert to your previous brightness ? (y/n)"
read revert
if [[  $revert = 'y' ]]; then
    echo $brightness > brightness

else
     echo " skipping ....."

fi
}
main()
{
#changing the directory to brightness directory
echo " Changing directory..."
sleep 2
cd /sys/class/backlight/amdgpu_bl0
brightness=$(cat actual_brightness)
echo " Printing your current birghtness..."
sleep 1
echo " your current brightness is $brightness"
sleep 2
echo " Printing your maximum supported brightness.."
sleep 1
maxbright=`cat max_brightness`
echo " your maximum supported brightness is $maxbright"
sleep 2
echo -n " type brightness between 0 to $maxbright :"
sleep 1
read bright
echo $bright > brightness
sleep 1

revert_old

echo " do you want to repeat again ? (n/y)"
read repeat

if [[ $repeat == 'n' ]]; then
    echo " exiting ..."
    exit
else
    main
fi
}
#main fucntion
clear

check_root
main
