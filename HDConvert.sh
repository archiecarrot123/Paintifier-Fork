#!/bin/bash
tmpdir="/tmp/MCHDConvert"
mkdir -p "$tmpdir"
scriptdir=$(dirname "$0")

if ! zip -v &> /dev/null
then
    echo "zip could not be found"
    exit
fi
if ! ffmpeg -version &> /dev/null
then
    echo "ffmpeg could not be found"
    exit
fi

break=true
short=false
rpack=false

for arg in "$@"
  do
    for _ in once
      do
        if [[ "$arg" = -* ]]
          then
            if [ "$arg" == '--no-break' ]
              then
                break=false
                shift
                break
            fi

            if [ "$arg" == '--short' ]
              then
                short=true
                shift
                break
            fi

            if [ "$arg" == '--resource-pack' ]
              then
                rpack=true
                shift
                break
            fi

            if [[ "$arg" == *h* ]] || [ "$arg" == '--help' ]
              then
                echo usage: HDConvert-interactive.sh [options] [input filename] [output foldername]
                echo "options:   -h \| --help         # display this help"
                echo "           -l \| --no-break     # don't add a three second break"
                echo "           -s \| --short        # draw thumbnail from 1st frame,"
                echo "                                # required for <1 second videos' thumnails"
                echo "           -r \| --resource-pack    # make a resouce pack instead of a world"
                exit
            fi

            if [[ "$arg" == *l* ]]
              then
                break=false
            fi

            if [[ "$arg" == *s* ]]
              then
                short=true
            fi

            if [[ "$arg" == *r* ]]
              then
                rpack=true
            fi
            shift
        fi
    done
done

if [ -n "$1" ]
  then
    filename="$1"
    if [ -n "$2" ]
      then
        name="$2"
      else
        name=VideoWorld
    fi
  else
    filename=(input-original.*)
    name=VideoWorld
fi

if [ ! -e "$filename" ]
  then
    echo "Your specified file ($filename) doesn't exist"
    exit
fi

if [ $break == true ]
  then
    ffmpeg -loglevel error -stats -i "$filename" -vf "trim=0:4,geq=0:128:128" -af "atrim=0:4,volume=0" -video_track_timescale 600 -c:v libx264 -f mp4 "$tmpdir/sec.mp4"
    ffmpeg -loglevel error -stats -i "$filename" -c:v libx264 -video_track_timescale 600 -f mp4 "$tmpdir/full600.mp4"
    # Creates a text file required for concatenation.
    printf "file '%s'\n" "sec.mp4" "full600.mp4" > "$tmpdir/list.txt"
    ffmpeg -loglevel error -stats -f concat -i "$tmpdir/list.txt" -c copy -f mp4 "$tmpdir/merged.mp4"
    rm "$tmpdir/list.txt"
    rm "$tmpdir/full600.mp4"
    rm "$tmpdir/sec.mp4"
  else
    ffmpeg -loglevel error -stats -i "$filename" -c:v libx264 -video_track_timescale 600 -f mp4 "$tmpdir/merged.mp4"
fi



ffmpeg -loglevel error -stats -i "$tmpdir/merged.mp4" -vf "scale=iw*min(1024/iw\,512/ih):ih*min(1024/iw\,512/ih),pad=1024:512:(1024-iw)/2:(512-ih)/2" "$tmpdir/input-modded.mp4"


rm "$tmpdir/merged.mp4"

mkdir -p "out/$name/resources/assets/minecraft/sounds/audio"

ffmpeg -loglevel error -stats -i "$filename" -q:a 0 -map a "out/$name/resources/assets/minecraft/sounds/audio/audio.ogg"

rate=$(ffprobe -v error -select_streams v -of default=noprint_wrappers=1:nokey=1 -show_entries stream=r_frame_rate "$filename")
O="20/($rate)"

ffmpeg -loglevel error -stats -i "$tmpdir/input-modded.mp4" -filter:v "setpts=$O*PTS" "$tmpdir/input.mp4"

rm "$tmpdir/input-modded.mp4"

echo Standard Convert Active!

mkdir "out/$name/resources/assets/minecraft/textures"
for n in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
do
  mkdir "out/$name/resources/assets/minecraft/textures/number$n"
done

W=1
H=1

ffmpeg -loglevel error -stats -i "$tmpdir/input.mp4" -filter_complex "[0:v]crop=iw/4:ih/4:0:0[out1];[0:v]crop=iw/4:ih/4:iw/4:0[out2];[0:v]crop=iw/4:ih/4:iw/2:0[out3];[0:v]crop=iw/4:ih/4:iw/1.33333333:0[out4];[0:v]crop=iw/4:ih/4:0:ih/4[out5];[0:v]crop=iw/4:ih/4:iw/4:ih/4[out6];[0:v]crop=iw/4:ih/4:iw/2:ih/4[out7];[0:v]crop=iw/4:ih/4:iw/1.33333333:ih/4[out8];[0:v]crop=iw/4:ih/4:0:ih/2[out9];[0:v]crop=iw/4:ih/4:iw/4:ih/2[out10];[0:v]crop=iw/4:ih/4:iw/2:ih/2[out11];[0:v]crop=iw/4:ih/4:iw/1.33333333:ih/2[out12];[0:v]crop=iw/4:ih/4:0:ih/1.33333333[out13];[0:v]crop=iw/4:ih/4:iw/4:ih/1.33333333[out14];[0:v]crop=iw/4:ih/4:iw/2:ih/1.33333333[out15];[0:v]crop=iw/4:ih/4:iw/1.33333333:ih/1.33333333[out16]" \
-map "[out1]" "$tmpdir/out1.mp4" -map "[out2]" "$tmpdir/out2.mp4" -map "[out3]" "$tmpdir/out3.mp4" -map "[out4]" "$tmpdir/out4.mp4" -map "[out5]" "$tmpdir/out5.mp4" -map "[out6]" "$tmpdir/out6.mp4" -map "[out7]" "$tmpdir/out7.mp4" -map "[out8]" "$tmpdir/out8.mp4" -map "[out9]" "$tmpdir/out9.mp4" -map "[out10]" "$tmpdir/out10.mp4" -map "[out11]" "$tmpdir/out11.mp4" -map "[out12]" "$tmpdir/out12.mp4" -map "[out13]" "$tmpdir/out13.mp4" -map "[out14]" "$tmpdir/out14.mp4" -map "[out15]" "$tmpdir/out15.mp4" -map "[out16]" "$tmpdir/out16.mp4"

(( "W = $W*2" ))

(( "H = $W*2" ))

frames=$(ffprobe -v error -select_streams v:0 -show_entries stream=nb_frames -of default=nokey=1:noprint_wrappers=1 "$tmpdir/input.mp4")

for n in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
do
  ffmpeg -loglevel error -stats -y -i "$tmpdir/out$n.mp4" -filter_complex "[0:v]scale=iw/$W:iw/$H,crop=iw/4:ih/2:0:0,tile=1x$frames,select=not(mod(n\,20))[out1]; [0:v]scale=iw/$W:iw/$H,crop=iw/4:ih/2:iw/4:0,tile=1x$frames,select=not(mod(n\,20))[out2]; [0:v]scale=iw/$W:iw/$H,crop=iw/4:ih/2:iw/2:0,tile=1x$frames,select=not(mod(n\,20))[out3]; [0:v]scale=iw/$W:iw/$H,crop=iw/4:ih/2:iw/1.33333333:0,tile=1x$frames,select=not(mod(n\,20))[out4]; [0:v]scale=iw/$W:iw/$H,crop=iw/4:ih/2:0:ih/2,tile=1x$frames,select=not(mod(n\,20))[out5]; [0:v]scale=iw/$W:iw/$H,crop=iw/4:ih/2:iw/4:ih/2,tile=1x$frames,select=not(mod(n\,20))[out6]; [0:v]scale=iw/$W:iw/$H,crop=iw/4:ih/2:iw/2:ih/2,tile=1x$frames,select=not(mod(n\,20))[out7]; [0:v]scale=iw/$W:iw/$H,crop=iw/4:ih/2:iw/1.33333333:ih/2,tile=1x$frames,select=not(mod(n\,20))[out8] " \
  -map "[out1]" "out/$name/resources/assets/minecraft/textures/number$n/1.png" -map "[out2]" "out/$name/resources/assets/minecraft/textures/number$n/2.png" -map "[out3]" "out/$name/resources/assets/minecraft/textures/number$n/3.png" -map "[out4]" "out/$name/resources/assets/minecraft/textures/number$n/4.png" -map "[out5]" "out/$name/resources/assets/minecraft/textures/number$n/5.png" -map "[out6]" "out/$name/resources/assets/minecraft/textures/number$n/6.png" -map "[out7]" "out/$name/resources/assets/minecraft/textures/number$n/7.png" -map "[out8]" "out/$name/resources/assets/minecraft/textures/number$n/8.png"
done

rm "$tmpdir"/out*.mp4
if [ $rpack == true ]
  then
    cp -r "$scriptdir"/HDTemplate/resources "out/$name"
    if [ $short == false ]
      then
        ffmpeg -y -loglevel error -stats -i "$filename" -vf "scale=iw*min(128/iw\,128/ih):ih*min(128/iw\,128/ih),pad=128:128:(128-iw)/2:(128-ih)/2,select=eq(n\,ceil($rate))" -vframes 1 "out/$name/resources/pack.png"
      else
        ffmpeg -y -loglevel error -stats -i "$filename" -vf "scale=iw*min(128/iw\,128/ih):ih*min(128/iw\,128/ih),pad=128:128:(128-iw)/2:(128-ih)/2,select=eq(n\,0)" -vframes 1 "out/$name/resources/pack.png"
    fi
    cd "out/$name/resources/" || exit
    zip -qr "../../$name.zip" .
    cd ../../.. || exit

    rm -r "out/$name"
  else
    cp -r "$scriptdir"/HDTemplate/* "out/$name"
    if [ $short == false ]
      then
        ffmpeg -y -loglevel error -stats -i "$filename" -vf "scale=iw*min(64/iw\,64/ih):ih*min(64/iw\,64/ih),pad=64:64:(64-iw)/2:(64-ih)/2,select=eq(n\,ceil($rate))" -vframes 1 "out/$name/icon.png"
      else
        ffmpeg -y -loglevel error -stats -i "$filename" -vf "scale=iw*min(64/iw\,64/ih):ih*min(64/iw\,64/ih),pad=64:64:(64-iw)/2:(64-ih)/2,select=eq(n\,0)" -vframes 1 "out/$name/icon.png"
    fi
    cd "out/$name/resources/" || exit
    zip -qr "../resources.zip" .
    cd ../../.. || exit

    #mv "out/$name/resources/resources.zip" "out/$name/"
    rm -r "out/$name/resources"
fi

rm "$tmpdir/input.mp4"

echo "done"
