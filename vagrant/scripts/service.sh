add_service() {
	echo add service $1
	systemctl enable $1
}

start_service() {
	if systemctl is-active $1; then
		echo service $1 already running
	else
		echo starting service $1
		systemctl start $1
		# TODO check if starts properly
	fi
}

start_service_old() {
	if service $1 status | grep -q 'is running'; then
		echo service $1 already running
	else
		echo starting service $1
		service $1 start
		# TODO check if starts properly
	fi
}

