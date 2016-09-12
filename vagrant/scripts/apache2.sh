install_apache2() {
	if ! is_installed httpd-2; then
		echo installing apache2
		# install prerequisites
		install mod_ssl 
		install openssl
		yum install -q -y httpd
		yes | mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.dist
		yes | cp -rf $config_dir/apache2/conf /etc/httpd
		add_service httpd
	else
		echo apache2 already installed
	fi	
}

create_certificate() {
	# Generate private key
	openssl genrsa -out /etc/httpd/conf/server.key 2048
	# Generate CSR
	# TODO get server name from variable
	openssl req -new -key /etc/httpd/conf/server.key -out /etc/httpd/conf/server.csr -subj '/O=Tieto Finland/C=FI/CN=enduser.vagrant.tieto.com/subjectAltName=DNS.1=enduser.vagrant.tieto.com,DNS.2=servant.vagrant.tieto.com,DNS.3=admin.vagrant.tieto.com'
	# Generate Self Signed Key
	openssl x509 -req -days 3650 -in /etc/httpd/conf/server.csr -signkey /etc/httpd/conf/server.key -out /etc/httpd/conf/server.crt
	# restart apache for the settings to take effect
	service httpd restart
}

# copy certificate to SVN
backup_certificate() {
	mkdir -p $download_dir/apache2/conf/
	yes | cp /etc/httpd/conf/server.csr $download_dir/apache2/conf/. 
	yes | cp /etc/httpd/conf/server.key $download_dir/apache2/conf/.
	yes | cp /etc/httpd/conf/server.crt $download_dir/apache2/conf/.
	chmod a+r $download_dir/apache2/conf/*.*
}
