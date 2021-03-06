/***************************************************************************
read_ASCII.cpp  -  Convert program to open Parsek Output
 -------------------
 begin                : Jun 2008
 copyright            : (C) 2004 by Stefano Markidis, Giovanni Lapenta
 ************************************************************************** */


#include "hdf5.h"
#include "Alloc.h"
#include "math.h"
#include "Manipulator.h"
#include "VtkStuff.h"
#include "Particles.h"
#include "ASCIIStuff.h"

#include <iostream>
#include <fstream>
#include <string>
#include <sstream>


int main (int argc, char **argv) {
    
    nxc = 151;
    nyc = 61;
    nzc = nyc;
    
    XLEN=1;
    YLEN=1;
    ZLEN=1;
    nxn=nxc;
    nyn=nyc;
    nzn=nzc;
    Lx=.2*nxc;
    Ly=.2*nyc;
    Lz=.2*nzc;
    
    
	double*** BX = newArr3(double,nxc,nyc,nzc);
	double*** BY = newArr3(double,nxc,nyc,nzc);
	double*** BZ = newArr3(double,nxc,nyc,nzc);
	double*** VX = newArr3(double,nxc,nyc,nzc);
	double*** VY = newArr3(double,nxc,nyc,nzc);
	double*** VZ = newArr3(double,nxc,nyc,nzc);
	double*** JX = newArr3(double,nxc,nyc,nzc);
	double*** JY = newArr3(double,nxc,nyc,nzc);
	double*** JZ = newArr3(double,nxc,nyc,nzc);
	double*** RHO = newArr3(double,nxc,nyc,nzc);
	double*** P = newArr3(double,nxc,nyc,nzc);
    
//	readASCIIvect("feb1508cgsec.box.0357.dat", BX, BY, BZ,
	readASCIIvect("feb1508cgsec.box.0348.dat", BX, BY, BZ,
                  VX, VY, VZ,
                  JX, JY, JZ,
                  RHO, P);
    
    
    writeVTKvect(0,"Bfeb1508", "", BX, BY, BZ);
    writeVTKvect(0,"Vfeb1508", "", VX, VY, VZ);
    writeVTKvect(0,"Jfeb1508", "", JX, JY, JZ);
    writeVTKscalar(0,"RHOfeb1508", "", RHO);
    writeVTKscalar(0,"Pfeb1508", "", P);
    
    
	delArr3(BX,nxc,nyc);
	delArr3(BY,nxc,nyc);
	delArr3(BZ,nxc,nyc);
	delArr3(VX,nxc,nyc);
	delArr3(VY,nxc,nyc);
	delArr3(VZ,nxc,nyc);
	delArr3(JX,nxc,nyc);
	delArr3(JY,nxc,nyc);
	delArr3(JZ,nxc,nyc);	
	delArr3(RHO,nxc,nyc);
	delArr3(P,nxc,nyc);	
}
