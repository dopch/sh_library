## exit function with message ##
function my_exit()
{
    echo $0 "exited with error code" $@
    exit $@
}

## exit function with message and function origin ##
function my_exit_from_func()
{
    echo $0 "exited with error code" $1 "from function" $2
    exit $1
}

## print failed service on centos or fedora system mimic sytemctl --state-failed
function run_health_check()
{
    find /usr/lib/systemd/system -type f -name '*.service' | while read service; do
        {
            ms=$(echo $service | cut -d '/' -f6)
            if [ ! $(echo $ms | grep "@") ]
            then
                systemctl status $ms | grep "Active: failed" && echo "THIS SERVICE FAILED "$ms
            fi
        }
    done
}

## Print nb of attr given to your script ##
function get_nb_attr()
{
    echo $@
}

## Switch case example ##
function switch_case_yn()
{
    case $@ in
	[y-Y]) echo "yes"
	   ;;
	[n-N]) echo "no"
	   ;;
	[1-4]) echo "1 to 5"
	       ;;
	*) echo "Other"
	   ;;
    esac
}

## If root test ##
function root_test()
{
    if [ $(id -u) != 0 ]; then
	echo "This script must be run as root"
	my_exit 1
    fi
}

function OLD_displayWarning()
{
    while read -p "$1 (Y/N): " data
    do
        if [ "$data" = "N" ]; then
            echo "exiting..."
            exit 1
        elif [ "$data" != "Y" ]; then
            continue
        else
            break
        fi
    done
}

function ask_confirmation_or_exit()
{
    loop=true
    while [ "$loop" = "true" ];do
	read -p "$@ (Y/N or y/n): " retuser
	case $retuser in
            [y-Y]) echo "Yes received programe will continue now" && loop=false
		   ;;
            [n-N]) echo "no received programe will stop now" && my_exit 1
		   ;;
            *) echo "Please choose between Y or N / y or n"
               ;;
	esac
    done
}

function logthat()
{
    DATE=`date +%Y-%m-%d:%H:%M:%S`
    echo "$DATE $1" >> $2
    echo $1
}

function echogreen()
{
    echo -e "\e[1;32m$@\e[0m"
    logthat "Function echogreen : $@"
}

function echored()
{
    echo -e "\e[1;31m$@\e[0m"
    logthat "Function echored : $@"
    exit 1
}

function echocyan()
{
    echo -e "\e[1;36m$@\e[0m"
    logthat "Function echocyan : $@"
}

function rpmupdate()
{
    if [ -f $PWD/$@.tar ]; then
        echogreen "$@ found"
    else
        echored "No folder found for $@."
        exit 1
    fi
    tar -xf $@.tar
    rpm -iUvh $PWD/$@/*.rpm
}

function rpminfo()
{
    if [ -f $PWD/$@.tar ]; then
        echogreen "$@ found"
    else
        echored "No folder found for $@."
        exit 1
    fi
    tar -xf $@.tar
    INFORPM=`rpm -qip $PWD/$@/*.rpm`
    logthat "RPM INFO $INFORPM"
    rm -rf $@
}

function ifpresent()
{
    if [ ! -f $PWD/$@ ]; then
        echored "File $@ not found"
    fi
}

