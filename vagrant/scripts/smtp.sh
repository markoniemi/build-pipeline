install_devnullsmtp() {
	if ! [ -f /var/lib/DevNullSMTP ]; then
		mkdir -p /var/lib/DevNullSMTP/emails
		wget -N -q http://www.aboutmyip.com/AboutMyXApp/DevNullSmtp.jar -P /var/lib/DevNullSMTP
		printf "#sudo -i before starting this command\nnohup java -jar /var/lib/DevNullSMTP/DevNullSmtp.jar -console -s /var/lib/DevNullSMTP/emails -p 25 &>nohup.out &\n" >> /var/lib/DevNullSMTP/DevNullSmtp.sh
		chmod a+x /var/lib/DevNullSMTP/DevNullSmtp.sh
		chmod a+w /var/lib/DevNullSMTP/emails
	fi
}

start_devnullsmtp() {
	/var/lib/DevNullSMTP/DevNullSmtp.sh
}