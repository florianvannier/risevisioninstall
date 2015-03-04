#!/bin/bash
clear 

#=======================================#
#		    CONFIGURATION				#
#=======================================#

# Colors scripting
VERT="\\033[1;32m"
NORMAL="\\033[0;39m"
ROUGE="\\033[1;31m"
BLEU="\\033[1;34m" 
CYAN="\\033[1;36m" 
ORANGE="\\033[0;33m"

# Wget download url
URL='https://rvaserver2.appspot.com/player/download?os=lnx&utm_source=player&utm_medium=linux-download&utm_campaign=Player'
FILE='rvplayer-installer.sh'
PATH_WGET='/etc/wgetrc'

# Dependencies
DEP_1='openjdk-7-jre'
DEP_2='at'
DEP_3='libudev1'
DEP_4='libxss1'

# Library Link
LINK_0='/lib/i386-linux-gnu/libudev.so.1'
LINK_1='/lib/i386-linux-gnu/libudev.so.0'

# Proxy settings
PROX_PATH_CONF='/etc/apt/apt.conf'
PROX=`cat $PROX_PATH_CONF | grep http::proxy | cut -d '/' -f 3` # FINISH

#=======================================#
#				 END					#
#=======================================#


# About me (&mY|*3/V15)
echo "" 
echo -e "$VERT" " ------------------ ""$ROUGE"" Rise Vision Linux Installer ""$VERT"" ---------- " "$NORMAL" 
echo -e " | Linux 14.04 - 32bits			     	             | "
echo -e " | Written by""$VERT" "Florian Vannier" "$CYAN""(vannier.florian@orange.fr) " "$NORMAL" " | " 
echo -e " | This script is""$BLEU"" free Licence""$NORMAL""                               | "
echo -e "$VERT" " ------------------------------------------------------------ " "$NORMAL" 

 
# Check dependencies
echo -e "$ORANGE"'\n\nCheck and install dependencies\n'"$NORMAL"
apt-get -q -y install $DEP_1
apt-get -q -y install $DEP_2
apt-get -q -y install $DEP_3
apt-get -q -y install $DEP_4
echo -e "$VERT"'Done.'"$NORMAL"

#Proxy detection - Aqcuire proxy via apt.conf
if [ -s "$PROX_PATH_CONF" ]
then
	echo -e "$ORANGE"'\nProxy detected'
	echo -e "Proxy address: ""$VERT""$PROX\n""$NORMAL"
	
else
	echo -e "$VERT""No proxy detected\n""$NORMAL"
fi
sleep 1

# Library symbolic link 
if [ ! -h "$LINK_1" ]
then
	echo -e "$ORANGE""Create symbolic link""$NORMAL"
	ln -s $LINK_0 $LINK_1
	echo -e "$VERT"'Done.'"$NORMAL"
fi
sleep 1

# Check if rvplayer-installer exist
if [ ! -s "$FILE" ]
then
	# Proxy or not - Configure wgetrc
	echo -e "$ORANGE"'Downloading the official setup script'"$NORMAL"
	if [ "$PROX" ]; then 
		:> $PATH_WGET
		echo "use_proxy = yes" >> $PATH_WGET
		echo "https_proxy = http://$PROX/" >> $PATH_WGET
		echo "http_proxy = http://$PROX/" >> $PATH_WGET
		wget $URL -O $FILE
	else
		wget $URL -O $FILE
	fi
	echo -e "$VERT"'Done.'"$NORMAL"

# Add x to execute
chmod a+x $FILE
fi

sudo bash ./$FILE
rm -f $PATH_WGET
exit 0 
