disable_firewall() {
	disable_firewalld
}
disable_firewalld() {
	if is_installed firewalld; then
		uninstall firewalld
	fi
}
disable_iptables() {
	if service iptables status &> /dev/null; then
		echo disabling firewall
		service iptables stop &> /dev/null
		chkconfig iptables off &> /dev/null
	fi
}

enable_httpd_network_connect() {
	setsebool -P httpd_can_network_connect 1
}

disable_selinux() {
	sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config
	setenforce Permissive
}