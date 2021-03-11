program test_horner
    implicit none
    !! Programme
    !Degre du polynome
    integer :: n
    !Coef du polynome
    real, allocatable, dimension(:) :: coef
    !Point
    real :: x
    !! Autre
    integer :: i 
    real :: p
    real :: horner

    !Lecture n
    n = -1
    do while (n<0)
        write(*,*) 'Entrez le degré du polynôme'
        read(*,*) n
    end do

    !Lecture coef
    allocate(coef(n+1))
    if (.not.allocated(coef)) stop
    do i = 1, n+1
        write(*,*) 'Entrez le coefficient de degré ', i-1, ' : '
        read(*,*) coef(i)
    end do

    ! Contrôle
    write(*,*) 'Liste des coefficients du polynome'
    write(*,*) coef

    !Lecture x
    write(*,*) 'Entrez l''inconnue'
    read(*,*) x

    ! Schéma de Horner
    p = horner(coef, n, x)
    print*, p

end program test_horner

function horner(a, n, x) result(y)
    implicit none
    real, intent(in), dimension(n+1) :: a
    integer, intent(in) :: n
    real, intent(in) :: x
    real :: y

    integer :: i
    y = a(n+1)
    do i = n, 1, -1
        y = y*x + a(i)
    end do
end function horner