program spline_test
  use spline
  implicit none

  integer, parameter :: n1 = 99, n2 = 10
  real(8), parameter :: pi = 4*atan(1d0)
  integer :: k
  real(8) :: x1(n1), y1(n1), x2(n2), y2(n2), y1s(n1,3),&
       coeff(n2-1, 5), y1d(n1)
  
  open(unit=1, file='out1.txt', recl=1024)
  open(unit=2, file='out2.txt', recl=1024)
  
  x1 = -pi/2+2*pi/(n1-1)*(/(2*k, k=0,n1-1)/)
  y1 = sin(x1)
  y1d = cos(x1)
  !x2 = x1([3,4,5,6,7,8,56,70,85,99])
  x2 = x1([5,15,25,35,45,55,65,75,85,95])
  y2 = sin(x2)

  coeff = spline_coeff(x2, y2)
  
  y1s = spline_val(coeff, x1)
  
  do k=1,n1
     write(1,*) x1(k), y1(k), y1s(k,1), y1s(k,2), y1s(k,3), y1d(k)
  end do

  do k=1,n2
     write(2,*) x2(k), y2(k)
  end do
  
  print *, "Hello Splines"
end program spline_test
