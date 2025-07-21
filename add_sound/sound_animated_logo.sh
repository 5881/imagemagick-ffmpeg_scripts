#!/bin/bash
DURATIONV=$(mediainfo --Inform="Video;%Duration%" "$1")
DURATIONA=$(mediainfo --Inform="Audio;%Duration%" "$2")
N=$((DURATIONA/DURATIONV + 1))
echo $DURATIONV $DURATIONA $N
rm temp.txt
while [ $N -gt 0 ];
do echo file $1>>temp.txt;
N=$((N-1))
done
ffmpeg -f concat -i temp.txt -i $2 -c copy -y ${1%.mp4}"_"${2%.mp3}".mp4"

#echo ffmpeg -loop 1 -i "$1" -i "$2"  -t $DURATION -vf format=yuv420p "$3"
#ffmpeg -loop 1 -i "$1" -i "$2"  -t $DURATION -vf format=yuv420p "$3"
