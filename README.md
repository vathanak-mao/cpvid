# cpvid
This is a Bash-shell script which creates a new copy of each video inside a directory with a new default audio language. It required `ffmpeg` library installed.

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
```
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
