
	!	Initialization parameters
	!---------------------------
	integer::nc=6 !Number of particles per side
	double precision::density=0.5d0 !Lomgitude of the size box

	integer::structure=1 !For SC:1, for fcc:2, for diamond 3.

	double precision::temp= 300.0d0  !Temperature (K)
	integer::vel_opt=1 ! if 1, implemented bimodal. Else, set up to 0

	!Simulation set up
	!-----------------
	integer::ntimes=100000 !Steps of the simulation
	integer::everyt=100 ! Multiple of steps at which the thermodynamic properties
	! are saved
	integer::tmelt=10000 ! Time step at which melting is from initial structure is done
	! and rdf can be computed
	double precision:: dt= 0.001 !Time step (ps)

	integer::thermo=1 !For no thermostat:0, for active thermostat:1
	! Random seed
	!----------------
	integer::rng_seed=666
	!Force parameters
	!----------------
	double precision::rc= 0.05d0 !Cut-off

	!Lennard-Jones parameters
	!----------------
	double precision:: epsilon = 10.22, sigma = 2.556
