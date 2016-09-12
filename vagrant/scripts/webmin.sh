install_webmin() {
	if ! is_installed webmin; then
		echo installing webmin
		yes | cp -f /vagrant/config/webmin/webmin.repo /etc/yum.repos.d/.
		wget -N -q http://www.webmin.com/jcameron-key.asc -P $download_dir/vagrant
		rpm --import $download_dir/vagrant/jcameron-key.asc
		install webmin
		# install Authentic theme
		#wget -N -q https://raw.githubusercontent.com/qooob/authentic-theme/master/.build/authentic-theme-latest.wbt.gz
		sed -i.bak "s/\(theme=\).*\$/\1authentic-theme/" /etc/webmin/config
		sed -i.bak "s/\(preroot=\).*\$/\1authentic-theme/" /etc/webmin/miniserv.conf
		add_webmin_users
		service webmin restart
	fi
}
add_webmin_users() {
		# add users to webmin
		echo "niemimac:x:0" >> /etc/webmin/miniserv.users
		echo "niemimac:acl" >> /etc/webmin/webmin.acl
}