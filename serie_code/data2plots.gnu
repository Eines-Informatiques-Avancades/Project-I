# gnuplot script for plotting E, U, and Kin as a function of iteration
set term png

##### ENERGY VS TIME #####
set output 'Esvst.png'

set autoscale
set xlabel "Time (simulation)"
set ylabel "Energy"
set title "Energy components evolution during simulation"
#set yr [-750:350]
set key vertical
set key outside

# Set line types and colors
set linetype 1 lc rgb "red" ps 1
set linetype 2 lc rgb "blue" lw 0.5
set linetype 3 lc rgb "dark-green" lw 1

# Plotting
set size ratio 1/10
plot 'thermodynamics.dat' u 1:2 t 'Ekin' with lp lt 2 ps 1, \
'thermodynamics.dat' u 1:4 t 'Etot' with lp lt 3 ps 1, \
'thermodynamics.dat' u 1:3 t 'ULJ' with points lt 1 ps 1 

replot
unset output

##### TOTAL ENERGY OSCILATIONS #####
set output 'Evst_osc.png'

set autoscale
set xlabel "Time (simulation)"
set ylabel "Energy"
set title "Total energy oscilation during simulation"

set linetype 4 lc rgb "dark-orange" 
plot 'thermodynamics.dat' u 1:4 t 'Etot' with lp lt 4 ps 0.5, \

rep
unset output

##### TEMPERATURE VS TIME #####
set output 'Tvst.png'

set autoscale
set xlabel "Time (simulation)"
set ylabel "Temperature"
set title "Instant T evolution during simulation"
#set yr [0:2]

set linetype 5 lc rgb "dark-cyan"
plot 'thermodynamics.dat' u 1:5 t 'Tinst' with lp lt 5 ps 0.5, \

rep
unset output

##### PRESSURE VS TIME #####
set output 'Pvst.png'

set autoscale
set xlabel "Time (simulation)"
set ylabel "Pressure"
set title "Pressure evolution during simulation"
#set xr [0:200]
#set yr [0:10]

set linetype 6 lc rgb "gold"
plot 'thermodynamics.dat' u 1:7 t 'Pressure' with lp lt 7 ps 0.5, \

rep
unset output

##### PRESSURE VS TEMPERATURE #####
set output 'PvsT.png'

set autoscale
set xlabel "Temperature"
set ylabel "Pressure"
set title "Press. vs Temp. in reduced units"
#set xr [0:200]
#set yr [0:10]

set linetype 7 lc rgb "violet" lw 1 dashtype 1 
plot 'thermodynamics.dat' u 5:7 t 'P=f(T)' with lp lt 7 ps 0.5, \

rep
unset output

##### RADIAL DISTRIBUTION FUNCTION / PAIR DISTRIBUTION FUNCTION #####
set output 'RDF.png'

set autoscale
set title 'RDF for two fixed particles in a LJ fluid'
set xlabel 'Radius'
set ylabel'RDF'

set linetype 8 lc rgb "dark-blue" lw 1 pt 7 dt 2

plot 'resultsrdflong_def.dat' u 1:2 t'RDF' with lp lt 8 ps 0.5

rep
pause 5
unset output
