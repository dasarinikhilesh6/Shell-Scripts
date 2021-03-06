#!/bin/bash
# - script to perform the following:
# - Checking status of the applications
# - Print PID of running applications
# - Exit if applications are still running after 60sec
check_status () {
echo "$HOME_DIR"
n=1
while [ $n -le 12 ]
do
#SSDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
sleep 5
echo "Checking status"
ps -ef | grep -v grep | grep "$HOME_DIR/SoloSync" --color
if [ $? = 0 ]
    then
        echo "-----------------------------------------------------------------------------"
        echo "Application still running"
    else
        echo "-----------------------------------------------------------------------------"
        echo "Application stopped"
        echo "End"
    exit
fi
n=$[$n+1]
if [ $? = 0 ]
    then
       echo "Printing PID"
       ps -ef | grep -v grep | grep ""$HOME_DIR"/SoloSync" --color | awk '{print $2}'
    else
       echo "-----------------------------------------------------------------------------"
fi
if [ $n = 12 ]
   then
       echo "-----------------------------------------------------------------------------"
       echo "error encountered"
    exit 87
fi
done
}
###Script usage- for wrong flag entered
    usage ()  {
    echo "This script needs one flag with the value "
    echo "Example of correct usage is  ./shutdown_status.sh -d HOME_DIR"
    exit 87

}

### Assigning variables
    set_environment  () {
    echo "Checking and assigning variables"

    while getopts ":d:" opt
    do
        case "$opt" in
        d) HOME_DIR="$OPTARG" ;;
       \?) echo "Wrong flag "
             usage ;;
    esac
    done
   }

################
###   MAIN   ###
################

    if [ $# -ne 2 ]; then
     usage
    fi
    echo "------------------------------------------------------------------------------"
    set_environment "$@"
        check_status
    echo "------------------------------------------------------------------------------"
