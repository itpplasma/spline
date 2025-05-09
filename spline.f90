module spline
  !
  ! Spline implementation according to Sormann,
  ! https://itp.tugraz.at/LV/sormann/NumPhysik/

  implicit none

  integer :: j_start = 1  ! start index for spline_val_0 saved for efficiency
  !$omp threadprivate(j_start)

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
    real(8) :: r(size(x)-1), h(size(x)-1),&
         dl(size(x)-3), d(size(x)-2), c(size(x)-2)

    n = size(x)

    h = x(2:) - x(1:n-1)
    r = y(2:) - y(1:n-1)

    dl = h(2:n-2)
    d = 2d0*(h(1:n-2)+h(2:))

    !print *,dl
    !print *,d

    c = 3d0*(r(2:)/h(2:)-r(1:n-2)/h(1:n-2))

    call dptsv(n-2, 1, d, dl, c, n-2, info)

    spline_coeff = 0d0
    spline_coeff(:,1)     = x(1:n-1)
    spline_coeff(:,2)     = y(1:n-1)
    spline_coeff(1,3)     = r(1)/h(1) - h(1)/3d0*c(1)
    spline_coeff(2:n-2,3) = r(2:n-2)/h(2:n-2)-h(2:n-2)/3d0*(c(2:n-2)+2*c(1:n-3))
    spline_coeff(n-1,3)   = r(n-1)/h(n-1)-h(n-1)/3d0*(2*c(n-2))
    spline_coeff(1,4)     = 0
    spline_coeff(2:,4)    = c
    spline_coeff(1,5)     = 1/(3*h(1))*c(1)
    spline_coeff(2:n-2,5) = 1/(3*h(2:n-2))*(c(2:n-2)-c(1:n-3))
    spline_coeff(n-1,5)   = 1/(3*h(n-1))*(-c(n-2))
  end function spline_coeff

  function spline_val_0(coeff, x)
    real(8) :: spline_val_0(3)
    real(8), intent(in) :: x, coeff(:,:)
    real(8) :: z
    integer :: n, j

    n = size(coeff, 1) + 1

    j = j_start

    if (j < 1 .or. j >= n) j = 1
    if (x < coeff(j, 1)) then
      do while (j > 1 .and. x < coeff(j, 1))
        j = j - 1
      end do
    else if (j < n - 1 .and. x >= coeff(j + 1, 1)) then
      do while (j < n - 1 .and. x >= coeff(j + 1, 1))
        j = j + 1
      end do
    end if

    j_start = j

    z = x - coeff(j, 1)
    spline_val_0(1) = ((coeff(j, 5) * z + coeff(j, 4)) * z + coeff(j, 3)) * z + coeff(j, 2)
    spline_val_0(2) = (3d0 * coeff(j, 5) * z + 2d0 * coeff(j, 4)) * z + coeff(j, 3)
    spline_val_0(3) = 6d0 * coeff(j, 5) * z + 2d0 * coeff(j, 4)
  end function spline_val_0

  function spline_val(coeff, x)
    !
    ! returns spline coefficients
    !
    !! Input
    real(8) :: x(:), coeff(:,:)
    !! Output
    real(8) :: spline_val(size(x),3)
    !! Variables
    integer :: k

    ! TODO: make this more efficient
    do k=1,size(x)
       spline_val(k,:) = spline_val_0(coeff, x(k))
    end do

  end function spline_val

end module spline
