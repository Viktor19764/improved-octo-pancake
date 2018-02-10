#!/bin/bash
#
# bash script to create playlist files in media subdirectories
#

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
FILE_NAME=""
hostname="http://$(hostname -I | cut -d' ' -f1)"
#hostname=   #name may  be internet  type, http://domen, by default  set for  lan  ip
folder="muz_3/" #name of folder  from root  directory (if address is http://folder/file.mp4, folder="folder/")
find . -type d | 
while read subdir
do
 rm  *.m3u
 echo $subdir
 rm "$subdir"/*.m3u
done

find . -maxdepth 10 -type d | 

while read -r subdir
do
 echo "cykl"
 echo $subdir

function scan {
  urlencode "$( ls "$subdir" | grep "$filename" )"
}


 for filename in "$subdir"/*
  do
     #set  here types of  media  files
    if [[ -f "$filename" ]] && [[ $( echo "$filename" ) == *".avi"  ||  $( echo "$filename" ) == *".mp4"  ||  $(echo "$filename" ) == *".mkv" || $( echo "$filename" ) = *".mp3"  ||  $( echo "$filename" ) = *".torrent" || $( echo "$filename" ) = *".divx" || $( echo "$filename" ) = *".mpg" || $( echo "$filename" ) = *".webm" ]]
    then
     echo $filename  
    VAR0=$( ls "$subdir" | grep "$filename" )
     echo "1" ; echo $VAR0; echo "2"
   dirname_=$(dirname "$filename") 
   basename_=$(basename "$filename")
   basename_=$(python -c "import sys, urllib as ul;   print ul.quote('"$basename_"')")
   dirname_=$(python -c "import sys, urllib as ul;   print ul.quote('"$dirname_"')")
     filename="${filename:2}"
     dirname_="${dirname_:2}"
     echo  "$hostname/$folder$dirname_/$basename_" >> "$subdir/$(basename $subdir).m3u"
     elif [[ -d "$filename" ]]
       then
          dirname_=$(dirname "$filename") 
          basename_=$(basename "$filename")
          basename_=$(python -c "import sys, urllib as ul;   print ul.quote('"$basename_"')")
          dirname_=$(python -c "import sys, urllib as ul;   print ul.quote('"$dirname_"')")
          subdir_n=""
          subdir_n=$(python -c "import sys, urllib as ul;   print ul.quote('"$subdir"')")  
          filename="${filename:2}"
          dirname_="${dirname_:2}"
          VAR="${filename:3}"
          subdir_n="${subdir_n:2}"
          if [[ $subdir_n = "" ]]; then r=""; else r="/"; fi
          echo  "$hostname/$folder$r$dirname_/$basename_/$basename_.m3u" >> "$subdir/$(basename $subdir).m3u"
    fi     
 done  
done
mv ..m3u list.m3u

IFS=$SAVEIFS
