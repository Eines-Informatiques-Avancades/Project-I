# Gnuplot script for plotting E, U, and Kin as a function of iteration
set term png

## Constants
uma = 1.66053906660e-27 # kg
kb = 1.380649e-23 # J/K
sig = 3.6274e-10 # m
dens_ = 0.0012 # adim
mKr = 83.798*uma # kg
e_kb = 162.58 # K*J/K=K
t_coef = 1/(sqrt((e_kb*kb)/(mKr*sig**2))) *1e12 #ps
dens = dens_*mKr / sig**3 # g/L 

##### ENERGY VS TIME #####
set output 'Esvst_SI.png'

set autoscale
set xlabel "Time (ps)"
set ylabel "Energy (J)"
set title "Energy components evolution during simulation"
set key vertical
set key outside

# Set line types and colors
set linetype 1 lc rgb "red" ps 1
set linetype 2 lc rgb "blue" lw 0.5
set linetype 3 lc rgb "dark-green" lw 1

# Plotting
set size ratio 1/10
plot 'thermodynamics.dat' u ($1*t_coef):($2*e_kb) t 'Ekin' with lp lt 2 ps 1, \
     'thermodynamics.dat' u ($1*t_coef):($4*e_kb) t 'Etot' with lp lt 3 ps 1, \
     'thermodynamics.dat' u ($1*t_coef):($3*e_kb) t 'ULJ' with points lt 1 ps 1

unset output
##### TOTAL ENERGY OSCILATIONS #####
set output 'Evst_osc_SI.png'

set autoscale
set xlabel "Time (ps)"
set ylabel "Energy (J)"
set title "Total energy oscilation during simulation"

set linetype 4 lc rgb "dark-orange"
plot 'thermodynamics.dat' u ($1*t_coef):($4*e_kb) t 'Etot' with lp lt 4 ps 0.5, \

rep
unset output

##### TEMPERATURE VS TIME #####
set output 'Tvst_SI.png'

set autoscale
set xlabel "Time (ps)"
set ylabel "Temperature (K)"
set title "Instant T evolution during simulation"
#set yr [0:2]

set linetype 5 lc rgb "dark-cyan"
plot 'thermodynamics.dat' u ($1*t_coef):($5*e_kb) t 'Tinst' with lp lt 5 ps 0.5, \

rep
unset output

##### PRESSURE VS TIME #####
set output 'Pvst_SI.png'

set autoscale
set xlabel "Time (ps)"
set ylabel "Pressure (Pa)"
set title "Pressure evolution during simulation"
#set xr [0:200]
#set yr [0:10]

set linetype 6 lc rgb "gold"
plot 'thermodynamics.dat' u ($1*t_coef):(kb*e_kb*$7/sig**3) t 'Pressure (Pa)' with lp lt 7 ps 0.5, \

rep
unset output

##### PRESSURE VS TEMPERATURE #####
set output 'PvsT_SI.png'

set autoscale
set xlabel "Temperature (K)"
set ylabel "Pressure (Pa)"
set title "Press. vs Temp. "
#set xr [0:200]
#set yr [0:10]

set linetype 7 lc rgb "violet" lw 1 dashtype 1
plot 'thermodynamics.dat' u ($5*e_kb):($7*kb*e_kb/sig**3) t 'P=f(T)' with lp lt 7 ps 0.5, \

rep
pause 5
unset output
