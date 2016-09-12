install_jenkins() {
	if ! is_installed jenkins; then
		echo installing jenkins
		yum install -q -y git
		wget -N -q http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo -P /etc/yum.repos.d/
		rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
		install jenkins
		#add_service jenkins
		#install_jenkins_plugins
		#nodejs requires bzip2
		install bzip2
		install_plugin thinBackup
		restore_jenkins_config 
		start_service jenkins
	fi
}

restore_jenkins_config() {
	echo restoring jenkins config
	# TODO http://www.holisticqa.com/2013/11/backing-up-your-jenkins-configuration/
	mkdir /var/lib/jenkins/backup
	unzip -qq $config_dir/jenkins/FULL-2016-09-05_20-37.zip -d /var/lib/jenkins/backup
	chown jenkins:jenkins -R /var/lib/jenkins/backup
}

install_jenkins_plugins() {
	echo installing jenkins plugins
	#Credentials Plugin, Sonar Plugin, CopyArtifact Plugin, Publish Over SSH Plugin, Deploy Plugin
	#Job Config History, Git Plugin, M2 Release Plugin, Promoted Builds Plugin.
	#http://updates.jenkins-ci.org/download/plugins
	install_plugin credentials
	install_plugin ssh-credentials
	install_plugin sonar
	install_plugin copyartifact
	install_plugin publish-over-ssh
	install_plugin deploy
	install_plugin promoted-builds
	install_plugin git-client
	install_plugin scm-api
	install_plugin mailer
	install_plugin git
	install_plugin thinBackup
}

install_plugin() {
	plugin_name=$1
	wget  -N -q https://updates.jenkins-ci.org/latest/$plugin_name.hpi -P /var/lib/jenkins/plugins
	mkdir /var/lib/jenkins/plugins/$plugin_name
	unzip -qq /var/lib/jenkins/plugins/$plugin_name.hpi -d /var/lib/jenkins/plugins/$plugin_name 
	chown jenkins:jenkins -R /var/lib/jenkins/plugins
}