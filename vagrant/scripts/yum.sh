is_installed() {
	if rpm -qa | grep -q $1; then
		return 0
	else
		return 1
	fi
}

# install <package_name>
install() {
	if ! is_installed $1; then
		echo installing $1
		yum install -q -y $1
	else
		echo $1 already installed
	fi
}

# uninstall <package_name>
uninstall() {
	if is_installed $1; then
		echo uninstalling $1
		yum erase -q -y $1
	else
		echo $1 already uninstalled
	fi
}

clean_yum_cache() {
	yum clean all
	install deltarpm
}