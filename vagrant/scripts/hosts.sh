hosts() {
	# add to hosts file
	# TODO use vagrant plugin install vagrant-hostsupdater
	if ! grep -q e6520 /etc/hosts; then
		cat $config_dir/hosts >> /etc/hosts
	fi
}