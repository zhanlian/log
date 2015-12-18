#!/bin/bash

#-l X : specify only show the Log level is X
#-t tagname : specify only show the tag with name "tagname"

adb logcat |
(
Log=""
Tag=""
ArgL=-l
ArgT=-t

#set initial argument

if [ -n "$1" ]; then
	if [ -n "$2" ]; then
		if [ $1 == $ArgL ]; then
			Log=$2
		elif [ $1 == $ArgT ]; then
			Tag=$2
		fi
	fi
fi

if [ -n "$3" ]; then
	if [ -n "$4" ]; then
		if [ $3 == $ArgL ]; then
			Log=$4
		elif [ $3 == $ArgT ]; then
			Tag=$4
		fi
	fi
fi

while read line;
do
	# get the first characters
    LEVEL=${line:0:1}
    
    if [ "$Log" != "" ]; then
    	if [ "$LEVEL" != "$Log" ]; then
    		continue
    	fi
    fi
    
    echo $line | grep "^./$Tag" -q
    if [ $? != 0 ]; then
    	continue
    fi
    
	if [ "$LEVEL" == "D" ]; then
		# echo Debug log in Blue
		echo -e "\033[34m $line \033[0m"
	elif [ "$LEVEL" == "I" ]; then
		# echo Info log in Green
		echo -e "\033[32m $line \033[0m"
	elif [ "$LEVEL" == "W" ]; then
		# echo Warning log in Yellow
		echo -e "\033[33m $line \033[0m"
	elif [ "$LEVEL" == "E" ]; then
		# echo Error log in Red
		echo -e "\033[31m $line \033[0m"
	else
		# echo Vervose log in Normal(Black)
		echo $line
	fi
done
)
# Please choose the color config as you wish
#30:黑
#31:红
#32:绿
#33:黄
#34:蓝色
#35:紫色
#36:深绿
#37:白色 

