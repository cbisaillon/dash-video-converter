#!/bin/bash

cd "to_do"

for f in *.mp4; do
	[ -f "$f" ] || break
	f=$(echo "$f" | cut -f 1 -d '.')
	#mkdir "$f"

	#fps=$(ffmpeg -i "${f}.mp4" 2>&1 | sed -n "s/.*, \(.*\) fp.*/\1/p")

	# Convert to 24 fps
	ffmpeg -i "${f}.mp4" -r 24 -y "${f}_24fps.mp4"

	x264 --output intermediate_2400k.264 --fps 24 --preset slow --bitrate 2400 --vbv-maxrate 4800 --vbv-bufsize 9600 --min-keyint 96 --keyint 96 --scenecut 0 --no-scenecut --pass 1 --video-filter "resize:width=1280,height=720" "${f}_24fps.mp4"

		
	#MP4Box -add intermediate_2400k.264 -fps 24 "${f}_2400k.mp4"
	#MP4Box -dash 4000 -frag 4000 -rap -segment-name segments/%s/segment_ "${f}_2400k.mp4" "${f}_24fps.mp4#audio"


	#rm "${f}_2400k.mp4"



done
