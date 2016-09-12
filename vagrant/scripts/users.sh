add_user() {
	ret=false
	getent passwd $1 >/dev/null 2>&1 && ret=true
	
	if $ret; then
	    echo user $1 exists
	else
	    echo adding user $1
		groupadd $1
		useradd $1 -g $1 -G $1
		echo "$1"|passwd --stdin $1
		echo "$1        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/$1
		chmod 0440 /etc/sudoers.d/$1
	fi
}
