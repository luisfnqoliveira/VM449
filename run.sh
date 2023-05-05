source config.sh

if [ -f $DISK_NAME]
then
    qemu-system-x86_64 -m 2G -usb -hda $DISK_NAME
else
    echo "$DISK_NAME Not found!"
    echo "Run the setup first!"
fi

