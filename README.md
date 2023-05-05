# VM 449: Using Virtual Machines for CS 449

## Overview
This course assumes that you have access to an [x86-64](https://en.wikipedia.org/wiki/X86-64) machine running [Linux](https://en.wikipedia.org/wiki/Linux) as the operating system. However, in case you do not have such a machine handy, students enrolled in this course are automatically granted access to a special department server called **`thoth.cs.pitt.edu`**. This server lives on the sixth floor of Sennott Square and runs Ubuntu [Ubuntu Linux 22.04.1 LTS](https://wiki.ubuntu.com/JammyJellyfish) (as of 2023). Other Linux and MacOS systems are very similar, and Windows machines also use the same underlying processor and memory organization. However, for this course, all of your submissions must compile and run on this departmental server to receive credit.

You can access this serve using Secure Shell (`ssh`) by simply opening the terminal (PowerShell on Windows) and runing the following command:
```sh
ssh USERNAME@thoth.cs.pitt.edu
# You can also access the server via its alias
ssh USERNAME@cs449.cs.pitt.edu
```

While you are encouraged to develop all of your projects for this course on `thoth.cs.pitt.edu`, there are times when doing so may prove difficult. For instance, the server may be down due to maintenance or high demand (usually around assignment deadlines); Or you may simply be experiencing internet connectivity issues. Regardless of the reason, this document outlines instructions to set up a **virtual machine** that can approximate the computing experience of an instructional Linux box at school that you can run on your desktop or laptop wherever you are.

## What is a VM?
[Virtual machines](https://en.wikipedia.org/wiki/Virtual_machine) are emulated computer instances (that can run a different operating system) running inside a special program you install on your desktop or laptop computer. For example, you could run a Linux or a Windows 10 virtual machine on your Macintosh laptop, or a Linux virtual machine on your Windows machine.

Many programming projects in this course require the use of a Linux host to complete. A virtual machine affords you the option of working on these projects on your own device, anywhere in the world.

> **NOTE.** Although VMs can approximate `thoth.cs.pitt.edu` very well, you must still ensure that your code compiles and runs on the server before submission. You will not receive credit if your code does not work on `thoth.cs.pitt.edu`.

## Installing the Virtual Machine
Virtual machines run inside some other program, which runs on the host computer (your laptop or desktop). There are many of these *'host programs'* (such as [Virtual Box](https://www.virtualbox.org/), [VM Ware](https://www.vmware.com/), or [Hyper-V](https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/about/) on Windows). Here, we will use [QEMU](https://www.qemu.org/), which is a free and open-source software, since it is compatible with most systems regardless of the underlying hardware and the operating system.

> QEMU allows ARM-based (e.g., M1/M2 Macs) systems to emulate an x86-64 environment. However, due to the limitation of emulating hardware at the software-level, performance may be slower on these systems.

### For Everyone
1. Move into the directory where you want to store the VM and clone this directory. You can clone this directory by running the following command:
	```sh
	git clone https://github.com/shinwookim/VM449
	```
2. Download the '**server install image**' for Ubuntu 22.04.2 LTS (Jammy Jellyfish) at https://mirror.cs.pitt.edu/ubuntu/releases/22.04/ and store it inside the cloned repository (created in step 1). **The file name should be exactly `ubuntu-22.04.2-live-server-amd64.iso`**.
3. Install QEMU by following the steps for your specific operating system.

### For Windows
1. Install QEMU by using the installed which can be found at https://www.qemu.org/download/#windows. Alternatively, you can use a package manager such as [Chocolatey](https://chocolatey.org/install).
2. After installing QEMU, add the QEMU path into the **Environment Variables**
	- Open **File Explorer**, go to the QEMU installation location, and then copy the path (e.g., `C:\Program Files\qemu`).
	- Right-click **This PC** / **Computer**, choose **Properties**, and then click **Advanced system settings**.
	- Under the **Advanced** tab, click **Environment Variables**.
	- In the **User variables** box, double-click the **Path** variable, click **New**, and then paste the QEMU path.
	- Click the **OK** button to save changes, and then click the **OK** button again to save and exit the **Environment Variables**


### On MacOS
4. Install QEMU through [Homebrew](https://brew.sh/).
	1. If you do not have Homebrew already, you can install it by opening the terminal and running:
		```sh
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		```
	2. Go through the installation steps.
	3. Once Homebrew is installed, you can install QEMU by running:
		```sh
		brew install qemu
		```

### On Linux
Using your distro's package manager, install the QEMU package. If you are unsure of the package name, please check [here](https://www.qemu.org/download/#linux).


## Setting Up the Virtual Machine
To ensure you've correctly installed QEMU, open your command line/terminal and run:
```sh
qemu-system-x86_64 --version
```

You should be able to verify that QEMU is installed correctly if the terminal shows something like:
```
QEMU emulator version 7.2.94 (v8.0.0-rc4-12015-g9de3238476-dirty)
Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project developers
```
Once you've verified QEMU is installed, we can now setup the VM. For your convenience, we've provided several scripts to ease the installation process.
1. Examine and run the `setup.sh` (or `setup-win.bat`) from the terminal.
   - The first command `qemu-img create -f qcow2 VM449.qcow2 40G` creates a new virtual hard drive with a maximum capacity of 40GiB.
   - The second command `qemu-system-x86_64.exe -m 2G -usb -hda VM449.qcow2 -cdrom ubuntu-22.04.2-live-server-amd64.iso` will boot QEMU using the virtual hard disk created above with the Ubuntu image loaded into the virtual CDROM.
2. Running the script above should open QEMU. Follow the steps within the VM to install Ubuntu onto your virtual hard drive.
3. Once installation has finished, you can power down your VM by running `sudo poweroff`.
4. Now, you can open QEMU by running the `run.sh` (or `run-win.bat`) script.
5. Verify that the OS has been installed correctly and back up the `VM449.qcow2` to a secure location. If you experience any issues using the VM, you can restore back to this point by swapping this file with the back up.
> **NOTE**. The setup scripts will create a new virtual hard drive with the same name every time it is run. Hence, if you run `setup.sh` after you've installed the OS, it will essentially *format* the disk and you will need to install the OS again.
