#!/bin/bash
cp -r /home/$USER/Images /home/$USER

if [ -d /home/$USER/.config ]; then
	rm -rf /home/$USER/.config
fi

cp -r ./config /home/$USER/.config

cat ./bash_files/bashrc > /home/$USER/.bachrc
