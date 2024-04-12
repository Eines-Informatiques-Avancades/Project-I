program EIA_MD
    use mpi
    use MOD_INIT
    implicit none

    ! MPI-related variables
    integer :: ierror, rank, nprocs
    integer, dimension(:), allocatable :: seeds

    ! MD-related variables
    integer :: Nat
    real(8) :: rho, L
    real(8), dimension(:,:), allocatable :: r_xyz   ! Atomic positions array
    integer :: i
    character(len=*), parameter :: fileout_scc = 'SCCconf_init.xyz'

    ! Variables introduced to test functionality
    Nat = 125
    rho = 0.1d0

    ! Initialize MPI
    call MPI_INIT(ierror)
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierror)
    call MPI_COMM_SIZE(MPI_COMM_WORLD, nprocs, ierror)

    ! Allocate and generate unique seeds for random number generator
    allocate(seeds(nprocs))
    if (rank == 0) then
        seeds(1) = 101
        do i = 2, nprocs
            seeds(i) = seeds(i-1) * 5
        end do
    end if
    call MPI_BCAST(seeds, nprocs, MPI_INTEGER, 0, MPI_COMM_WORLD, ierror)
    call random_seed(put=seeds(rank+1:rank+1))  ! Corrected to seed each process uniquely

    ! Calculate L based on rho and Nat
    L = (Nat / rho) ** (1.0d0 / 3.0d0)

    ! Allocate array for atomic positions
    allocate(r_xyz(Nat, 3))

    ! Call the subroutine to initialize atoms in a simple cubic configuration
    call do_SCC(Nat, L, r_xyz, nprocs, rank, fileout_scc)

    ! Finalize MPI
    call MPI_FINALIZE(ierror)

end program EIA_MD

