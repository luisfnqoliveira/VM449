qemu-img create -f qcow2 VM449.qcow2 40G
qemu-system-x86_64.exe -m 2G -usb -hda VM449.qcow2 -cdrom ubuntu-22.04.2-live-server-amd64.iso

