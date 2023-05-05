#!/usr/bin/sh

source ./config.sh

if [ ! -f $DISK_NAME ]
then
	echo "Creating virtual disk $DISK_NAME"
	qemu-img create -f qcow2 $DISK_NAME 40G
else
	echo "File $DISK_NAME already exists! Will not destroy!"
	echo "Delete it to recreate VM from scratch."
fi
echo ""
echo ""

reply="yes"
while [ "$reply" == "yes" ] 
do
	if [ -f $ISO_NAME ]
	then
		echo "Starting VM, if nothing happened check if you have a new terminal window?"
		qemu-system-x86_64 -m 2G -usb -hda $DISK_NAME -cdrom $ISO_NAME
		reset
		break
	else
		echo "Cannot find the OS iso file $ISO_NAME!"
		echo "Do you want to try to download it?"
		echo -n "Type yes to continue: "
		read reply
		if [ "$reply" == "yes" ] 
		then
			source ./scripts/image_manager.sh
			download_image ./config.sh
			if [[ $? -ne 0 ]]
			then
				echo ""
				echo "Failed to download image!"
				echo "The filename might have changed recently."
				echo "Want to try to find the newest version?"
				echo -n "Type yes to continue: "
				read reply
				if [ "$reply" == "yes" ] 
				then
					update_config_file ./config.sh
					echo ""
					continue
				else
					echo ""
					echo "Update the config.sh file if you want to use a different file name!"
					echo "Then try running the setup again!"
				fi
			else
				echo ""
				echo "Successfully downloaded!"
			fi
		fi
	fi
done

