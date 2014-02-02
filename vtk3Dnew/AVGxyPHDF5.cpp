/***************************************************************************
 convHDF5.cpp  -  Convert program to open Parsek Output
 -------------------
 begin                : Jun 2008
 copyright            : (C) 2004 by Stefano Markidis, Giovanni Lapenta
 ************************************************************************** */

#include "hdf5.h"
#include "Alloc.h"
#include "math.h"
#include "Manipulator.h"
#include "VtkStuff.h"


#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

int main (int argc, char **argv) {
	// cycle we want to open
		sscanf(argv[1],"%d",&InitT);
	sscanf(argv[2],"%d",&MaxLevel);
	sscanf(argv[3],"%d",&DeltaT);
	nlevels = MaxLevel/DeltaT;
	initlevel = InitT/DeltaT;

    int out;
	out = readsettings();
	if(out<0)
		return -1;

	nxn = nxc/XLEN;
	nyn = nyc/YLEN;
	nzn = nzc/ZLEN;

	temp_storageX = new double[(nxn+1)*(nyn+1)*(nzn+1)];
	temp_storageY = new double[(nxn+1)*(nyn+1)*(nzn+1)];
    temp_storageZ = new double[(nxn+1)*(nyn+1)*(nzn+1)];

	double*** BX = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** BY = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** BZ = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** VX = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** VY = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** VZ = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** TXX = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** TXY = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** TXZ = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** TYY = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** TYZ = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** TZZ = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** TPAR  = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** TPER1 = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** TPER2 = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** EPS = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** NE = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** NI = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);

	double** NEB = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** NIB = newArr2(double,nxn*XLEN,nyn*YLEN);
	
	double** VXB = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** VYB = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** VZB = newArr2(double,nxn*XLEN,nyn*YLEN);

	double** TXXB = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** TXYB = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** TXZB = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** TYYB = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** TYZB = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** TZZB = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** TPARB = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** TPER1B = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** TPER2B = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** EPSB = newArr2(double,nxn*XLEN,nyn*YLEN);
	

	for (int it = initlevel; it < nlevels+1; it++){

    readvect(it, "/fields/","B", BX, BY, BZ);

		//Rho by species
		readscalar(it,"/moments/species_0/","rho",  NE);
		readscalar(it,"/moments/species_1/","rho",  NI);
		if (ns >2) addreadscalar(it,"/moments/species_2/","rho",  NE);
		if (ns >2) addreadscalar(it,"/moments/species_3/","rho",  NI);
		average(NEB,NE);
		average(NIB,NI);
		writeVTKscalar_species(it,"AVGrho", NEB, NIB);
		// writeVTKscalar("rho", "e", VX);
		
		//Currents species0
		readvect(it,"/moments/species_0/","J",  VX, VY, VZ);
		if (ns >2) addreadvect(it,"/moments/species_2/","J",  VX, VY, VZ);
		average(VXB,VYB,VZB,VX,VY,VZ);
		writeVTKvect(it,"AVGJ","e", VXB, VYB, VZB);
		
		//Pressure tensor species 0
		readscalar(it,"/moments/species_0/","pXX",  TXX);
		readscalar(it,"/moments/species_0/","pXY",  TXY);
		readscalar(it,"/moments/species_0/","pXZ",  TXZ);
		readscalar(it,"/moments/species_0/","pYY",  TYY);
		readscalar(it,"/moments/species_0/","pYZ",  TYZ);
		readscalar(it,"/moments/species_0/","pZZ",  TZZ);
		
		if (ns >2) addreadscalar(it,"/moments/species_2/","pXX",  TXX);
		if (ns >2) addreadscalar(it,"/moments/species_2/","pXY",  TXY);
		if (ns >2) addreadscalar(it,"/moments/species_2/","pXZ",  TXZ);
		if (ns >2) addreadscalar(it,"/moments/species_2/","pYY",  TYY);
		if (ns >2) addreadscalar(it,"/moments/species_2/","pYZ",  TYZ);
		if (ns >2) addreadscalar(it,"/moments/species_2/","pZZ",  TZZ);
		
		extract_pressure(qom[0], BX, BY, BZ, VX, VY, VZ, NI, 
						 TXX, TXY, TXZ, TYY, TYZ, TZZ, TPAR, TPER1, TPER2, EPS);
		average(TXXB,TXX);
		average(TXYB,TXY);		
		average(TXZB,TXZ);
		average(TYYB,TYY);
		average(TYZB,TYZ);		
		average(TZZB,TZZ);
		average(TPARB,TPAR);
		average(TPER1B,TPER1);		
		average(TPER2B,TPER2);	
		average(EPSB,EPS);									 
		writeVTKtensor(it, "AVGP", "e", TXXB, TXYB, TXZB, TYYB, TYZB, TZZB, 
					   TPARB, TPER1B, TPER2B, EPSB);
		
		//Currents species1
		readvect(it,"/moments/species_1/","J",  VX, VY, VZ);
		if (ns >2) addreadvect(it,"/moments/species_3/","J",  VX, VY, VZ);
		average(VXB,VYB,VZB,VX,VY,VZ);
		writeVTKvect(it,"AVGJ","i", VXB, VYB, VZB);
		//Pressure tensor species 1
		readscalar(it,"/moments/species_1/","pXX",  TXX);
		readscalar(it,"/moments/species_1/","pXY",  TXY);
		readscalar(it,"/moments/species_1/","pXZ",  TXZ);
		readscalar(it,"/moments/species_1/","pYY",  TYY);
		readscalar(it,"/moments/species_1/","pYZ",  TYZ);
		readscalar(it,"/moments/species_1/","pZZ",  TZZ);
		
		if (ns >2) addreadscalar(it,"/moments/species_3/","pXX",  TXX);
		if (ns >2) addreadscalar(it,"/moments/species_3/","pXY",  TXY);
		if (ns >2) addreadscalar(it,"/moments/species_3/","pXZ",  TXZ);
		if (ns >2) addreadscalar(it,"/moments/species_3/","pYY",  TYY);
		if (ns >2) addreadscalar(it,"/moments/species_3/","pYZ",  TYZ);
		if (ns >2) addreadscalar(it,"/moments/species_3/","pZZ",  TZZ);
		
		extract_pressure(qom[1], BX, BY, BZ, VX, VY, VZ, NI, 
						 TXX, TXY, TXZ, TYY, TYZ, TZZ, TPAR, TPER1, TPER2, EPS);
		average(TXXB,TXX);
		average(TXYB,TXY);		
		average(TXZB,TXZ);
		average(TYYB,TYY);
		average(TYZB,TYZ);		
		average(TZZB,TZZ);
		average(TPARB,TPAR);
		average(TPER1B,TPER1);		
		average(TPER2B,TPER2);	
		average(EPSB,EPS);									 
		writeVTKtensor(it, "AVGP", "i", TXXB, TXYB, TXZB, TYYB, TYZB, TZZB, 
					   TPARB, TPER1B, TPER2B, EPSB);		
}


	delArr3(BX,nxn*XLEN,nyn*YLEN);
	delArr3(BY,nxn*XLEN,nyn*YLEN);
	delArr3(BZ,nxn*XLEN,nyn*YLEN);
	delArr3(VX,nxn*XLEN,nyn*YLEN);
	delArr3(VY,nxn*XLEN,nyn*YLEN);
	delArr3(VZ,nxn*XLEN,nyn*YLEN);
	delArr3(TXX,nxn*XLEN,nyn*YLEN);
	delArr3(TXY,nxn*XLEN,nyn*YLEN);
	delArr3(TXZ,nxn*XLEN,nyn*YLEN);
	delArr3(TYY,nxn*XLEN,nyn*YLEN);
	delArr3(TYZ,nxn*XLEN,nyn*YLEN);
	delArr3(TZZ,nxn*XLEN,nyn*YLEN);		
	delArr3(TPAR,nxn*XLEN,nyn*YLEN);
	delArr3(TPER1,nxn*XLEN,nyn*YLEN);
	delArr3(TPER2,nxn*XLEN,nyn*YLEN);	
	delArr3(EPS,nxn*XLEN,nyn*YLEN);	
	delArr3(NE,nxn*XLEN,nyn*YLEN);			
	delArr3(NI,nxn*XLEN,nyn*YLEN);	
	
	delArr2(VXB,nxn*XLEN);
	delArr2(VYB,nxn*XLEN);
	delArr2(VZB,nxn*XLEN);
	delArr2(TXXB,nxn*XLEN);
	delArr2(TXYB,nxn*XLEN);
	delArr2(TXZB,nxn*XLEN);
	delArr2(TYYB,nxn*XLEN);
	delArr2(TYZB,nxn*XLEN);
	delArr2(TZZB,nxn*XLEN);
	delArr2(TPARB,nxn*XLEN);
	delArr2(TPER1B,nxn*XLEN);
	delArr2(TPER2B,nxn*XLEN);
	delArr2(EPSB,nxn*XLEN);
	delArr2(NEB,nxn*XLEN);
	delArr2(NIB,nxn*XLEN);
	
	delete[] temp_storageX;
	delete[] temp_storageY;
	delete[] temp_storageZ;
	
	
	return(0);
}

