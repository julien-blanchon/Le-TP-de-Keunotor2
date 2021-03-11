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

