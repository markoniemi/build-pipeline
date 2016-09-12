# set_property <property> <value> <file>
# http://stackoverflow.com/questions/9368262/using-sed-to-update-a-property-in-a-java-properties-file
set_property() {
	#sed -i.bak 's/\($1=\).*\$/\1${$2}/' $3
	#sed -i.bak "s/\($1=\).*\$/\1${2}/" $3
}