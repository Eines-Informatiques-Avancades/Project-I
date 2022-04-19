
# Output
This directory contains all the output files. 

### Possible files

Containing the initial structure:

  * **init_conf_sc.xyz**: The initial simple cubic structure is stored.
  * **init_conf_fcc.xyz**: The initial face centered cubic structure is stored.
  * **init_conf_diamond.xyz**: The initial diamond structure is stored.

Containing the thermodynamics parameters:

  * **temp.dat**: Contains the temperatures of the temperature for some time-steps.
  * **energy.dat**: Contains the energy of the temperature for some time-steps
  * **pressure.dat**: Contains the pressure of the temperature for some time-steps
  * **rdf.dat**: Contains data of the radial distribution function.
  * **trajectory.xyz**: It contains the trajectory of the system time evolution every given number of time steps specified in the input in a xyz format, intended to be rendered using VMD software.

The plots:
 * **ene-allplot.png**: Evolution of the kinetic, potential and total energy.
 * **ene-kinplot.png**: Evolution of the kinetic energy.
 * **ene-potplot.png**: Evolution of the potential energy.
 * **ene-totplot.png**: Evolution of the tiotal energy.
 * **presseplot.png**: Evolution of the pressure.
 * **rdfplot.png**:  Radial distribution function.
 * **tempplot.png**: Evolution of the temperature. 

This directory also contains a folder with the plots of an example consisting of the MD simulation of and Helium gas at 300 K.
