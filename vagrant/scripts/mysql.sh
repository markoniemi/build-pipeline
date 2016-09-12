install_mysql() {
	if ! is_installed mysql-community-server; then
		sudo rpm -Uvh http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
		install mysql-community-server
		add_service mysqld
		start_service mysqld
		mysql_upgrade &> /dev/null
		sleep 20
		mysqladmin -u root password root
		# add users
		mysql -uroot -proot -e "CREATE USER 'root'@'%' IDENTIFIED BY 'root';"
		mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
		# copy /etc/my.conf from SVN
		#yes | mv -f /etc/my.cnf /etc/my.cnf.dist
		#yes | cp -f $config_dir/mysql/my.cnf /etc/.
		# TODO database backup
	fi
}

