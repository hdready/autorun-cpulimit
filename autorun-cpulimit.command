
#!/bin/bash

echo "Make sure cpulimit is installed via Homebrew Cask (brew install cpulimit)"
# This is an endless loop meant to run on startup alongside crop-transcode-batch.sh
sleep 3




# readout number of CPUs
number_cpus="$(getconf _NPROCESSORS_ONLN)"
# default percentage used in case user enters no value
default_percentage="30"
# set default program in case user enters no value
default_application="HandBrakeCLI"


echo
echo "Please enter the Process Name or PID of the process you want to limit"
echo "(in 30 seconds the script will continue with the default setting: $default_application):"
read -t 30 application
application="${application:-$default_application}"
echo


while :
do

echo

# in case user has not put in any value, default or previously entered percentage will be used
cpu_input="${cpu_input:-$default_percentage}"
# save cpu_input for errors
cpu_input_old="$cpu_input"

# user has 30 seconds to input other value than the default percentage or correct the last input
if [ $default_percentage == $cpu_input ]; then
echo "Please enter the maximum percentage of CPU $application may use"
echo "or wait 30 seconds to use the default value: $cpu_input%"
else
echo "Please enter the maximum percentage of CPU $application may use"
echo "or wait 30 seconds to use your last input: $cpu_input%"
fi


read -t 30 cpu_input
echo

# remove %-character from cpu_input
cpu_input=${cpu_input//[%]/}
# empty cpu_input returns default value
re='^[0-9]+$'
if ! [[ $cpu_input =~ $re ]]; then
    echo "Your entered value $cpu_input is invalid, using default value."
    cpu_input=$cpu_input_old
elif [ "$cpu_input" -gt 100 ]; then
    echo "$cpu_input is too high, overclocking is not supported."
    cpu_input=$cpu_input_old
fi

# calculate cpulimit
cpu_max=$(($number_cpus * $cpu_input))

if [ $default_percentage == $cpu_input ]; then
    echo "Limiting CPU usage to $cpu_max% (default value)."
    else
    echo "Limiting CPU usage to $cpu_max%."
fi

echo "This is $cpu_input% on each of your $number_cpus CPUs."
echo


if ! [[ $application =~ $re ]] ; then
    # check for process ID
    PID="$(ps -A | grep -m1 $application | awk '{print $1}')"
else
    PID="$application"
fi


#show abort command
if ! [[ $application =~ $re ]] ; then
    echo "Press CTRL-C to set a different CPU limit for $application..."
else
    echo "Press CTRL-C to set a different CPU limit for PID $application..."
fi
cpulimit --pid $PID --limit $cpu_max

echo
echo "$application is done, checking for new $application process"

done
