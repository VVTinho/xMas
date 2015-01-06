!/bin/bash

# Undvik att köra scriptet på samma gång. Det är en av punkterna i dokumentationen
# Prova med kommando trap eller flock
# trap "rmdir .lock; exit" INT TERM EXIT

# Checka och se om det finns någon usb i datorn
# IFS=$'\n'
# for mtabline in `cat /etc/mtab`; do 
#  device=`echo $mtabline | cut -f 1 -d ' '`
#  udevline=`udevadm info -q path -n $device 2>&1 |grep usb` 
#  if [ $? == 0 ] ; then
#    devpath=`echo $mtabline | cut -f 2 -d ' '`
#    echo "devpath: $devpath"
#    Det finns en USB sticka i datorn 
#  fi
#  done

# Start the script with command clear. Nice and Clean :)
clear

# Some info about the script and author
echo "Backup Script"
echo ""
echo "V.1"
echo ""
echo "Created by vladimir.trigueiros@gmail.com & Roberto aguilar robertoleon11@hotmail.com"
echo "LX14"
echo ""
read -p "Please Press ENTER To Continue..." waitForEnter

# Alert the user and wait 3 clicks
echo "BACKUP Initiating..."
echo ""
sleep 3

# Create a directory 
mkdir backup

# Write permissons to directory 
chmod u+x backup

# Ask the user if he/she wanna do a Full backup or exclude some files or folders
echo "Do you wanna do a Full backup or exclude some files or folders [F|E]"
read backupOption

# Check if the user typed F = Full backup or E = exclude
if [ ${backupOption} == "F" ]
then
        mv /home/roal11/FILES.TXT /home/roal11/lab/backup
        mv /home/roal11/INFO.TXT /home/roal11/lab/backup

        now=$(date +%Y%m%d-%H%M%S)
        a="lx14backup"
        b="$(hostname)"

        tar cvf ${a}.${b}.${now}.tar /var

        # Move the new created backup file to directory
        mv /home/roal11/lab/${a}.${b}.${now}.tar /home/roal11/lab/backup

        # Finish backup, alert the user
        echo ""
        echo "BACKUP Complete!"
        echo ""

        # Then Set backup.tz File Privilidges So That The Specified USER Can Read, Write & Execute
        echo "Setting Backup File Privilidges..."
        echo ""

        # Set Read, Write & Execute Privilidges For The Owner (root)
        chmod u+rwx ../../lx14bachost_yymmddhhmm_T.tz

        # Set Read, Write & Execute Privilidges For The Specified Group ($backupUser)
        chmod g+rwx ../../lx14bachost_yymmddhhmm_T.tz

        # Alert The User, Wait 3 Clicks & Terminate The Script
        echo "TERMINATING..."
        echo ""

        sleep 3
else

        echo "Enter any directories you want to exclude from the backup.tgz"
        echo "Syntax: --exclude=/write path to directory that you wanna exclude"
        read strExclusions

        sleep 2

        mv /home/roal11/FILES.TXT /home/roal11/lab/backup
        mv /home/roal11/INFO.TXT /home/roal11/lab/backup

        now=$(date +%Y%m%d-%H%M%S)
        a="lx14backup"
        b="$(hostname)"

        tar $strExclusions -cvf ${a}.${b}.${now}.tar /var

        # Move the new created backup file to directory
        mv /home/roal11/lab/${a}.${b}.${now}.tar /home/roal11/lab/backup

        # Finish backup, alert the user
        echo ""
        echo "BACKUP Complete!"
        echo ""

        # Alert The User, Wait 3 Clicks & Terminate The Script
        echo "TERMINATING..."
        echo ""

        sleep 3
fi
                                                                                                                                                   113,1         Bot
