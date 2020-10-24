#!/bin/bash

#@echo off

cd "$(dirname "$0")"

#set /p Skip="To skip correct scale, type 1 and hit enter, otherwise just hit enter: "
echo "To skip correct scale, type 1 and hit enter, otherwise just hit enter: "
read skip

#"%cd%\ffmpeg.exe" -i "%cd%\input-original.mp4" -vf trim=0:4,geq=0:128:128 -af atrim=0:4,volume=0 -video_track_timescale 600 sec.mp4
ffmpeg -i input-original.mp4 -vf trim=0:4,geq=0:128:128 -af atrim=0:4,volume=0 -video_track_timescale 600 -f mp4 sec.mp4

#"%cd%\ffmpeg.exe" -i "%cd%\input-original.mp4" -c copy -video_track_timescale 600 full600.mp4
ffmpeg -i input-original.mp4 -c copy -video_track_timescale 600 -f mp4 full600.mp4

#"%cd%\ffmpeg.exe" -f concat -i "%cd%\list.txt" -c copy merged.mp4
ffmpeg -f concat -i list.txt -c copy -f mp4 merged.mp4

#if "%Skip%"=="1" goto skip
#
#"%cd%\ffmpeg.exe" -i "%cd%\merged.mp4" -vf "pad=width=1024:height=512:x=512-(iw/2):y=256-(ih/2):color=black" "%cd%\input-moddeda.mp4"  
#
#"%cd%\ffmpeg.exe" -i "%cd%\input-moddeda.mp4" -s 1024x512 -c:a copy input-modded.mp4
#goto continue
#
#:skip
#
#"%cd%\ffmpeg.exe" -i "%cd%\merged.mp4" -s 1024x512 -c:a copy input-modded.mp4
#goto continue
#
#:continue

if "%Skip"==1
then
  ffmpeg -i merged.mp4 -s 1024x512 -c:a copy input-modded.mp4
else 
  #ffmpeg -i merged.mp4 -vf "pad=width=1024:height=512:x=512-(iw/2):y=256-(ih/2):color=black" input-moddeda.mp4
  ffmpeg -i merged.mp4 -vf "scale=iw*min(1024/iw\,512/ih):ih*min(1024/iw\,512/ih),pad=1024:512:(1024-iw)/2:(512-ih)/2" input-moddeda.mp4
  ffmpeg -i input-moddeda.mp4 -s 1024x512 -c:a copy input-modded.mp4
fi

#del "%cd%\full600.mp4"
rm full600.mp4

#del "%cd%\merged.mp4"
rm merged.mp4

#del "%cd%\input-moddeda.mp4"
rm input-moddeda.mp4

#del "%cd%\sec.mp4"
rm sec.mp4

#mkdir "%cd%\out\assets\minecraft\sounds\audio"
mkdir out
mkdir out/assets
mkdir out/assets/minecraft
mkdir out/assets/minecraft/sounds
mkdir out/assets/minecraft/sounds/audio

#"%cd%\ffmpeg.exe" -i "%cd%\input-original.mp4" -q:a 0 -map a "%cd%\out\assets\minecraft\sounds\audio\audio.ogg"
ffmpeg -i input-original.mp4 -q:a 0 -map a out/assets/minecraft/sounds/audio/audio.ogg

#"%cd%\ffprobe.exe" -v error -select_streams v -of default=noprint_wrappers=1:nokey=1 -show_entries stream=r_frame_rate input-original.mp4 > rate.txt
#for /f "delims== tokens=1" %%G in (rate.txt) do set F=%%G
#set O=20/(%F%)
rate="`ffprobe -v error -select_streams v -of default=noprint_wrappers=1:nokey=1 -show_entries stream=r_frame_rate input-original.mp4`"
O="20/($rate)"
echo $O

#"%cd%\ffmpeg.exe" -i "%cd%\input-modded.mp4" -filter:v "setpts=%O%*PTS" "%cd%\input.mp4"
ffmpeg -i input-modded.mp4 -filter:v "setpts=$O*PTS" input.mp4

#set scale=1
scale=1

#echo Standard Convert Active!
echo Standard Convert Active!

#mkdir "%cd%\out\assets\minecraft\textures\number1"
#mkdir "%cd%\out\assets\minecraft\textures\number2"
#mkdir "%cd%\out\assets\minecraft\textures\number3"
#mkdir "%cd%\out\assets\minecraft\textures\number4"
#mkdir "%cd%\out\assets\minecraft\textures\number5"
#mkdir "%cd%\out\assets\minecraft\textures\number6"
#mkdir "%cd%\out\assets\minecraft\textures\number7"
#mkdir "%cd%\out\assets\minecraft\textures\number8"
#mkdir "%cd%\out\assets\minecraft\textures\number9"
#mkdir "%cd%\out\assets\minecraft\textures\number10"
#mkdir "%cd%\out\assets\minecraft\textures\number11"
#mkdir "%cd%\out\assets\minecraft\textures\number12"
#mkdir "%cd%\out\assets\minecraft\textures\number13"
#mkdir "%cd%\out\assets\minecraft\textures\number14"
#mkdir "%cd%\out\assets\minecraft\textures\number15"
#mkdir "%cd%\out\assets\minecraft\textures\number16"
mkdir out/assets/minecraft/textures
for n in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
do
  mkdir "out/assets/minecraft/textures/number$n"
done
#set /a W=1
#set /a H=1
W=1
H=1

#"%cd%\ffmpeg" -i input.mp4 -filter_complex "[0:v]crop=iw/4:ih/4:0:0[out1];[0:v]crop=iw/4:ih/4:iw/4:0[out2];[0:v]crop=iw/4:ih/4:iw/2:0[out3];[0:v]crop=iw/4:ih/4:iw/1.33333333:0[out4];[0:v]crop=iw/4:ih/4:0:ih/4[out5];[0:v]crop=iw/4:ih/4:iw/4:ih/4[out6];[0:v]crop=iw/4:ih/4:iw/2:ih/4[out7];[0:v]crop=iw/4:ih/4:iw/1.33333333:ih/4[out8];[0:v]crop=iw/4:ih/4:0:ih/2[out9];[0:v]crop=iw/4:ih/4:iw/4:ih/2[out10];[0:v]crop=iw/4:ih/4:iw/2:ih/2[out11];[0:v]crop=iw/4:ih/4:iw/1.33333333:ih/2[out12];[0:v]crop=iw/4:ih/4:0:ih/1.33333333[out13];[0:v]crop=iw/4:ih/4:iw/4:ih/1.33333333[out14];[0:v]crop=iw/4:ih/4:iw/2:ih/1.33333333[out15];[0:v]crop=iw/4:ih/4:iw/1.33333333:ih/1.33333333[out16]" -map [out1] out1.mp4 -map [out2] out2.mp4 -map [out3] out3.mp4 -map [out4] out4.mp4 -map [out5] out5.mp4 -map [out6] out6.mp4 -map [out7] out7.mp4 -map [out8] out8.mp4 -map [out9] out9.mp4 -map [out10] out10.mp4 -map [out11] out11.mp4 -map [out12] out12.mp4 -map [out13] out13.mp4 -map [out14] out14.mp4 -map [out15] out15.mp4 -map [out16] out16.mp4
ffmpeg -i input.mp4 -filter_complex "[0:v]crop=iw/4:ih/4:0:0[out1];[0:v]crop=iw/4:ih/4:iw/4:0[out2];[0:v]crop=iw/4:ih/4:iw/2:0[out3];[0:v]crop=iw/4:ih/4:iw/1.33333333:0[out4];[0:v]crop=iw/4:ih/4:0:ih/4[out5];[0:v]crop=iw/4:ih/4:iw/4:ih/4[out6];[0:v]crop=iw/4:ih/4:iw/2:ih/4[out7];[0:v]crop=iw/4:ih/4:iw/1.33333333:ih/4[out8];[0:v]crop=iw/4:ih/4:0:ih/2[out9];[0:v]crop=iw/4:ih/4:iw/4:ih/2[out10];[0:v]crop=iw/4:ih/4:iw/2:ih/2[out11];[0:v]crop=iw/4:ih/4:iw/1.33333333:ih/2[out12];[0:v]crop=iw/4:ih/4:0:ih/1.33333333[out13];[0:v]crop=iw/4:ih/4:iw/4:ih/1.33333333[out14];[0:v]crop=iw/4:ih/4:iw/2:ih/1.33333333[out15];[0:v]crop=iw/4:ih/4:iw/1.33333333:ih/1.33333333[out16]" -map "[out1]" out1.mp4 -map "[out2]" out2.mp4 -map "[out3]" out3.mp4 -map "[out4]" out4.mp4 -map "[out5]" out5.mp4 -map "[out6]" out6.mp4 -map "[out7]" out7.mp4 -map "[out8]" out8.mp4 -map "[out9]" out9.mp4 -map "[out10]" out10.mp4 -map "[out11]" out11.mp4 -map "[out12]" out12.mp4 -map "[out13]" out13.mp4 -map "[out14]" out14.mp4 -map "[out15]" out15.mp4 -map "[out16]" out16.mp4

#:retry

#set /a W=%W%*2
let "W = $W*2"

#set /a H=%W%*2
let "H = $W*2"

#setlocal

#for /F "delims=" %%I in ('"%cd%\ffprobe.exe" -v error -select_streams v:0 -show_entries stream^=nb_frames -of default^=nokey^=1:noprint_wrappers^=1 input.mp4') do set "frames=%%I"
frames="`ffprobe -v error -select_streams v:0 -show_entries stream=nb_frames -of default=nokey=1:noprint_wrappers=1 input.mp4`"
echo $frames

#"%cd%\ffmpeg.exe" -y -i out1.mp4 -filter_complex "[0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:0,tile=1x%frames%,select=not(mod(n\,20))[out1]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:0,tile=1x%frames%,select=not(mod(n\,20))[out2]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:0,tile=1x%frames%,select=not(mod(n\,20))[out3]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:0,tile=1x%frames%,select=not(mod(n\,20))[out4]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out5]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out6]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out7]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out8] " -map [out1] out/assets/minecraft/textures/number1/1.png -map [out2] out/assets/minecraft/textures/number1/2.png -map [out3] out/assets/minecraft/textures/number1/3.png -map [out4] out/assets/minecraft/textures/number1/4.png -map [out5] out/assets/minecraft/textures/number1/5.png -map [out6] out/assets/minecraft/textures/number1/6.png -map [out7] out/assets/minecraft/textures/number1/7.png -map [out8] out/assets/minecraft/textures/number1/8.png
#"%cd%\ffmpeg.exe" -y -i out2.mp4 -filter_complex "[0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:0,tile=1x%frames%,select=not(mod(n\,20))[out1]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:0,tile=1x%frames%,select=not(mod(n\,20))[out2]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:0,tile=1x%frames%,select=not(mod(n\,20))[out3]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:0,tile=1x%frames%,select=not(mod(n\,20))[out4]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out5]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out6]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out7]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out8] " -map [out1] out/assets/minecraft/textures/number2/1.png -map [out2] out/assets/minecraft/textures/number2/2.png -map [out3] out/assets/minecraft/textures/number2/3.png -map [out4] out/assets/minecraft/textures/number2/4.png -map [out5] out/assets/minecraft/textures/number2/5.png -map [out6] out/assets/minecraft/textures/number2/6.png -map [out7] out/assets/minecraft/textures/number2/7.png -map [out8] out/assets/minecraft/textures/number2/8.png
#"%cd%\ffmpeg.exe" -y -i out3.mp4 -filter_complex "[0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:0,tile=1x%frames%,select=not(mod(n\,20))[out1]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:0,tile=1x%frames%,select=not(mod(n\,20))[out2]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:0,tile=1x%frames%,select=not(mod(n\,20))[out3]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:0,tile=1x%frames%,select=not(mod(n\,20))[out4]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out5]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out6]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out7]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out8] " -map [out1] out/assets/minecraft/textures/number3/1.png -map [out2] out/assets/minecraft/textures/number3/2.png -map [out3] out/assets/minecraft/textures/number3/3.png -map [out4] out/assets/minecraft/textures/number3/4.png -map [out5] out/assets/minecraft/textures/number3/5.png -map [out6] out/assets/minecraft/textures/number3/6.png -map [out7] out/assets/minecraft/textures/number3/7.png -map [out8] out/assets/minecraft/textures/number3/8.png
#"%cd%\ffmpeg.exe" -y -i out4.mp4 -filter_complex "[0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:0,tile=1x%frames%,select=not(mod(n\,20))[out1]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:0,tile=1x%frames%,select=not(mod(n\,20))[out2]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:0,tile=1x%frames%,select=not(mod(n\,20))[out3]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:0,tile=1x%frames%,select=not(mod(n\,20))[out4]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out5]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out6]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out7]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out8] " -map [out1] out/assets/minecraft/textures/number4/1.png -map [out2] out/assets/minecraft/textures/number4/2.png -map [out3] out/assets/minecraft/textures/number4/3.png -map [out4] out/assets/minecraft/textures/number4/4.png -map [out5] out/assets/minecraft/textures/number4/5.png -map [out6] out/assets/minecraft/textures/number4/6.png -map [out7] out/assets/minecraft/textures/number4/7.png -map [out8] out/assets/minecraft/textures/number4/8.png
#"%cd%\ffmpeg.exe" -y -i out5.mp4 -filter_complex "[0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:0,tile=1x%frames%,select=not(mod(n\,20))[out1]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:0,tile=1x%frames%,select=not(mod(n\,20))[out2]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:0,tile=1x%frames%,select=not(mod(n\,20))[out3]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:0,tile=1x%frames%,select=not(mod(n\,20))[out4]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out5]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out6]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out7]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out8] " -map [out1] out/assets/minecraft/textures/number5/1.png -map [out2] out/assets/minecraft/textures/number5/2.png -map [out3] out/assets/minecraft/textures/number5/3.png -map [out4] out/assets/minecraft/textures/number5/4.png -map [out5] out/assets/minecraft/textures/number5/5.png -map [out6] out/assets/minecraft/textures/number5/6.png -map [out7] out/assets/minecraft/textures/number5/7.png -map [out8] out/assets/minecraft/textures/number5/8.png
#"%cd%\ffmpeg.exe" -y -i out6.mp4 -filter_complex "[0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:0,tile=1x%frames%,select=not(mod(n\,20))[out1]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:0,tile=1x%frames%,select=not(mod(n\,20))[out2]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:0,tile=1x%frames%,select=not(mod(n\,20))[out3]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:0,tile=1x%frames%,select=not(mod(n\,20))[out4]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out5]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out6]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out7]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out8] " -map [out1] out/assets/minecraft/textures/number6/1.png -map [out2] out/assets/minecraft/textures/number6/2.png -map [out3] out/assets/minecraft/textures/number6/3.png -map [out4] out/assets/minecraft/textures/number6/4.png -map [out5] out/assets/minecraft/textures/number6/5.png -map [out6] out/assets/minecraft/textures/number6/6.png -map [out7] out/assets/minecraft/textures/number6/7.png -map [out8] out/assets/minecraft/textures/number6/8.png
#"%cd%\ffmpeg.exe" -y -i out7.mp4 -filter_complex "[0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:0,tile=1x%frames%,select=not(mod(n\,20))[out1]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:0,tile=1x%frames%,select=not(mod(n\,20))[out2]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:0,tile=1x%frames%,select=not(mod(n\,20))[out3]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:0,tile=1x%frames%,select=not(mod(n\,20))[out4]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out5]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out6]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out7]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out8] " -map [out1] out/assets/minecraft/textures/number7/1.png -map [out2] out/assets/minecraft/textures/number7/2.png -map [out3] out/assets/minecraft/textures/number7/3.png -map [out4] out/assets/minecraft/textures/number7/4.png -map [out5] out/assets/minecraft/textures/number7/5.png -map [out6] out/assets/minecraft/textures/number7/6.png -map [out7] out/assets/minecraft/textures/number7/7.png -map [out8] out/assets/minecraft/textures/number7/8.png
#"%cd%\ffmpeg.exe" -y -i out8.mp4 -filter_complex "[0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:0,tile=1x%frames%,select=not(mod(n\,20))[out1]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:0,tile=1x%frames%,select=not(mod(n\,20))[out2]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:0,tile=1x%frames%,select=not(mod(n\,20))[out3]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:0,tile=1x%frames%,select=not(mod(n\,20))[out4]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out5]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out6]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out7]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out8] " -map [out1] out/assets/minecraft/textures/number8/1.png -map [out2] out/assets/minecraft/textures/number8/2.png -map [out3] out/assets/minecraft/textures/number8/3.png -map [out4] out/assets/minecraft/textures/number8/4.png -map [out5] out/assets/minecraft/textures/number8/5.png -map [out6] out/assets/minecraft/textures/number8/6.png -map [out7] out/assets/minecraft/textures/number8/7.png -map [out8] out/assets/minecraft/textures/number8/8.png
#"%cd%\ffmpeg.exe" -y -i out9.mp4 -filter_complex "[0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:0,tile=1x%frames%,select=not(mod(n\,20))[out1]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:0,tile=1x%frames%,select=not(mod(n\,20))[out2]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:0,tile=1x%frames%,select=not(mod(n\,20))[out3]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:0,tile=1x%frames%,select=not(mod(n\,20))[out4]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out5]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out6]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out7]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out8] " -map [out1] out/assets/minecraft/textures/number9/1.png -map [out2] out/assets/minecraft/textures/number9/2.png -map [out3] out/assets/minecraft/textures/number9/3.png -map [out4] out/assets/minecraft/textures/number9/4.png -map [out5] out/assets/minecraft/textures/number9/5.png -map [out6] out/assets/minecraft/textures/number9/6.png -map [out7] out/assets/minecraft/textures/number9/7.png -map [out8] out/assets/minecraft/textures/number9/8.png
#"%cd%\ffmpeg.exe" -y -i out10.mp4 -filter_complex "[0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:0,tile=1x%frames%,select=not(mod(n\,20))[out1]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:0,tile=1x%frames%,select=not(mod(n\,20))[out2]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:0,tile=1x%frames%,select=not(mod(n\,20))[out3]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:0,tile=1x%frames%,select=not(mod(n\,20))[out4]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out5]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out6]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out7]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out8] " -map [out1] out/assets/minecraft/textures/number10/1.png -map [out2] out/assets/minecraft/textures/number10/2.png -map [out3] out/assets/minecraft/textures/number10/3.png -map [out4] out/assets/minecraft/textures/number10/4.png -map [out5] out/assets/minecraft/textures/number10/5.png -map [out6] out/assets/minecraft/textures/number10/6.png -map [out7] out/assets/minecraft/textures/number10/7.png -map [out8] out/assets/minecraft/textures/number10/8.png
#"%cd%\ffmpeg.exe" -y -i out11.mp4 -filter_complex "[0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:0,tile=1x%frames%,select=not(mod(n\,20))[out1]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:0,tile=1x%frames%,select=not(mod(n\,20))[out2]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:0,tile=1x%frames%,select=not(mod(n\,20))[out3]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:0,tile=1x%frames%,select=not(mod(n\,20))[out4]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out5]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out6]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out7]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out8] " -map [out1] out/assets/minecraft/textures/number11/1.png -map [out2] out/assets/minecraft/textures/number11/2.png -map [out3] out/assets/minecraft/textures/number11/3.png -map [out4] out/assets/minecraft/textures/number11/4.png -map [out5] out/assets/minecraft/textures/number11/5.png -map [out6] out/assets/minecraft/textures/number11/6.png -map [out7] out/assets/minecraft/textures/number11/7.png -map [out8] out/assets/minecraft/textures/number11/8.png
#"%cd%\ffmpeg.exe" -y -i out12.mp4 -filter_complex "[0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:0,tile=1x%frames%,select=not(mod(n\,20))[out1]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:0,tile=1x%frames%,select=not(mod(n\,20))[out2]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:0,tile=1x%frames%,select=not(mod(n\,20))[out3]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:0,tile=1x%frames%,select=not(mod(n\,20))[out4]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out5]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out6]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out7]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out8] " -map [out1] out/assets/minecraft/textures/number12/1.png -map [out2] out/assets/minecraft/textures/number12/2.png -map [out3] out/assets/minecraft/textures/number12/3.png -map [out4] out/assets/minecraft/textures/number12/4.png -map [out5] out/assets/minecraft/textures/number12/5.png -map [out6] out/assets/minecraft/textures/number12/6.png -map [out7] out/assets/minecraft/textures/number12/7.png -map [out8] out/assets/minecraft/textures/number12/8.png
#"%cd%\ffmpeg.exe" -y -i out13.mp4 -filter_complex "[0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:0,tile=1x%frames%,select=not(mod(n\,20))[out1]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:0,tile=1x%frames%,select=not(mod(n\,20))[out2]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:0,tile=1x%frames%,select=not(mod(n\,20))[out3]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:0,tile=1x%frames%,select=not(mod(n\,20))[out4]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out5]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out6]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out7]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out8] " -map [out1] out/assets/minecraft/textures/number13/1.png -map [out2] out/assets/minecraft/textures/number13/2.png -map [out3] out/assets/minecraft/textures/number13/3.png -map [out4] out/assets/minecraft/textures/number13/4.png -map [out5] out/assets/minecraft/textures/number13/5.png -map [out6] out/assets/minecraft/textures/number13/6.png -map [out7] out/assets/minecraft/textures/number13/7.png -map [out8] out/assets/minecraft/textures/number13/8.png
#"%cd%\ffmpeg.exe" -y -i out14.mp4 -filter_complex "[0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:0,tile=1x%frames%,select=not(mod(n\,20))[out1]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:0,tile=1x%frames%,select=not(mod(n\,20))[out2]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:0,tile=1x%frames%,select=not(mod(n\,20))[out3]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:0,tile=1x%frames%,select=not(mod(n\,20))[out4]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out5]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out6]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out7]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out8] " -map [out1] out/assets/minecraft/textures/number14/1.png -map [out2] out/assets/minecraft/textures/number14/2.png -map [out3] out/assets/minecraft/textures/number14/3.png -map [out4] out/assets/minecraft/textures/number14/4.png -map [out5] out/assets/minecraft/textures/number14/5.png -map [out6] out/assets/minecraft/textures/number14/6.png -map [out7] out/assets/minecraft/textures/number14/7.png -map [out8] out/assets/minecraft/textures/number14/8.png
#"%cd%\ffmpeg.exe" -y -i out15.mp4 -filter_complex "[0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:0,tile=1x%frames%,select=not(mod(n\,20))[out1]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:0,tile=1x%frames%,select=not(mod(n\,20))[out2]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:0,tile=1x%frames%,select=not(mod(n\,20))[out3]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:0,tile=1x%frames%,select=not(mod(n\,20))[out4]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out5]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out6]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out7]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out8] " -map [out1] out/assets/minecraft/textures/number15/1.png -map [out2] out/assets/minecraft/textures/number15/2.png -map [out3] out/assets/minecraft/textures/number15/3.png -map [out4] out/assets/minecraft/textures/number15/4.png -map [out5] out/assets/minecraft/textures/number15/5.png -map [out6] out/assets/minecraft/textures/number15/6.png -map [out7] out/assets/minecraft/textures/number15/7.png -map [out8] out/assets/minecraft/textures/number15/8.png
#"%cd%\ffmpeg.exe" -y -i out16.mp4 -filter_complex "[0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:0,tile=1x%frames%,select=not(mod(n\,20))[out1]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:0,tile=1x%frames%,select=not(mod(n\,20))[out2]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:0,tile=1x%frames%,select=not(mod(n\,20))[out3]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:0,tile=1x%frames%,select=not(mod(n\,20))[out4]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:0:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out5]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/4:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out6]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/2:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out7]; [0:v]scale=iw/%W%:iw/%H%,crop=iw/4:ih/2:iw/1.33333333:ih/2,tile=1x%frames%,select=not(mod(n\,20))[out8] " -map [out1] out/assets/minecraft/textures/number16/1.png -map [out2] out/assets/minecraft/textures/number16/2.png -map [out3] out/assets/minecraft/textures/number16/3.png -map [out4] out/assets/minecraft/textures/number16/4.png -map [out5] out/assets/minecraft/textures/number16/5.png -map [out6] out/assets/minecraft/textures/number16/6.png -map [out7] out/assets/minecraft/textures/number16/7.png -map [out8] out/assets/minecraft/textures/number16/8.png
#"%cd%\ffmpeg.exe"\
for n in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
do
ffmpeg -y -i out$n.mp4 -filter_complex "[0:v]scale=iw/$W:iw/$H,crop=iw/4:ih/2:0:0,tile=1x$frames,select=not(mod(n\,20))[out1]; [0:v]scale=iw/$W:iw/$H,crop=iw/4:ih/2:iw/4:0,tile=1x$frames,select=not(mod(n\,20))[out2]; [0:v]scale=iw/$W:iw/$H,crop=iw/4:ih/2:iw/2:0,tile=1x$frames,select=not(mod(n\,20))[out3]; [0:v]scale=iw/$W:iw/$H,crop=iw/4:ih/2:iw/1.33333333:0,tile=1x$frames,select=not(mod(n\,20))[out4]; [0:v]scale=iw/$W:iw/$H,crop=iw/4:ih/2:0:ih/2,tile=1x$frames,select=not(mod(n\,20))[out5]; [0:v]scale=iw/$W:iw/$H,crop=iw/4:ih/2:iw/4:ih/2,tile=1x$frames,select=not(mod(n\,20))[out6]; [0:v]scale=iw/$W:iw/$H,crop=iw/4:ih/2:iw/2:ih/2,tile=1x$frames,select=not(mod(n\,20))[out7]; [0:v]scale=iw/$W:iw/$H,crop=iw/4:ih/2:iw/1.33333333:ih/2,tile=1x$frames,select=not(mod(n\,20))[out8] " -map "[out1]" out/assets/minecraft/textures/number$n/1.png -map "[out2]" out/assets/minecraft/textures/number$n/2.png -map "[out3]" out/assets/minecraft/textures/number$n/3.png -map "[out4]" out/assets/minecraft/textures/number$n/4.png -map "[out5]" out/assets/minecraft/textures/number$n/5.png -map "[out6]" out/assets/minecraft/textures/number$n/6.png -map "[out7]" out/assets/minecraft/textures/number$n/7.png -map "[out8]" out/assets/minecraft/textures/number$n/8.png
done

#endlocal

#ping google.com -n 3 > nul

#if exist "%cd%\out\assets\minecraft\textures\number1\8.png" (
#    goto continue
#) else (
#    goto retry
#)

#goto end

#:continue

#:end

#set zipdir="%cd%"
#set Name="VideoWorld"
name=VideoWorld
#xcopy "%cd%\HDTemplate" "%cd%\out\%Name%" /s/h/e/k/f/c/i
mkdir "out/$name"
cp -r HDTemplate/* "out/$name"
#xcopy "%cd%\out\assets" "%cd%\out\%Name%\resources\assets" /s/h/e/k/f/c/i
##mkdir "out/$name/resources"
cp -r out/assets "out/$name/resources"
#cd "%cd%\out\%Name%\resources"
#%zipdir%\7z.exe a -tzip resources.zip
cd out/$name/resources/
zip -r resources.zip .
cd ../../..
#cd..
#copy "%cd%\resources\resources.zip" "%cd%\resources.zip"
cp -r out/$name/resources/resources.zip out/$name/
#rmdir "%cd%\resources" /S /Q
rm -r out/$name/resources
#cd..
#cd..
#del "%cd%\input.mp4"
rm input.mp4
#del "%cd%\input-modded.mp4"
rm input-modded.mp4
#del "%cd%\rate.txt"
#del "%cd%\out1.mp4"
#del "%cd%\out2.mp4"
#del "%cd%\out3.mp4"
#del "%cd%\out4.mp4"
#del "%cd%\out5.mp4"
#del "%cd%\out6.mp4"
#del "%cd%\out7.mp4"
#del "%cd%\out8.mp4"
#del "%cd%\out9.mp4"
#del "%cd%\out10.mp4"
#del "%cd%\out11.mp4"
#del "%cd%\out12.mp4"
#del "%cd%\out13.mp4"
#del "%cd%\out14.mp4"
#del "%cd%\out15.mp4"
#del "%cd%\out16.mp4"
rm out*.mp4
#rmdir "%cd%\out\assets" /S /Q
rm -r out/assets
#cls
#echo Done!
echo done
#pause
