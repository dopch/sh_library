# sh_library
Shell script library


# Call Example:

Call my_exit with return code 1
my_exit 1


Get failed service from Centos or Fedora system
run_health_check

Get number of attributes given to your shell script
get_nb_attr $#

get_attr_by_pos()
{
    echo $@
}


switch_case_yn()
{
    case $0 in
        y) echo "yes"
           ;;
        n) echo "no"
           ;;
        *) echo "Other"
           ;;
    esac
}
