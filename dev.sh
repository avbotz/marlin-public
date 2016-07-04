#!/bin/bash

trap "exit" INT TERM
trap "echo caught exit signal; kill 0" EXIT

stty -F /dev/ttyUSB0 raw
stty -F /dev/ttyUSB0 speed 9600
stty -F /dev/ttyUSB0 -echo -echoe -echok

cat /dev/ttyUSB0    | tee pipe/control_out >> logs/control_out &
cat pipe/control_in | tee /dev/ttyUSB0     >> logs/control_in  &

bin/camera i 0 1 < pipe/camera_f_in | tee pipe/camera_f_out | bin/image_log logs/ _f &

cat
