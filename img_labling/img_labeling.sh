#!/bin/zsh
magick -size 400x400 xc:'#00000C' -gravity center  -pointsize 24 -stroke black -strokewidth 2 -annotate 0 'Eritis sicut Deus, scientes bonum et malum' -stroke none -fill red -annotate 0 'Eritis sicut Deus, scientes bonum et malum' temp.png
magick temp.png -distort Arc 215 -fuzz 1% -transparent '#00000C'  -trim temp.png
magick -size 400x400 xc:'#00000C' -transparent '#00000C'  temp2.png
magick composite  temp.png temp2.png -gravity center -geometry +3-53 temp.png
magick composite  red3blackcontur.png temp.png -gravity center -geometry +0+0  temp.png
magick temp.png -trim temp.png
magick composite temp.png $1 -gravity south -geometry +0+0 $1_labled.png
