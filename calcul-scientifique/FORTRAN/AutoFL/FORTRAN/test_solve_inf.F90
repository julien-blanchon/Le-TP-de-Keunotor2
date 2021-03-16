program test_solve

  implicit none

  integer :: i, j, ierr, n
  double precision, dimension (:,:), allocatable :: L
  double precision, dimension (:), allocatable :: x, b
  ! TODO(Perso) : Add type of err and backward_error
  double precision :: err, backward_error

  write(*,*) 'n?'
  read(*,*) n

  ! Initialization: L is lower triangular
  write(*,*) 'Initialization...'
  write(*,*)
  
  allocate(L(n,n), stat=ierr)
  if(ierr.ne.0) then
    write(*,*)'Could not allocate L(n,n) with n=',n
    goto 999
  end if

  allocate(x(n), stat=ierr)
  if(ierr.ne.0) then
    write(*,*)'Could not allocate x(n) with n=',n
    goto 999
  end if

  allocate(b(n), stat=ierr)
  if(ierr.ne.0) then
    write(*,*)'Could not allocate b(n) with n=',n
    goto 999
  end if

  L = 0.D0
  do i = 1, n  
    L(i,i) = n + 1.D0
    do j = 1, i-1
      L(i,j) = 1.D0
    end do
  end do
  b = 1.D0

  ! Left-looking triangular solve of Lx=b
  write(*,*) 'Solving with a left-looking method...'

  ! TODO : call left_looking_solve
  call left_looking_solve(L, x, b, n)
  ! TODO : call backward_error to check the accuracy
  err = backward_error(L, x, b, n)
  write (*,*) '->backward_error = '
  write (*,*) '     ', err
  ! TODO : display the solution if n <= 10
  if (n<=10) then
    write (*,*) '-> Solution : '
    do j = 1, n
      write (*,*) '     ', x(j)
    end do
  end if

  ! Right-looking triangular solve of Lx=b
  write(*,*) 'Solving with a right-looking method...'

  ! TODO : call right_looking_solve
  call right_looking_solve(L, x, b, n)
  ! TODO : call backward_error to check the accuracy
  err = backward_error(L, x, b, n)
  write (*,*) '->backward_error = '
  write (*,*) '     ', err
  ! TODO : display the solution if n <= 10
  if (n<=10) then
    write (*,*) '-> Solution : '
    do j = 1, n
      write (*,*) '     ', x(j)
    end do
  end if

999 if(allocated(L)) deallocate(L)
    if(allocated(x)) deallocate(x)
    if(allocated(b)) deallocate(b)

end program test_solve

! TODO
! Implement sub-programs left_looking_solve, right_looking_solve, backward_error

!! PROCÉDURE left_looking_solve
! Effectue la résolution sans/avec report du système triangulaire Lx = b.
subroutine left_looking_solve(L, x, b, n)
  implicit none
  !!Entrées:
  double precision, dimension(n, n),  intent(in) :: L 
    !Matrice de taille n×n de nombres réels double précision.
  double precision, dimension(n),     intent(in) :: b
    !Second membre, vecteur de taille n de nombres réels double précision.
  integer,                            intent(in) :: n
    !Taille du système linéaire.
  !!Sortie:
  double precision, dimension(n),     intent(out) :: x
    !vecteur de taille n solution du système triangulaire Lx = b.
  !!Interne:
  integer :: i, j
  real :: start, finish
  !!Pré-conditions:
  ! L est initialisée et aucun terme de sa diagonale n’est nul.
  continue ! Pas de verif
  ! n > 0.
  if (n<=0) stop
  !!Code:
  call cpu_time(start)
  x = b
  do j = 1, n
    do i = 1, j-1
      x(j) = x(j) - L(j, i)*x(i)
    end do
    x(j) = x(j)/l(j, j)
  end do
  call cpu_time(finish)
  write (*,*) "Time = ", finish-start, " seconds."
  !!Post-conditions:
  ! x contient la solution de Lx = b.
  continue ! Pas de verif
end subroutine left_looking_solve

!! PROCÉDURE right_looking_solve
! Effectue la résolution sans/avec report du système triangulaire Lx = b.
subroutine right_looking_solve(L, x, b, n)
  implicit none
  !!Entrées:
  double precision, dimension(n, n),  intent(in) :: L 
    !Matrice de taille n×n de nombres réels double précision.
  double precision, dimension(n),     intent(in) :: b
    !Second membre, vecteur de taille n de nombres réels double précision.
  integer,                            intent(in) :: n
    !Taille du système linéaire.
  !!Sortie:
  double precision, dimension(n),     intent(out) :: x
    !solution calculée de Lx = b, vecteur de taille n de nombres réels double précision.
  !!Interne:
  integer :: i, j
  real :: start, finish
  !!Pré-conditions:
  ! L est initialisée et aucun terme de sa diagonale n’est nul.
  continue ! Pas de verif
  ! n > 0.
  if (n<=0) stop
  !!Code:
  call cpu_time(start)
  x = b
  do j = 1, n
    x(j) = x(j)/l(j, j)
    do i = j+1, n
      x(i) = x(i) - L(i, j)*x(j)
    end do
  end do
  call cpu_time(finish)
  write (*,*) "Time = ", finish-start, " seconds."
  !!Post-conditions:
  ! x contient la solution de Lx = b.
  continue ! Pas de verif
end subroutine right_looking_solve

function backward_error(L, x, b, n) result(err)
  implicit none
  !!Entrées:
  double precision, dimension(n, n),  intent(in) :: L
    !Matrice de taille n×n de nombres réels double précision.
  double precision, dimension(n),     intent(in) :: b
    !Second membre, vecteur de taille n de nombres réels double précision.
  integer,                            intent(in) :: n
    !Taille du système linéaire.
  double precision, dimension(n),     intent(in) :: x
    !solution calculée de Lx = b, vecteur de taille n de nombres réels double précision.
  !!Sortie:
  double precision :: err
  !!Pré-conditions:
  ! n > 0.
  if (n<=0) stop
  !!Code:
  err = NORM2(MATMUL(L, x) - b)/NORM2(b)
  !!Post-conditions:
  ! ø
end function backward_error

! Réponse question de compréhension:

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!! Faites des tests sur des matrices de tailles raisonnables (n≤20000) et expliquez les !!
!! différences de performance entre les deux algorithmes (insérez la réponse en fin du  !! 
!! fichier test_solve_inf.F90 sous forme de commentaires).                              !!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!                     Test de performance sur turing.enseeiht.fr                       !!
!! /proc/cpuinfo: Intel(R) Core(TM) i5-7500 CPU @ 3.40GHz                               !!
!! /proc/meminfo: MemTotal:       16356100 kB                                           !!
!! n=?      |   left_looking_solve time   |   right_looking_solve time                  !!
!! n=1      |   4.00003046E-06  sec       |   3.99991404E-06 sec                        !!
!! n=10     |   4.00003046E-06  sec       |   2.00001523E-06 sec                        !!
!! n=100    |   2.09999271E-05  sec       |   1.69998966E-05 sec                        !!
!! n=1000   |   8.49999487E-04  sec       |   4.62000258E-04 sec                        !!
!! n=10000  |   0.373079002     sec       |   3.92659903E-02 sec                        !!
!! n=20000  |   1.91677904      sec       |   0.159955978    sec                        !!
!!                     Interprétation des résultats                                     !!
!! La différence de performance entre les deux algorithmes s'explique par le fait que en!!
!! Fortran les matrice matrice (*dimension*) sont stocker en colonnes et non pas en     !!
!! ligne ainsi il est beaucoup plus efficasse de parcourir les matrice dans le sens des !!
!! colonnes (*right_looking_solve*) que dans le sens les lignes (*left_looking_solve*). !!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!