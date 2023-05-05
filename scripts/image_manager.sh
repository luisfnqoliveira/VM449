

find_dist_name() {
	# Downloads the webpage html and tries to find the name of the current iso file
	wget -qnv -O- http://mirror.cs.pitt.edu/ubuntu/releases/22.04/ | grep href | grep "server-amd64.iso\"" | head -n1 | awk -F'"' '{print $2}'
}

download_image() {
	CONFIG_FILE=../config.sh
	if [ -f $1 ]
	then
		CONFIG_FILE=$1
	fi
	echo "Trying to download http://mirror.cs.pitt.edu/ubuntu/releases/22.04/$ISO_NAME"
	wget "http://mirror.cs.pitt.edu/ubuntu/releases/22.04/$ISO_NAME"
	return $?
}

dump_configuration() {
	echo "# Change this to use a different file"
	echo "ISO_NAME=$1"
	echo "# Change this to use a different disk name"
	echo "DISK_NAME=$2"
}

update_config_file() {

	CONFIG_FILE=../config.sh
	if [ -f $1 ]
	then
		CONFIG_FILE=$1
	fi
	CONFIG_FILE=`realpath $CONFIG_FILE`

	source "$CONFIG_FILE"

	ISO_NAME=`find_dist_name`

	echo ""
	echo "#############################"
	echo "WARNING: You are about to change the configuration in \"$CONFIG_FILE\"!"
	echo "#############################"
	echo ""
	echo "Here is what it will look like:"
	echo ""
	dump_configuration $ISO_NAME $DISK_NAME
	echo ""
	echo -n "Are you sure you want to do that? (Type 'yes' to confirm): "
	read reply
	if [ "$reply" == "yes" ] 
	then
		dump_configuration $ISO_NAME $DISK_NAME > "$CONFIG_FILE"
	fi
}


