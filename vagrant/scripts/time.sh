set_timezone() {
	if ! date | grep -q EEST; then
		echo setting timezone
		rm -f /etc/localtime
		ln -s /usr/share/zoneinfo/Europe/Helsinki /etc/localtime
	fi
}
