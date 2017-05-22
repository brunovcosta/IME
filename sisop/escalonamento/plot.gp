set title "Escalonamento do CPU"
unset border
unset key
set ytics nomirror 1
set grid x y
set key left bottom Left title 'Legend' box 3

plot "out" using ($1):($2) title "CPU" with points pointsize 1 pointtype 5 lc rgb "blue",\
"out" using ($1):($3) title "E/S" with points pointsize 1 pointtype 5 lc rgb "green"
