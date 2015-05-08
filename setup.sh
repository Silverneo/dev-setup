#!/bin/bash
# Script.sh
# Simple and nice script that
# help make your machine ready
# for fun

# declare variables here
SCRIPT_NAME="setup.sh"
SCRIPT_VERSION="0.1"
SCRIPT_FLAG=$1

# What distro am I?
distro() {
	head -n1 /etc/issue | awk '{print $1}'
}

# Install specified package
#
# $1 = Package name to install
# $2 = Additional repo to use (Ubuntu/CentOS/RedHat)
#
install_pkg() {
	echo -e "\033[1;33m Installing ${1}... \033[0m"
	case "$(distro)" in
		Manjaro|Arch)
			if ! which yaourt &>/dev/null; then
				sudo pacman -S --noconfirm yaourt &>/dev/null
			fi
			if ! which "${1}" &>/dev/null; then
				yaourt -Syy &>/dev/null
				yaourt -S --noconfirm "${1}" &>/dev/null
			fi
			;;
		Ubuntu)
			if [ -n "${2}" ]; then
				sudo add-apt-repository "${2}"
			fi
			if ! which "${1}" &>/dev/null; then
				sudo apt-get update &>/dev/null
				sudo apt-get install -y "${1}" &>/dev/null
			fi
			;;
		RedHat|"\S")
			if [ -n "${2}" ]; then
				sudo yum-config-manager --add-repo "${2}"
			fi
			if ! which "${1}" &>/dev/null; then
				sudo yum update &>/dev/null
				sudo yum install -y "${1}" &>/dev/null
			fi
			;;
	esac
	echo -e "\033[1;33m ${1} installed... \033[0m"
}

# Uninstall specified package
#
# $1 = Package name to uninstall
#
uninstall_pkg() {
	echo -e "\033[1;33m Removing ${1}... \033[0m"
	case "$(distro)" in
		Manjaro|Arch)
			if which "${1}" &>/dev/null; then
				yaourt -Rns --noconfirm "${1}" &>/dev/null
			fi
			;;
		Ubuntu)
			if which "${1}" &>/dev/null; then
				sudo apt-get remove --purge -y "${1}" &>/dev/null
			fi
			;;
		RedHat|CentOS)
			if which "${1}" &>/dev/null; then
				sudo yum remove --purge -y "${1}" &>/dev/null
			fi
			;;
	esac
	echo -e "\033[1;33m ${1} removed \033[0m"
}

# fix common error
#
# $1 = Setup vs Uninstall
#
fix_common() {
	if [ -z "${1}" ]; then
		echo "Fixing grunt watch error..."
		echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
	else
		sudo sed -i '/fs.inotify.max_user_watches=524288/d' /etc/sysctl.conf && sudo sysctl -p
	fi
}

# Change login shell
#
# $1 = Shell to change to
#
change_shell() {
	echo -e "Changing your shell to ${1} ..."
	chsh -s "$(which "${1}")"
}

# Setup/Teardown zsh
#
# $1 = Setup vs Uninstall
#
zsh_use() {
	if [ -z "${1}" ]; then
		install_pkg zsh
		change_shell zsh
		echo "installing oh-my-zsh"
		if which wget &>/dev/null; then
			wget --no-check-certificate http://install.ohmyz.sh -O - | sh
		else
			curl -L http://install.ohmyz.sh | sh
		fi
	else
		change_shell bash
		uninstall_pkg zsh
	fi
}

#npm package list . simply add one more you like
#
# $1 = Only filled if wanting to remove packages
#
npm_package_list() {
	npm_install gulp "${1}"
	npm_install grunt "${1}"
	npm_install bower "${1}"
	npm_install mocha "${1}"
	npm_install testem "${1}"
	npm_install sails "${1}"
	npm_install express "${1}"
	npm_install surge "${1}"
}

#installing/uninstalling npm packages
#
# $1 = package name to install
# $2 = if not null, uninstall instead
#
#
npm_install() {
	local pkgname="${1}"

	if [ -z "${2}" ]; then
		if which "${pkgname}" &>/dev/null; then
			echo -e "\033[1;37m (${pkgname}) :: already installed \033[0m"
		else
			echo -e "\033[1;32m (${pkgname}) :: not installed; installing now \033[0m"
			sudo npm install -g "${pkgname}"
		fi
	else
		sudo npm uninstall "${pkgname}"
	fi
}

# Setup/Teardown node
#
# $1 = Setup vs Uninstall
#
setup_node() {
	if [ -z "${1}" ]; then
		install_pkg nodejs
		install_pkg npm
		npm_package_list
	else
		npm_package_list uninstall
		uninstall_pkg npm
		uninstall_pkg nodejs
	fi
}

# Setup/Teardown ruby
#
# $1 = Setup vs Uninstall
#
setup_ruby() {
	if [ -z "${1}" ]; then
		install_pkg ruby
		sudo gem install sass
		sudo gem install jekyll
		sudo gem install compass --pre
	else
		sudo gem uninstall compass
		sudo gem uninstall jekyll
		sudo gem uninstall sass
		uninstall_pkg ruby
	fi
}

# basic setup
basic_setup() {
	echo -e "\033[1;30m- running basic setup..."
	setup_node
	setup_ruby
	install_pkg git
	install_pkg sublime-text ppa:webupd8team/sublime-text-2;
	install_pkg imagemagick
	fix_common
	zsh_use
}

# Cleanup
cleanup() {
	echo -e "\033[1;30m- Running cleanup..."
	setup_node uninstall
	setup_ruby uninstall
	uninstall_pkg git
	uninstall_pkg sublime-text
	uninstall_pkg imagemagick
	fix_common uninstall
	zsh_use uninstall
}

#
# Display help message when noting is puted
#
usage() {
    cat <<EOF

        Usage: setup.sh [options]

        Options:
            -s         Run setup of dev tools
            -r         Remove intalled dev tools
            -h         Display usage message

        Built by @drKraken

EOF
}

dialog () {
    echo -e "\033[1;30m(v$SCRIPT_VERSION)\033[0;35m hello, $USER! thx for using  $SCRIPT_NAME ..."
    echo -e "\033[1;36mlets make some magic with your laptop ."
    echo -e "\033[1;36mwhat do you want? \033[1;33m[setup/remove/usage]: \033[0m"
    read -p "   -> " setup_type;

    case $setup_type in
        setup|-s|-S)
            basic_setup
            ;;
        remove|-r|-R)
            cleanup
            ;;
        usage)
            usage
            ;;
    esac
}

case $SCRIPT_FLAG in
    -s|--setup )
            basic_setup
        ;;
    -r|--remove )
            cleanup
        ;;
    -h|--help )
            usage
        ;;
    *)
        dialog
        ;;


esac