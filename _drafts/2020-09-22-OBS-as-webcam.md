---
title: Use OBS as webcam on Arch Linux
---

For anyone looking to set up a virtual OBS webcam in Arch Linux, here's how I did it:

1. Install headers for your Linux kernel and [`v4l2loopback`](https://github.com/umlaeute/v4l2loopback).

	```sh
	sudo pacman -S linux56-headers v4l2loopback-dkms
	```

1. Create a virtual video capture device:

	```sh
	sudo modprobe v4l2loopback devices=1 video_nr=10 card_label="OBS Cam" exclusive_caps=1
	```

	```sh
	v4l2-ctl --list-devices
	OBS Cam (platform:v4l2loopback-000):
		/dev/video10
	```

1. Set up a virtual audio device to avoid latency (Optional):

	```sh
	sudo modprobe snd-aloop index=10 id="OBS Mic"
	pacmd 'update-source-proplist alsa_input.platform-snd_aloop.0.analog-stereo device.description="OBS Mic"'
	```

1. Run `ffmpeg`. Expose the previously created virtual video device on an HTTP server:

	```sh
	ffmpeg -an -probesize 32 -analyzeduration 0 -listen 1 -i rtmp://127.0.0.1:1935/live/cam -f v4l2 -vcodec rawvideo /dev/video10
	```

1. Setup OBS to stream to `ffmpeg`'s server':

	`File` > `Settings` > `Stream`, set Service to `Custom...` and `Server` to `rtmp://127.0.0.1:1935/live/cam`.

1. Setup low latency streaming:

	`File` > `Settings` > `Output` > `Output Mode`: `Advanced`, set `Buffer Size` to `0`, `CPU Usage Preset` to `ultrafast` and `Tune` to `zerolatency`.

1. Start Streaming in OBS.

1. Select your virtual camera and audio devices in Google Meet / Zoom / etc.
