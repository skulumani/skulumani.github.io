---
layout: post
title: "Security cameras and video"
date: 2021-12-15
tags: [linux]
excerpt: "Using security cameras to do more than record"
published: true
---

We have a couple of security cameras mounted on our home.
These are inexpensive [Reolink POE](https://smile.amazon.com/dp/B07HFQ4LH1?ref=nb_sb_ss_w_as-ypp-rep_ypp_rep_k0_1_8&crid=28A6AS5LHULFA&sprefix=reolink+) cameras which are connected via ethernet to our network.
Hardwired cameras such as these are vastly superior to wireless cameras and since I've set up the [network to isolate]({% post_url 2020-12-17-mikrotik-vlan %}) these devices they are much safer than typical cloud connected cameras.

# Continual recording

One basic function of security cameras are to provide a continual video history of events.
There are many applications one can run to do this, such as:

* [Blue Iris](https://blueirissoftware.com/)
* [Motioneye](https://github.com/ccrisan/motioneye)
* [Zoneminder](https://zoneminder.com/)
* [Shinobi](https://shinobi.video/)

For my case, I wanted something much simpler and instead use [ffmpeg](https://ffmpeg.org/) directly to record video. 
A simple bash script is called using cron:

~~~
#!/bin/sh
# record_lq.sh
# Record ip cam in segments

STARTTIME=$(date +"%Y%m%dT%H%M%S")

## IP Camera Names ##
FRONT_CAM="${STARTTIME}_FRONT"
BACK_CAM="${STARTTIME}_BACK"

CAM_USERNAME="<camera username>"
CAM_PASSWORD="<camera password>"

FRONT_IP="<camera IP>"

## Network and Local Storage Locations  ##
# Pay attending to when a trailing '/' is used and when it is not
## Network and Local Storage Locations  ##
HQDIR="<path>/<to>/<save>/<hq>" #Trailing '/' is necessary here
LQDIR="<path>/<to>/<save>/<lq>"

## Record Time per File ##
LQLENGTH="3600" # (Runtime expressed in seconds)

## Record Settings ##
#
# -v 0    // Log level = 0
# -i      // Input url
# -vcidec // Set the video codec. This is an alias for "-codec:v".
# -an     // Disable audio recording
# -t      // Stop writing the output after its duration reaches duration
#
# ffmpeg -v 0 -rtsp_transport tcp -i "rtsp://${CAM_USERNAME}:${CAM_PASSWORD}@${FRONT_IP}:554/h264Preview_01_sub" -vcodec copy -acodec copy -t ${LQLENGTH} ${LQDIR}${FRONT_CAM}.mp4 &
# ffmpeg -v 0 -rtsp_transport tcp -i "rtsp://${CAM_USERNAME}:${CAM_PASSWORD}@${BACK_IP}:554/h264Preview_01_sub" -vcodec copy -acodec copy -t ${LQLENGTH} ${LQDIR}${BACK_CAM}.mp4 &

ffmpeg -i "rtmp://${CAM_USERNAME}:${CAM_PASSWORD}@${FRONT_IP}/bcs/channel0_sub.bcs?token=dsfde&channel=0&stream=0&user=${CAM_USERNAME}&password=${CAM_PASSWORD}" -vcodec copy -acodec copy -t ${LQLENGTH} ${LQDIR}${FRONT_CAM}.mp4 &
ffmpeg -i "rtmp://${CAM_USERNAME}:${CAM_PASSWORD}@${BACK_IP}/bcs/channel0_sub.bcs?token=dfwa&channel=0&stream=0&user=${CAM_USERNAME}&password=${CAM_PASSWORD}" -vcodec copy -acodec copy -t ${LQLENGTH} ${LQDIR}${BACK_CAM}.mp4 &

~~~

The script above is called every ``LQLENGTH`` seconds and it simply uses ``fmpeg`` to capture the network stream and save to a file.
Each camera will have a slightly different url but some searching online will find the appropriate value.
An example cron task is below, which will call the script every 1 hour = 3600 seconds.

~~~
0 */1 * * *  bash /<path>/<to>/record_lq.sh
~~~

Eventually you'll want to delete old videos and the following will do exactly that.

~~~
#!/bin/sh
# record_delete.sh
# Record ip cam in segments

LQDIR="<path>/<to>/<lq>" # Do not include tail '/' (bash 'find' command will not execute property)
HQDIR="<path>/<to>/<hq>" # Do not include tail '/'

## Delete LQ files : -mtime X is files strictly greater than X days old
find ${LQDIR} -maxdepth 1 -type f -mtime +30 -exec rm {} \;
## Delete HQ files
find ${HQDIR} -maxdepth 1 -type f -mtime +0 -exec rm {} \;
~~~

In my case I'm able to store 30 days of low quality video on an old external 320GB USB harddrive with plenty of leftover space.
This approach has already proven useful/interesting and lets me capture all sorts of [interesting events](https://youtu.be/CAmgU-Dvffc).

# Image classification

It's all good to simply record video, but everyone knows machine learning should be applied to every possible problem.
In my case, I'm using [homeassistant](https://www.home-assistant.io/) and [frigate](https://docs.frigate.video/) to perform image classification on the live video.
Frigate uses a hardware TPU to run an image classifier on the live video, then report/record the findings.
Combined with homeassistant I can then easily setup actions/notifications using this.

For example, an automation to send a notification using Signal anytime a person is detected when no one is home:

{% raw %}
~~~
- id: frigate_signal 
  alias: Frigate Signal notification
  trigger:
    - platform: mqtt
      topic: "frigate/events"
  condition:
  - condition: and
    conditions:
    - condition: state
      entity_id: "binary_sensor.shankar_presence"
      state: 'off'
    - condition: state
      entity_id: "binary_sensor.christine_presence"
      state: 'off'
  action:
    - delay: "00:00:45"
    - service: notify.signal_group
      data_template:
        message: "{{ now().strftime('%Y-%m-%dT%H:%M:%S') }} - {{trigger.payload_json['after']['label']}} detected by {{trigger.payload_json['after']['camera']}} camera."
        data:
          attachments:
            - "/media/frigate/clips/{{trigger.payload_json['after']['camera']}}-{{trigger.payload_json['after']['id']}}.jpg"
~~~
{% endraw %}

Or simply to detect when our cat is outside

| Cat 1  | Cat 2 |
| ------------- | ------------- |
| ![lily](/assets/security_cameras/lily.png) | ![princess](/assets/security_cameras/princess.png) |

# Timelapse

Finally, the security cameras are used to capture an image at regular intervals, then these images are automatically combined using ffmpeg into videos. 
Currently I'm doing the following which seems like a good approach to capture long term changes in our garden

1. Capture 1 frame every 10 minutes - combine into a video at end of the day
2. Combine 1 month of daily videos into a monthly video and upload to youtube for easy viewing
3. Capture 1 frame every day at noon and eventually create a very long duration timelapse

To capture a frame, ``ffmpeg`` again comes to the rescue with suitable schedule in cron

~~~

#!/bin/sh
# record_lq.sh
# Record ip cam in segments

STARTTIME=$(date +"%Y%m%dT%H%M")

## IP Camera Names ##
FRONT_CAM="${STARTTIME}_FRONT"
BACK_CAM="${STARTTIME}_BACK"

CAM_USERNAME="<cam username>"
CAM_PASSWORD="<cam password>"

FRONT_IP="192.168.200.15"
BACK_IP="192.168.200.16"

## Network and Local Storage Locations  ##
# Pay attending to when a trailing '/' is used and when it is not
## Network and Local Storage Locations  ##
IMAGE_DIR="/<path>/<to>/<images>"
if [[ ! -e ${IMAGE_DIR} ]]; then
    mkdir -p ${IMAGE_DIR}
fi

ffmpeg -i "rtmp://${CAM_USERNAME}:${CAM_PASSWORD}@${FRONT_IP}/bcs/channel0_main.bcs?token=ssdad&channel=0&stream=0&user=${CAM_USERNAME}&password=${CAM_PASSWORD}" -t 1 -r 1 ${IMAGE_DIR}${FRONT_CAM}.jpg &
ffmpeg -i "rtmp://${CAM_USERNAME}:${CAM_PASSWORD}@${BACK_IP}/bcs/channel0_main.bcs?token=sdasdasd&channel=0&stream=0&user=${CAM_USERNAME}&password=${CAM_PASSWORD}" -t 1 -r 1 ${IMAGE_DIR}${BACK_CAM}.jpg &

~~~
The ffmpeg command simply captures a single frame and saves it as an image. 
You can call this as often as desired/space allows using cron.

Once you have sufficient images, you can again use ffmpeg to combine them into a video

~~~

#!/bin/sh
# Create timelapse from the previous day

YESTERDAY=$(date -d "yesterday" +"%Y%m%d")

IMAGE_DIR="<path>/<to>/<images>"

# convert to video
# -r 30 - framerate of output video - compute as function of length
# get date using $(date -d "last month" +"%Y%m%d") or equivalent

# ffmpeg -r 30 -pattern_type glob -i 20211010T*.jpg -vcodec libx264 -crf 18 -pix_fmt yuv420p timelapse.mp4
# libx265 - seems to fail for signal attachments
ffmpeg -r 30 -pattern_type glob -i "${IMAGE_DIR}${YESTERDAY}*_FRONT.jpg" -vcodec libx264 -crf 28 -preset veryslow -pix_fmt yuv420p ${IMAGE_DIR}${YESTERDAY}_FRONT.mp4
ffmpeg -r 30 -pattern_type glob -i "${IMAGE_DIR}${YESTERDAY}*_BACK.jpg" -vcodec libx264 -crf 28 -preset veryslow -pix_fmt yuv420p ${IMAGE_DIR}${YESTERDAY}_BACK.mp4

# delete images used 
# rm "${IMAGE_DIR}${YESTERDAY}*.jpg"
find ${IMAGE_DIR} -maxdepth 1 -type f -name "${YESTERDAY}*.jpg" -exec rm {} +
~~~

Also, every month I combine the daily videos into a larger monthly video using the following:

~~~
#!/bin/sh
# Create timelapse from the previous month

LAST_MONTH=$(date -d "last month" +"%Y%m")
THIS_MONTH=$(date -d "this month" +"%Y%m")

IMAGE_DIR="<path>/<to>/<videos>"

FRONT_FILES="${IMAGE_DIR}front.txt"
BACK_FILES="${IMAGE_DIR}back.txt"

FRONT_VIDEO="${IMAGE_DIR}/monthly/${LAST_MONTH}_FRONT.mp4"
BACK_VIDEO="${IMAGE_DIR}/monthly/${LAST_MONTH}_BACK.mp4"

for filename in "${IMAGE_DIR}${LAST_MONTH}"*_FRONT.mp4; do
    [ -e "$filename" ] || continue
    echo "file '${filename}'" >> ${FRONT_FILES}
done

for filename in "${IMAGE_DIR}${LAST_MONTH}"*_BACK.mp4; do
    [ -e "$filename" ] || continue
    echo "file '${filename}'" >> ${BACK_FILES}
done

# concat mp4s
ffmpeg -hide_banner -r 30 -f concat -safe 0 -i ${FRONT_FILES} -vcodec libx264 -crf 28 -preset veryslow -pix_fmt yuv420p ${FRONT_VIDEO}
ffmpeg -hide_banner -r 30 -f concat -safe 0 -i ${BACK_FILES} -vcodec libx264 -crf 28 -preset veryslow -pix_fmt yuv420p ${BACK_VIDEO}

# delete mp4s
find ${IMAGE_DIR} -maxdepth 1 -type f -name "${LAST_MONTH}*.mp4" -exec rm {} +

# Delete file list documents
rm ${FRONT_FILES}
rm ${BACK_FILES}

# Upload to youtube
conda activate timelapse

youtube-upload \
    --title="${LAST_MONTH}_FRONT" \
    --description="Timelapse video" \
    --client-secrets="client_secrets.json" \
    --playlist="Timelapse Front" \
    --privacy="private" \
    ${FRONT_VIDEO}

youtube-upload \
    --title="${LAST_MONTH}_BACK" \
    --description="Timelapse video" \
    --client-secrets="client_secrets.json" \
    --playlist="Timelapse Back" \
    --privacy="private" \
    ${BACK_VIDEO} 
~~~

The final step is to [upload to youtube](https://github.com/tokland/youtube-upload/).
Long duration timelapse such as this is a long term project so hopefully given enough time this system will capture something interesting for us.
You can find this timelapse code on [Github](https://github.com/skulumani/timelapse).
