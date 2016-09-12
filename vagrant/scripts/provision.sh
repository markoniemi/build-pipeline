#!/usr/bin/env bash
download_dir=/vagrant
script_dir=/vagrant/scripts
#config_dir=/home/niemimac/config
#config_dir=/vagrant/config/vagrant-env
config_dir=/vagrant/config

source $script_dir/users.sh
source $script_dir/firewall.sh
source $script_dir/yum.sh
source $script_dir/service.sh
source $script_dir/time.sh
source $script_dir/hosts.sh
source $script_dir/apache2.sh
source $script_dir/shibboleth.sh
source $script_dir/mysql.sh
source $script_dir/tomcat.sh
source $script_dir/smtp.sh
source $script_dir/webmin.sh
source $script_dir/jenkins.sh
source $script_dir/sonar.sh
source $script_dir/progress.sh

provision() {
	hosts
	clean_yum_cache
	set_timezone
	add_user niemimac
	disable_firewall
	# disable SELinux
	disable_selinux
	# remove mail server
	uninstall postfix
	uninstall chrony
	install wget
	install bash-completion
	install net-tools
	install nano
	install zip
	install unzip
	install ntp
	add_service ntpd
	install_mysql
	#install_tomcat
	install_webmin
	install java-1.8.0-openjdk
	install_jenkins
	install_sonar
	
	#start_service tomcat6
	#start_service tomcat
	#wait_for_tomcat_start
}