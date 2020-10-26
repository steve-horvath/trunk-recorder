#! /bin/bash

#set -e
#set -x

filename="$1"
#echo "Filename: $filename"

base="${filename%.*}"
#echo "Base: $base"

json="$base.json"
#echo "json: $json"

wav="$base.wav"
#echo "wav:  $wav"

length_float=$(soxi -D $wav)
#echo "length_float $length_float"

length=${length_float%.*}
#echo "length $length"

tg_filename=`basename $1`
#echo "tg_filename:  $tg_filename"

tg=${tg_filename:0:3}
#echo "TG:  $tg"

directory=`dirname $1`
#echo "directory:  $directory"

#echo "Checking call:  TG:  $tg  Length:  $length  File: "

if [ $length -gt 10 ]
then
  if [ $tg = "800" ] || [ $tg = "700" ]
    then
#    echo "$1 This file is an AVD dispatch ($length)  ($tg)"
    call_directory="$(echo $directory | /bin/sed 's/halton/halton_calls/g')"
#    echo $call_directory
    if [[ ! -d $call_directory ]]
    then
#      echo "making call diretory:  "
      /bin/mkdir -p $call_directory
#    else
#      echo "call directory exists"
    fi
  echo "Copying page to call system $1"
  /bin/cp $base.* $call_directory
  fi
#else
#  echo "$1 This file is NOT an AVD dispatch ($length)"
fi







#mp3encoded="$basename.mp3"
#eval "lame --preset voice" ${filename} 
#eval "nice -n 19 /home/luke/bin/ffmpeg -i $filename  -c:a libfdk_aac -b:a 32k -cutoff 18000 $mp4encoded > /dev/null 2>&1"

#echo "Upload: $encoded"  
#eval "scp $json $mp4encoded username@server.com:~/smartnet-upload "

