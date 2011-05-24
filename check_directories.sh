#!/bin/bash
## Basic md5 check script.
## Jan Harasym <dijit@fsfe.org>
##
# Usage: ... I KNOW THE USAGE IT'S IN MY HEAD.--- GO AWAY!
## script-name.sh -w sitename (must be defined in the rootdir path)
rootdir="./"; ## Line to edit, most used directory for users requiring hashing,| set to "" to force absolute paths.

usage="\e[04;01mTo check the contents of web dir:\n\t\e[00;00m$0 -c \e[07;01msite\e[00;00m\e[04;01m\nTo reenumerate contents of web dir:\n\t\e[00;00m$0 -w \e[07;01msite\e[00;00m";
site=$2; #casting is required for it to be used in functions. (IE; dircheck)

success() {
     echo -e "\t\t\t\t\t\t\e[00;00m[\e[00;32m  OK  \e[00;00m]"; # so many tabulations! D:
     return 0; # I wonder how many worthless comments you'll read, before you realise I'm just wasting your time.
}

fail() {
     echo -e "\t\t\t\t\t\t\e[00;00m[\e[00;31m FAIL \e[00;00m]";
     exit 1; # seriously, that didn't dispell you?
}

dircheck() { # fair enough, just know, I don't comment well, I consider this fair warning. :P
printf "Checking For Directory:"
if [ -d "$rootdir$site" ] ; then
  success;
else
  fail;
fi
}
# I mostly just waste time.
case $1 in
  --check|-c) dircheck; # .. when I should be commenting that is.
  run="`md5sum -c .checksums_$2.md5 | grep FAILED`";
  printf "Checking Files:\t" ;;
  --write|-w) dircheck;
  run="`find $rootdir$2/ -type f -print0 | xargs -0 md5sum > .checksums_$2.md5`";
  printf "Enumerating Files:" ;;
  *) echo -e $usage;
     other="1" ;;
esac
if [ "$other" == "" ] ; then
  if [ "$run" != "" ] ; then
     fail;  # Did you know...
     exit 1;  # ...I was...
  else	#  ...Getting blown under the desk while writing this? :P
     success; # I Just thought I'd leave you with that thought.
     exit 0;
  fi
else
  exit 0;
fi
