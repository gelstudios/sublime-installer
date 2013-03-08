#!/bin/bash
#Sublime Text setup script for Ubuntu
#Run as sudo from same directory as downloaded archive

extract_move(){
	tar xf "$filename" -C /opt/
	#chown -R $USER:$USER /opt/Sublime\ Text\ 2/*
	ln -fs /opt/Sublime\ Text\ 2/sublime_text /usr/bin/subl
}

generate_config(){
	config_file='/usr/share/applications/sublime.desktop'
	if [ -e $config_file ]; then
		echo "$config_file"' exists, skipping config step'
	else
	config=('[Desktop Entry]' 'Version=1.0' 'Name=Sublime Text 2' 'GenericName=Text Editor' '' 'Exec=subl' 'Terminal=false' 'Icon=/opt/Sublime Text 2/Icon/256x256/sublime_text.png' 'Type=Application' 'Categories=TextEditor;IDE;Development' 'X-Ayatana-Desktop-Shortcuts=NewWindow' '' '[NewWindow Shortcut Group]' 'Name=New Window' 'Exec=subl -n' '' '[TargetEnvironment=Unity]' '')
	echo -n > ${config_file}
	for line in "${config[@]}"; do
		echo "${line}" >> ${config_file}
	done
	fi
};

default_editor(){
	def_file='/usr/share/applications/defaults.list'
	sed -i\'.backup\' -e \'s/gedit/sublime/g\' $def_file
};

main(){
	if [ -e "Sublime Text 2.0.1 x64.tar.bz2" ];then
		export filename='Sublime Text 2.0.1 x64.tar.bz2'
	elif [ -e "Sublime Text 2.0.1.tar.bz2" ];then
		export filename='Sublime Text 2.0.1.tar.bz2'
	else
		echo 'Sublime Text 2.0.1 archive not found'
		exit
	fi
	if [ -n "$filename" ]; then
	extract_move
	generate_config
	#default_editor
	fi
}

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run with sudo: $ sudo ./subl-install.sh" 
   exit 1
else
	main
fi

#just for fun
subl &
