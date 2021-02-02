---
layout: post
title: "ffmpeg video from images"
date: 2021-02-02
tags: [linux]
excerpt: "Using ffmpeg to create videos from images"
published: true
---

One frequent taks that comes up is to combine a sequence of images into a video. 
Like most things dealing with video, [`ffmpeg`](https://ffmpeg.org/) is one good solution.

Here is a single line command which takes a number of images and combines them into a video.

~~~
ffmpeg -framerate 24 -pattern_type glob -i './corrected/*.jpg' -c:v libx264 -r 30 -pix_fmt yuv420p corrected.mp4
~~~

An additional ability is it add an overlay to the images prior to combining them into a video. 
For example, one might want to add a timestamp onto the images.
Here we read images with names `*_ms.jpg` then add a portion of the filename (timestamp) to the image. 

~~~
for infile in *_ms.jpg; do 
    overlay=$(echo ${infile} | cut -d . -f 1)
    outfile="./corrected/mod_${overlay}.jpg"

    echo "Input File: $infile Output File: $outfile"
    ffmpeg -i ${infile} -vf "drawtext=text=${infile}: x=5: y=5: fontsize=24: fontcolor=yellow@0.9" ${outfile}
done
~~~

A bash script that does this is available on [Github](https://gist.github.com/skulumani/9ffd788062644abc539cf934e9b538c3).
