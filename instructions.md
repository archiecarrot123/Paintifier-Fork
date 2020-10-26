Bash script v1.0  by Archie Halliwell

Notes:

This tool is experimental! Use at your own risk (Report bugs  [here](https://github.com/archiecarrot123/Paintifier-Fork/issues))

This tool works on Linux (it should also work on WSL, and possibly also bsd/macos)

It requires Zip, FFmpeg, bash, and GNU core utils

Tested on ubuntu 20.04 with ffmpeg version 4.2.4-1ubuntu0.1 and Zip 3.0 (July 5th 2008).

Instructions:

1. Any paths given to the program are relative to _your_ directory, not the script's. Also, just _don't_ make files/directories with `"` in them. The world folder name cannot be absolute.

2. Run `HDConvert.sh` either using `./[filename] [options] [arguments]` or `bash [filename] [options] [arguments]`. Use the `-h | --help` option for help.

3. Wait until it says `done`

4. Copy `out/$name` (where $name is VideoWorld or the second argument) into your saves directory and load it up!

Credits:

PhoenixSC - Demonstrating on YouTube

thecolonel63 - Creation of Automatic Script

RTTV - Movie Theater build and Popcorn (Cookie)

Archie Halliwell - Conversion to bash
