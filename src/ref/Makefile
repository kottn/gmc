.SUFFIXES :
.SUFFIXES : .o .f90

FC      = gfortran
#FC      = ifort
PROG    = msh2mes 



FFLAGS = -Wall -O1 -fbounds-check -fbacktrace -fcheck=all -ffpe-trap=invalid,zero,overflow,underflow
#FFLAGS =  -O3 
#FFLAGS =  -CB -traceback -fpe:0
#FFLAGS =  -CB -check all -warn all -std -gen_interfaces -fpe0 -ftrapuv -traceback -g 
#FFLIB = 

SRC     = \
msh2mes.f90

OBJS = $(SRC:%.f90=%.o)

.f90.o:
	$(FC) $(FFLAGS) $(FFLIB) -c $< -o $@

$(PROG) :$(OBJS)
	$(FC) $(OBJS) $(FFLAGS) $(FFLIB) -o $(PROG)

clean:
	@rm -rf *.exe *.o *.mod *~ $(UNAME)

