Ver 1.0

Thank you for downloading my tool -thecolonel63

Bash script v0.2  by Archie Halliwell

Notes:

This tool is extremely experimental! Use at your own risk (Expect some features to not work)

This tool works on Linux (it should also work on WSL, and possibly also macos)

It requires Zip, FFmpeg, bash, and GNU core utils

Tested on ubuntu 20.04 with ffmpeg version 4.2.4-1ubuntu0.1 and Zip 3.0 (July 5th 2008).

Instructions:

1. Any paths given to the program are relative to _your_ directory, not the script's. Also, just _don't_ make files/directories with `"` in them. The world folder name _cannot_ be absolute.

2. Run `HDConvert.sh` for the classic experience, `HDConvert-interactive.sh` if you want to type everything in yourself, or `HDConvert-non-interactive.sh` if you want it to be automated; either using `./[filename] [options]` or `bash [filename] [options]`. Use the `-h | --help` option for help.

3. If you are keeping the original aspect ratio (if it is 480p resolution or lower), just hit enter, otherwise, type 1 and hit enter to skip the aspect ratio conversion.

4. Wait until it says `Done`

5. Copy `out/$name` (where $name is by default VideoWorld) into your saves directory and load it up!

Credits:

PhoenixSC - Demonstrating on YouTube

thecolonel63 - Creation of Automatic Script

RTTV - Movie Theater build and Popcorn (Cookie)

Archie Halliwell - Conversion to bash
