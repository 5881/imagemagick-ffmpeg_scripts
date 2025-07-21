#!/bin/zsh
magick -size 400x400 xc:'#00000C' -gravity center  -pointsize 24 -stroke black -strokewidth 7 -annotate 0 'Eritis sicut Deus, scientes bonum et malum' -stroke none -fill red -annotate 0 'Eritis sicut Deus, scientes bonum et malum' temp.png
magick temp.png -distort Arc 215 -fuzz 1% -transparent '#00000C'  -trim temp.png
magick -size 400x400 xc:'#00000C' -transparent '#00000C'  temp2.png
magick composite  temp.png temp2.png -gravity center -geometry +1-53 temp.png

STEP=$(echo "3.141592654*2/30"|bc -l)
for i in {0..29}
do
COS=$(echo "scale=3;c($STEP*$i)"|bc -q -l)
echo $COS
i=$(printf "%03d" $i)
if (( $(echo "$COS^2 > 0.0001"|bc -q -l) ))
then
echo $i
	if (( $(echo "$COS > 0"|bc -q -l) ))
	then
	magick 3only_red_black_border.png -distort SRT "100,130  $COS,1  0" "label"$i".png"
	else
	magick pentonly_red_black_border.png -distort SRT "100,130  $COS,1  0" "label"$i".png"
	fi
	magick composite  "label"$i".png" temp.png -gravity center -geometry +0+0  "label"$i".png"
	magick "label"$i".png" -trim "label"$i".png"
	magick composite "label"$i".png" $1 -gravity south -geometry +77+0 "label"$i".png"
fi
done

ffmpeg -r 15 -i label%03d.png -y -vcodec libx264 -vf format=yuv420p ${1%.*}.mp4
rm label0*png
