objects_f90 = spline.o spline_test.o

FC = gfortran
FLAGS = -Wall -Wno-unused-dummy-argument -g -O2 -lopenblas -lpthread -L../contrib/OpenBLAS/ 
#LIBS = ../contrib/OpenBLAS

#FC = ifort
#FLAGS = -O1 -debug -traceback -mkl
#LIBS = /afs/itp.tugraz.at/opt/intel/2015.1.133/mkl/lib/intel64/:/afs/itp.tugraz.at/opt/intel/2015.1.133/lib/intel64/

#all: init run

#init: 
#	cmd /c "C:\Program Files (x86)\Intel\Composer XE\mkl\bin\intel64\mklvars_intel64.bat"
#	cmd /c "C:\Program Files (x86)\Intel\Composer XE 2015\bin\ipsxe-comp-vars.bat" intel64 vs2013
#	export PATH="C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\bin\amd64":$PATH

run: spline_test
	./spline_test
	gnuplot plot.gp

spline_test: $(objects_f90)
	$(FC) -o spline_test $(objects_f90) $(FLAGS)

$(objects_f90): %.o: %.f90
	$(FC) -c $< -o $@ $(FLAGS)

clean:
	rm *.mod
	rm $(objects_f90)  
	rm spline_test
