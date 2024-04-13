! main program
program main
    ! using the provided modules
    use initialize
    use forces
    use integrate
    use thermodynamics

    ! variable declaration
    implicit none
    integer,parameter :: d=3!, N=125,nsim_temp=1000,nsim_tot=1000,numdr=1000
    integer :: N,nsim_temp,nsim_tot,numdr
    integer :: M,i,j
    ! real(8) :: density,L,a,pos(N,d),vel(N,d),dt,cutoff,temp1,temp2,nu,sigma,temperatura,ke,pot
    real(8) :: density,L,a,dt,cutoff,temp1,temp2,nu,sigma,temperatura,ke,pot
    ! real(8) :: timeini,timefin,pos0(N,d),msdval,rdf(numdr),r,deltar,volumdr,pi,press
    real(8) :: timeini,timefin,msdval,r,deltar,volumdr,pi,press
    real(8), allocatable :: pos(:,:), vel(:,:), pos0(:,:), rdf(:)
    character(15) :: dummy
    
    ! Read parameters
    read(*,*) dummy, N
    read(*,*) dummy, nsim_temp
    read(*,*) dummy, nsim_tot
    read(*,*) dummy, numdr
    read(*,*) dummy, dt
    read(*,*) dummy, cutoff
    read(*,*) dummy, density
    read(*,*) dummy, temp1
    read(*,*) dummy, temp2
    read(*,*) dummy, nu

    pi=4d0*datan(1d0)
    ! Allocate variables
    allocate(pos(N,d))
    allocate(vel(N,d))
    allocate(pos0(N,d))
    allocate(rdf(numdr))

    ! opening files to save results
    open(14,file='trajectory.xyz',position='append')
    open(15,file='thermodynamics.dat')
    open(16,file='resultsrdflong_def.dat')


    ! getting the initial time to account for total simulation time
    call cpu_time(timeini)
    write(*,*)timeini
    
    call srand(1)

    
    ! Initialize system
    L=(dble(N)/density)**(1.d0/3.d0)
    M=int(N**(1.d0/3.d0))+1
    a=L/dble(M)

    print *, L, cutoff, M, a
    
    call ini_pos_sc(N,a,M,d,pos)
    
    !Thermalization
    sigma = sqrt(temp1)
    do i=1,nsim_temp
        call time_step_vVerlet(pos,N,d,L,vel,dt,cutoff,nu,sigma,pot)
        ! Write trajectory in file "trajectory.xyz"
        write(14,'(I5)')N
        write(14, *) 
        do j = 1, 125
                write(14, '(A, 3F12.6)')'A', pos(j, 1), pos(j, 2), pos(j, 3)
        end do
    enddo
    print *, "Finished Thermalization"    


    !Starting production run
    sigma=sqrt(temp2)
    !vel=0.d0
    pos0=pos
    rdf=0d0

    do i=1,nsim_tot
        call time_step_vVerlet(pos,N,d,L,vel,dt,cutoff,nu,sigma,pot)
        if (mod(i,100).eq.0) then
            ! Mesures
            call kin_energy(vel,N,d,ke)
            call msd(pos,N,d,pos0,L,msdval)
            call pression(pos,N,d,L,cutoff,press)
            temperatura=temp_inst(ke,N)
            write(15,*)i*dt,ke,pot,pot+ke,temperatura,msdval,press+temperatura*density
            if (mod(i,50000).eq.0) then ! Control state of simulation
                print*,i
            endif


            if (i.gt.1e3) then
                ! g(r) mesures
                call gr(pos,N,d,numdr,L,rdf)
            endif
        endif
    enddo
    
    !Normalització g(r)
    r=0d0
    deltar=1.5d0*L/numdr
    do i=1,numdr
        r=(2*i-1)*deltar
        volumdr=4d0*pi*((r+deltar/2d0)**3-(r-deltar/2d0)**3)/3d0
        write(16,*)r,rdf(i)/(sum(rdf)*volumdr*density)
    enddo
    
    call cpu_time(timefin)
    print*,'FINAL time = ',timefin-timeini

    
    end program main
    
