set export
PackageManager := "sudo xbps install -y"

default: packages
	echo "Hello, $USER!"

packages:
	Package=$(cat ~/.stuff/xbps.txt)
	${PackageManager} ${Packages}

# vim:ft=make
