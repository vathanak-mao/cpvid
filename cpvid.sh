#!/bin/bash

#################################################################################################################
##	
##	This script creates a new copy of the video with a new default audio language.	
##	
##	This is helpful when some videos might support multiple audio languages, 
##	but some media players like the media plugin in Chrome browser
##	do not have an option to switch between languages.
##	Hence, they can only play a video with the default one.
## 	This script is a workaround to change the default audio language of the video to the desired one.
##	
##	The below example will make a copy of each video file inside "myviddir" directory,
##	and set English (instead of Hindy) as its default audio language.
##
##	$ ./cpvid.sh "myviddir"
##			Stream #0:1(hin): Audio: vorbis, 48000 Hz, stereo, fltp (default)
##			Stream #0:2(eng): Audio: opus, 48000 Hz, stereo, fltp
##		Enter the audio language index (e.g. type '0' for 'Stream #0:1(hin)' or '1' for 'Stream #0:2(eng)' : 1
##
#################################################################################################################


function is_zero_or_positive_integer() {
	[[ ! -z "$1" ]] && [[ "$1" =~ (^[0-9]+[1-9]?$)|(^[1-9]+[0-9]+$) ]]
}


## =====================================================


if [[ ! -d $1 ]]; then
	echo "[ERR] Video location is not provided or does not exit!"
	exit 1
fi

cd "$1" && echo "[DEB] Changed directory to $1"


## -----------------------------------------------------


## Get names of the source MKV files
filenames=$(find . -mindepth 1 -maxdepth 1 -type f -name '*.mkv' -printf '%P\n' | tr "\n" ":") 
echo "[DEB] filenames: $filenames"

IFS=":" read -a srcfiles <<< "$filenames" 

## Loop through the source files
count=0
default_lang_idx=-1
lang_idx=-1
newnames=()
for srcfile in "${srcfiles[@]}"; do
	echo "[DEB] srcfile: $srcfile"
	
	## Remove spaces from the names of source videos 
	## to avoid error when running ffmpeg command
	tmpname=$( echo "$srcfile" | tr " " "_" )
	mv "$srcfile" "$tmpname" && newnames+=("$tmpname")
	
	## List audio tracks
	ffmpeg -i $srcfile 2>&1 | grep -iE "(Stream #|$LANG: stream)"
	
	
	## Select language index
	if [[ $count == 0 ]]; then
		while true; do 
			read -p "Enter the audio language index (e.g. type '0' for 'Stream #0:1(hin)' or '1' for 'Stream #0:2(eng)' :" lang_idx
			
			if is_zero_or_positive_integer $lang_idx; then
				default_lang_idx = $lang_idx
				break;
			else 
				echo "Invalid index! Not a positive integer."
			fi
		done
	fi
	
	
	ffmpeg -i $tmpname -map 0:v -map 0:a:$lang_idx -c copy "NEW_$tmpname"

	
	((count=count+1))
done


## ---------------------------------------------------

## Rename the source videos back to their original ones
echo "[DEB] newnames: ${newnames[@]}"
for newname in ${newnames[@]}; do 
	originalname=$(echo $newname | tr "_" " ")
	mv "$newname" "$originalname"
done



