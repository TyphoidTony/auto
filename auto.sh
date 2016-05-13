# NOTE there is no input checking, since I made this for myself I didn't bother to include it. 
#TODO add a long-ish delay after a set amount of actions . maybe 3-5 minutes after 150 actions. i.e. fake afk.
#TODO ask inbetween sleep intervals if I want to sleep for a set amount of time or sleep until told to stop. 
#TODO ask for window to send input into. 
clicker(){

    while true;
    do
	rand=$(shuf -i  57-100 -n 1);

	x="$1";
	y="$2";
	w="$3"
	echo $rand;

	wurm=$(xdotool search $w windowactivate --sync );

	xdotool key --clearmodifiers  mousemove $x $y;##use xdotool getmouselocation to get the loction of the "continue" Button 

	xdotool key --clearmodifiers  click 1;

	sleep $rand;

    done

}

presskey(){
    while true;
    do 
	key="$1";#put key you want pressed three times here.
	w = "$2"
	rand=$(shuf -i 58-99  -n 1);

	echo $rand;

	wurm=$(xdotool search --onlyvisible --class $w | head -1);

	xdotool key --clearmodifiers -window $wurm $key;
	sleep 1
	xdotool key --clearmodifiers -window $wurm $key;
	sleep 1
	xdotool key --clearmodifiers -window $wurm $key;
	sleep 1
	sleep $rand;

    done
}

getpos(){


    while true 
    do
	echo "Do you want to get current x and y positions of your mouse? y/n"
	read input
	if [ "$input" = "y" ]
	then 
	    xdotool getmouselocation
	fi
	

	if [ "$input" = "n" ]
	then
	    break
	fi

    done

}

echo "What is the name of the window you want to control?"
read window

echo "Do you want a (c)licker or a (k)ey presser?"
read input

if [[ "$input" = "c" ]];
then 

    getpos
    
    echo "What x position do you want the mouse to click?"
    read xpos

    echo "What y position do you want the mouse to click?"
    read ypos

    clicker $xpos $ypos $window
fi

if [ "$input" = "k" ]
then 

    echo "Enter key combo you want to press e.g. ctrl+c";
    read keyPress;
    presskey $keyPress $window
fi


