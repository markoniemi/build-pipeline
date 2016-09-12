install_tomcat() {
	install_tomcat7
}

install_tomcat6() {
	if ! is_installed tomcat6; then
		install tomcat6
		add_service tomcat6
		# copy config files from SVN
		yes | mv /etc/tomcat6/server.xml /etc/tomcat6/server.xml.dist
		yes | cp -rf $config_dir/tomcat/server.xml /etc/tomcat6/server.xml
		# add to tomcat-users.xml
		sed -i.bak -e 's/<\/tomcat-users>/<user username="tomcat" password="tomcat" roles="manager-gui,manager"\/>\n<\/tomcat-users>/g' /usr/share/tomcat6/conf/tomcat-users.xml
	fi
}

install_tomcat7() {
	if ! is_installed tomcat; then
		#rpm -Uvh http://pkgs.org/centos-6/epel-i386/tomcat-7.0.33-4.el6.noarch.rpm
		# add EPEL repo
		#install yum-utils
		#yum-config-manager --enable epel-testing
		#install epel-release
		install tomcat
		add_service tomcat
		# copy config files from SVN
		yes | mv /etc/tomcat/server.xml /etc/tomcat/server.xml.dist
		yes | cp -rf $config_dir/tomcat/server.xml /etc/tomcat/server.xml
		# add to tomcat-users.xml
		sed -i.bak -e 's/<\/tomcat-users>/<user username="tomcat" password="tomcat" roles="manager-gui,manager"\/>\n<\/tomcat-users>/g' /usr/share/tomcat/conf/tomcat-users.xml
	fi
}

wait_for_tomcat_start() {
	current_date=$(date +%Y-%m-%d)
	until cat /var/log/tomcat/catalina.$current_date.log | grep -q "Server startup in"; do 
		sleep 5;
		echo waiting for tomcat to start...
	done
}
