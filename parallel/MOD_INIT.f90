module MOD_INIT
    use mpi
    implicit none

contains

    subroutine do_SCC(Nat, L, r_xyz, nprocs, rank, fileout_scc)
        implicit none
        integer, intent(in) :: Nat, nprocs, rank
        real(8), intent(in) :: L
        real(8), dimension(:, :), intent(out) :: r_xyz
        character(len=*), intent(in) :: fileout_scc

        integer :: i, j, k, indx, atoms_per_proc, start_atom, end_atom, ierror
        real(8) :: a

        ! Calculate lattice parameter
        a = L / (Nat ** (1.0d0 / 3.0d0))

        ! Determine number of atoms per proc and assign start and end indices
        atoms_per_proc = Nat / nprocs
        start_atom = rank * atoms_per_proc + 1
        end_atom = start_atom + atoms_per_proc - 1
        if (rank == nprocs - 1) end_atom = Nat  ! Ensure last proc gets any extra atoms

        ! Calculate positions for this proc's atoms
        indx = 0
        do i = 1, nint(Nat ** (1.0d0 / 3.0d0))
            do j = 1, nint(Nat ** (1.0d0 / 3.0d0))
                do k = 1, nint(Nat ** (1.0d0 / 3.0d0))
                    indx = indx + 1
                    if (indx >= start_atom .and. indx <= end_atom) then
                        r_xyz(indx, :) = [(i - 1) * a, (j - 1) * a, (k - 1) * a]
                    end if
                end do
            end do
        end do

        ! Synchronize before writing to file
        call MPI_BARRIER(MPI_COMM_WORLD, ierror)

        if (rank == 0) then
            open(unit=21, file=fileout_scc, status='replace')
            write(21, *) Nat
            write(21, *) 'Initial SCC configuration'
            do i = 1, Nat
                write(21, "(a4,3f12.6)") 'Atom', r_xyz(i, 1), r_xyz(i, 2), r_xyz(i, 3)
            end do
            close(21)
        end if

    end subroutine do_SCC

     subroutine PBC(Nat,L,r_xyz)
           implicit none
           integer, intent(in) :: Nat
           real(16), intent(in) :: L
           real(16), dimension(Nat,3), intent(inout) :: r_xyz

           integer :: i, j

           do i=1,Nat
               do j=1,3
                  if (r_xyz(i,j)>L/2.d0) then
                          r_xyz(i,j) = r_xyz(i,j)-dble(L)
                  endif

                  if (r_xyz(i,j)<L/2.d0) then
                          r_xyz(i,j) = r_xyz(i,j)+dble(L)
                  endif
              enddo
          enddo
   end subroutine PBC


end module MOD_INIT

