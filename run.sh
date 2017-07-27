#!/bin/bash -ex

CAMERA_DEVICE=/dev/video0
FRAME_RATE=10
VIDEO_SIZE=1280x720
VIDEO_FILE=/tmp/myvideo0

ffmpeg -f v4l2 -framerate ${FRAME_RATE} -video_size ${VIDEO_SIZE} -pix_fmt yuyv422 -i /dev/video0 \
  -c:v libx264 -preset veryfast -tune zerolatency -pix_fmt yuv420p \
  -x264opts crf=20:vbv-maxrate=3000:vbv-bufsize=100:intra-refresh=1:slice-max-size=1500:keyint=1:ref=1 \
  -f mpegts - | nc -l -p 9000
