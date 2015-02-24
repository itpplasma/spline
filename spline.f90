module spline
  !
  ! Spline implementation according to Sormann, 
  ! https://itp.tugraz.at/LV/sormann/NumPhysik/
  
  implicit none
  save

contains

  function spline_coeff(x, y)
    !
    ! returns spline coefficients
    !
    !! Input
    real(8) :: x(:), y(:)
    !! Output
    real(8) :: spline_coeff(size(x)-1,5)
    !! Variables
    integer :: n, info
    real(8) :: r(size(x)-1), &
         dl(size(x)-1), du(size(x)-1), d(size(x)), b(size(x))

    n = size(x)

    r = y(2:) - y(1:n-1)
    
    dl = 1d0
    du = 1d0
    d = 4d0
    d(1) = 2d0
    d(n) = 2d0

    b(1) = 3d0*r(1)
    b(2:n-1) = 3d0*(y(3:)-y(1:n-2))
    b(n) = 3d0*r(n-1)
    
    call dgtsv(n, 1, dl, d, du, b, n, info)

    !print *,b

    spline_coeff = 0d0
    spline_coeff(:,1) = x(1:n-1)
    spline_coeff(:,2) = y(1:n-1)
    spline_coeff(:,3) = b(1:n-1)
    spline_coeff(:,4) = 3*r - 2*b(1:n-1) - b(2:n) 
    spline_coeff(:,5) = -2*r + b(1:n-1) + b(2:n)
    spline_coeff(:,6) = x(2:) - x(1:n-1)
  end function spline_coeff

  function spline_val_0(coeff, x)
    !
    ! returns spline coefficients
    !
    !! Input
    real(8) :: x, coeff(:,:)
    !! Output
    real(8) :: spline_val_0
    !! Variables
    real(8) :: z
    integer :: n, ju, jl, jm, j

    n = size(coeff,1)+1
    jl = 0
    ju = n

    do while (ju-jl > 1)
       jm = (jl+ju)/2
       if (x > coeff(jm,1)) then
          jl = jm
       else
          ju = jm
       end if
    end do

    j = jl
    if (j==0) j=1
    if (j==n) j=n-1

    print *,j,n

    z = (x - coeff(j,1))/coeff(j,6)
    spline_val_0 = ((coeff(j,5)*z+coeff(j,4))*z+coeff(j,3))*z+coeff(j,2)
  end function spline_val_0
  
  function spline_val(coeff, x)
    !
    ! returns spline coefficients
    !
    !! Input
    real(8) :: x(:), coeff(:,:)
    !! Output
    real(8) :: spline_val(size(x))
    !! Variables
    integer :: k

    do k=1,size(x)
       spline_val(k) = spline_val_0(coeff, x(k))
    end do

  end function spline_val

end module spline
