install_sonar() {
	if ! is_installed sonar; then
		sudo wget -N -q http://downloads.sourceforge.net/project/sonar-pkg/rpm/sonar.repo -P /etc/yum.repos.d
		install sonar
		create_sonar_database
		set_sonar_database
		#add_service sonar
		service sonar start
	fi
}

create_sonar_database() {
		mysql -uroot -proot < $config_dir/sonar/createSonarUser.sql
}

set_sonar_database() {
	sed -i s/#sonar.jdbc.url=jdbc:mysql:/sonar.jdbc.url=jdbc:mysql:/g /opt/sonar/conf/sonar.properties
	sed -i s/#sonar.jdbc.username=/sonar.jdbc.username=root/g /opt/sonar/conf/sonar.properties
	sed -i s/#sonar.jdbc.password=/sonar.jdbc.password=root/g /opt/sonar/conf/sonar.properties
}
