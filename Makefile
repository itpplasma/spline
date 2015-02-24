objects_f90 = spline.o spline_test.o

FLAGS = -Wall -Wno-unused-dummy-argument -g -O2 -L ../contrib/OpenBLAS -lopenblas

run: spline_test
	LD_LIBRARY_PATH=../contrib/OpenBLAS ./spline_test
	gnuplot plot.gpl 

spline_test: $(objects_f90)
	gfortran $(FLAGS) -o spline_test $(objects_f90)

$(objects_f90): %.o: %.f90
	gfortran $(FLAGS) -c $< -o $@

clean:
	rm spline_test $(objects_f90) 
