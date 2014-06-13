#!/bin/bash

# Create Hypnoturtle MP4

# http://www.imagemagick.org/Usage/color_mods/#modulate_hue

# https://trac.ffmpeg.org/wiki/Create%20a%20video%20slideshow%20from%20images

set -e

# source image
readonly src=original.jpeg
# starting hue
readonly start=0
# hue stepping
readonly step=6
# ending hue (200 is back to the start)
readonly end=199
# frames per second
readonly framerate=30

rm -f tmp*.png hypnoturtle.mp4

echo Converting images...

for i in $(seq $start $step $end); do
  padded=$(printf "%03d\n" $i)
  convert $src -modulate 100,100,$i tmp$padded.png
done

echo Creating mp4...

ffmpeg -r $framerate -pattern_type glob -i 'tmp*.png' -c:v libx264 -pix_fmt yuv420p hypnoturtle.mp4

rm -f tmp*.png

echo 'Done! You now have hypnoturtle.mp4'
