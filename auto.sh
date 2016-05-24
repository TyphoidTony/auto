#!/bin/bash
# NOTE there is no input checking, since I made this for myself I didn't bother to include it. 
#TODO add a long-ish delay after a set amount of actions . maybe 3-5 minutes after 150 actions. i.e. fake afk. 
#long delay can at the moment be done by the user by hitting ctrl+z to 
#TODO send input to multiple windows at the same time. Or at least seemingly at the same time.
#DONE: added user selected range for shuf command. no longer need to go into file to modify range for specific function.
#TODO add the ability for the mouse to get current loction of mouse before xdotool activates selected x,y loction and sends keypress
#This way you don't need to move the mouse back to the original loction. 
#TODO 


clicker(){

    while true;
    do
	x="$1";#x loction on the screen that you want pressed.
	y="$2";#y loction
	w="$3"; #name of window
	r1="$4";#starting range for shuf
	r2="$5";#ending range for shuf

	rand=$(shuf -i $r1-$r2  -n 1);


	echo $rand;

	window=$(xdotool search  $w  | head -1 );
	#Not really needed but useful to keep incase I find a use for
	#a variable that holds the current window.
	xdotool  windowactivate  $window
	xdotool  windowactivate  $window
	xdotool  windowactivate  $window
	xdotool  windowactivate  $window
	xdotool mousemove $x $y;

	xdotool   click 1;

	sleep $rand;

    done

}

presskey() {
    while true;
    do 
	key="$1";#key being pressed
	w="$2";#name of the window to send key presses to.
	r1="$3";#starting range for shuf
	r2="$4";#ending range for shuf
	rand=$(shuf -i $r1-$r2  -n 1);

	echo $rand;

	window=$(xdotool search  --name $w | head -1);


	xdotool key --clearmodifiers -window $window $key;
	sleep 1;
	xdotool key --clearmodifiers -window $window $key;
	sleep 1;
	xdotool key --clearmodifiers -window $window $key;
	sleep 1;
	sleep $rand;

    done;
}

getpos() {


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
############## START OF MAIN BLOCK########################
echo "What is the name of the window you want to control?"
read window

echo "Do you want a (c)licker or a (k)ey presser?"
read input


#### CLICKER OPTION ####
if [[ "$input" = "c" ]]
then 

    getpos
    

    echo "What x position do you want the mouse to click?"
    read xpos

    echo "What y position do you want the mouse to click?"
    read ypos


    echo "what range do you want the generator to be between?"

    echo "starting range:"
    read range1 

    echo "max range:"
    read range2

    clicker $xpos $ypos $window $range1 $range2
fi


#### KEY PRESSER OPTION ####
if [ "$input" = "k" ]
then 

    echo "Enter key combo you want to press e.g. ctrl+c";
    read keyPress;
    #TODO get this working
    echo "What range do you want the generator to be between?";
	
    echo "starting range:";
    read range1; 
	   
    echo "max range:";
    read range2;

    presskey $keyPress $window $range1 $range2
fi

################## END OF MAIN BLOCK#######################
