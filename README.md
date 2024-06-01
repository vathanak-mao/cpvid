# cpvid
This is a Bash-shell script which creates a new copy of each video inside a directory with a new default audio language. It required `ffmpeg` library installed.

An MKV video file might have multiple audio languages embedded, which can be switched using some media players. However, some others like Chrome browser's media player plugin do not have the option to do so. This script is a workaround to play the video in the desired audio language.


## How-to

Supposedly, there are 3 videos inside the directory below:
```
~/Downloads/myviddir/
├── S02E01.mkv
├── S02E02.mkv
└── S02E03.mkv
```
Then, run the following command:
```
$ ./cpvid.sh "~/Downloads/myviddir"

Stream #0:0: Video: hevc (Main 10), yuv420p10le(tv), 1920x1080, SAR 1:1 DAR 16:9, 23.98 fps, 23.98 tbr, 1k tbn, 23.98 tbc (default)
    Stream #0:1(eng): Audio: aac (LC), 48000 Hz, 5.1, fltp (default)
    Stream #0:2(jpn): Audio: aac (LC), 48000 Hz, stereo, fltp
    Stream #0:3(eng): Subtitle: hdmv_pgs_subtitle, 1920x1080 (default)
    Stream #0:4(eng): Subtitle: hdmv_pgs_subtitle
Enter the audio language index (e.g. type '0' for 'Stream #0:1(hin)' or '1' for 'Stream #0:2(eng)' :
```
When prompted, type '`0`' to choose English or '`1`' to choose Japanese as the default audio language of the new videos.

And here is the output:
```
~/Downloads/myviddir/
├── NEW_S02E01.mkv
├── NEW_S02E02.mkv
├── NEW_S02E03.mkv
├── S02E01.mkv
├── S02E02.mkv
└── S02E03.mkv
```
