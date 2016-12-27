#!/usr/bin/gnuplot

#set term x11
bind Close "exit gnuplot"

set multiplot layout 2,2 

###
plot "out1.txt" u 1:2 with lines,\
     "out2.txt" u 1:2 with points,\
     "out1.txt" u 1:3 with lines

###
plot "out1.txt" u 1:6 with lines,\
     "out1.txt" u 1:4 with lines

###
plot "out1.txt" u 1:(-$2) with lines,\
     "out1.txt" u 1:5 with lines

unset multiplot

pause -1 