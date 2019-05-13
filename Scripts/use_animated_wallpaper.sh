#!/bin/bash

killall xwinwrap 
killall gifview
exec xwinwrap -g $1x$2+0+"$(($4-$2))" -ov -ni -s -nf -- gifview -w WID $5 -a &
exec xwinwrap -g $3x$4+$1+0 -ov -ni -s -nf -- gifview -w WID $5 -a
