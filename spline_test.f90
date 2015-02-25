program spline_test
  use spline
  implicit none

  integer, parameter :: n1 = 100, n2 = 10
  real(8), parameter :: pi = 4*atan(1d0)
  integer :: k
  real(8) :: x1(n1), y1(n1), x2(n2), y2(n2), y1s(n1),&
       dy1dx(n1), dy1dxs(n1), coeff(n2-1, 5)
  
  open(unit=1, file='out1.txt')
  open(unit=2, file='out2.txt')
  
  x1 = -pi/2+2*pi/(n1-1)*(/(k, k=0,n1-1)/)
  y1 = sin(x1)
  x2 = x1([3,4,5,35,36,55,56,70,85,100])
  y2 = sin(x2)

  do k=1,n1
     write(1,*) x1(k), y1(k)
  end do

  do k=1,n2
     write(2,*) x2(k), y2(k)
  end do

  coeff = spline_coeff(x2, y2)
  
  y1s = spline_val(coeff, x1)
  !dy1dxs = spline_dx1(x1, coeff)
  
  do k=1,n1
     write(1,*) x1(k), y1(k), y1s(k)
  end do

  do k=1,n2
     write(2,*) x2(k), y2(k)
  end do
  
  print *, "Hello Splines"
end program spline_test
