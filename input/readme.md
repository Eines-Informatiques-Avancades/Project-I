# Input file 

It contains a file called parameter.h when the parameters of the simulation must be introduced.

**If not specified, all the units are in reduced units**

The number of unit cells that are simulated is choosed in the **nc** parameters, 

The density have units of (particles / reduced units of distances), take special care in avoid density greater than 0.6 .

The dimension parameters can't be changed in this version.

Can be generated three type of lattice: Simple cubic (=1), face cubic centered (=2), diamond (=3). Also it will be implemented a read from file subroutine in the next version.

Temperature is in kelvin units.

The initial velocities of the particles can be setted up to 0 or to a bimodal distribution. To choose use the **vel_opt** parameter (= 1, bimodal) (= 0, zero initial velocities).

To control de time step change the **dt** parameter (in ps units) less than 0.01 ps make in the simulation unstable. The number of steps that will be computed is selected in the **ntimes** parameter. 

The output information frequency is controlled by the **everyt** parameter. AVOID HIGH RATES OF PRINTIN!!! Printing is a limiting stage in this software.

The **rc** parameter represents the cut-off of the forces calculation, at higher cut-off better precision but higher times of calculation.

At last, you must choose the parameters for the force-field ([Lennard-Jones](https://es.wikipedia.org/wiki/Potencial_de_Lennard-Jones) type). **σ** is the distance to the zero potential point in hte potential and **ε** is the depth of the potential well.
