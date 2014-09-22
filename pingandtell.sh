#!/bin/bash
# Ping an IP address(or hostname) and announce when successful.
#  - https://github.com/ansoni/ping-and-tell
#  - Please send useful pull requests to make the script better.

IP=$1
CHEER=$2
SAY=/usr/bin/say

#we could discover other ways to speak someday
if [ ! -f $SAY ];then
  echo "Can't find $SAY so I am unable to announce which is the whole point I exist"
  exit 1
fi

if [ -z "$CHEER" ];then
  CHEER="rock on!"
fi

if [ -z "$IP" ];then
  message="Please provide me an IP address or hostname to ping"
  echo $message
  $SAY $message
  exit 1
fi

if [ "IP" -eq "-h" ];then
  echo "./$0 <ipaddress> <optional cheer>"
  echo "I ping an address until success and then I tell you about it"
  exit 0
fi

echo "Pinging $IP until success and will tell you about it"
while [ true ]; do 
  # Let the output through so people know we are working
  ping -c 1 ${IP} 
  res=$?
  if [ $res == 0 ]; then
    $SAY "Ping to ${IP} was successful, $CHEER"
    exit 0
  fi
  sleep 1 # Engineers are impatient
done
