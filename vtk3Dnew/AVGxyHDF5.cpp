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

	double*** EX = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** EY = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** EZ = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** BX = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** BY = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** BZ = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** VX = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** VY = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** VZ = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	
	double** EXB = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** EYB = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** EZB = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** BXB = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** BYB = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** BZB = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** VXB = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** VYB = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** VZB = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** EdotJX = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** EdotJY = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** EdotJZ = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** dEdotJX = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** dEdotJY = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** dEdotJZ = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** sEdotJX = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** sEdotJY = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** sEdotJZ = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** PX = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** PY = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** PZ = newArr2(double,nxn*XLEN,nyn*YLEN);	
	double** dPX = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** dPY = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** dPZ = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** sPX = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** sPY = newArr2(double,nxn*XLEN,nyn*YLEN);
	double** sPZ = newArr2(double,nxn*XLEN,nyn*YLEN);
	
	//Electric field
	for (int it = initlevel; it < nlevels+1; it++){
    readvect(it, "/fields/","E", EX, EY, EZ);
		average(EXB,EYB,EZB,EX,EY,EZ);
		writeVTKvect(it,"E","", EXB, EYB, EZB);

    readvect(it, "/fields/","B", BX, BY, BZ);
		average(BXB,BYB,BZB,BX,BY,BZ);
		writeVTKvect(it,"B","", BXB, BYB, BZB);

	//Poyting Flux
    averagecross(PX, PY, PZ, dPX, dPY, dPZ, sPX, sPY, sPZ, EXB, EYB, EZB, BXB, BYB, BZB, EX, EY, EZ, BX, BY, BZ);
    writeVTKvect(it,"AVGJPoy","", PX, PY, PZ);
    writeVTKvect(it,"AVGdelPoy","", dPX, dPY, dPZ);
    writeVTKvect(it,"STDPoy","", sPX, sPY, sPZ);

	//Currents species0
    readvect(it,"/moments/species_0/","J",  VX, VY, VZ);
    if (ns >2) addreadvect(it,"/moments/species_2/","J",  VX, VY, VZ);
		average(VXB,VYB,VZB,VX,VY,VZ);
		averagedot(EdotJX,EdotJY,EdotJZ,dEdotJX,dEdotJY,dEdotJZ,
                   sEdotJX,sEdotJY,sEdotJZ,
				   EXB,EYB,EZB,VXB,VYB,VZB,EX,EY,EZ,VX,VY,VZ);

		writeVTKvect(it,"J","e", VXB, VYB, VZB);
				writeVTKvect(it,"AVGJdotE","e", EdotJX, EdotJY, EdotJZ);
				writeVTKvect(it,"AVGdelJdotE","e", dEdotJX, dEdotJY, dEdotJZ);
				writeVTKvect(it,"STDJdotE","e", sEdotJX, sEdotJY, sEdotJZ);
		
		//Currents species1
		readvect(it,"/moments/species_1/","J",  VX, VY, VZ);
		if (ns >2) addreadvect(it,"/moments/species_3/","J",  VX, VY, VZ);
		average(VXB,VYB,VZB,VX,VY,VZ);
		averagedot(EdotJX,EdotJY,EdotJZ,dEdotJX,dEdotJY,dEdotJZ,
                   sEdotJX,sEdotJY,sEdotJZ,
				   EXB,EYB,EZB,VXB,VYB,VZB,EX,EY,EZ,VX,VY,VZ);
		
		writeVTKvect(it,"J","i", VXB, VYB, VZB);
		writeVTKvect(it,"AVGJdotE","i", EdotJX, EdotJY, EdotJZ);
		writeVTKvect(it,"AVGdelJdotE","i", dEdotJX, dEdotJY, dEdotJZ);
        writeVTKvect(it,"STDJdotE","i", sEdotJX, sEdotJY, sEdotJZ);
		
		
}

	delArr3(EX,nxn*XLEN,nyn*YLEN);
	delArr3(EY,nxn*XLEN,nyn*YLEN);
	delArr3(EZ,nxn*XLEN,nyn*YLEN);
	delArr3(BX,nxn*XLEN,nyn*YLEN);
	delArr3(BY,nxn*XLEN,nyn*YLEN);
	delArr3(BZ,nxn*XLEN,nyn*YLEN);
	delArr3(VX,nxn*XLEN,nyn*YLEN);
	delArr3(VY,nxn*XLEN,nyn*YLEN);
	delArr3(VZ,nxn*XLEN,nyn*YLEN);
	
	delArr2(EXB,nxn*XLEN);
	delArr2(EYB,nxn*XLEN);
	delArr2(EZB,nxn*XLEN);
	delArr2(VXB,nxn*XLEN);
	delArr2(VYB,nxn*XLEN);
	delArr2(VZB,nxn*XLEN);
	delArr2(EdotJX,nxn*XLEN);
	delArr2(EdotJY,nxn*XLEN);
	delArr2(EdotJZ,nxn*XLEN);
	delArr2(dEdotJX,nxn*XLEN);
	delArr2(dEdotJY,nxn*XLEN);
	delArr2(dEdotJZ,nxn*XLEN);
	delArr2(sEdotJX,nxn*XLEN);
	delArr2(sEdotJY,nxn*XLEN);
	delArr2(sEdotJZ,nxn*XLEN);
	delArr2(PX,nxn*XLEN);
	delArr2(PY,nxn*XLEN);
	delArr2(PZ,nxn*XLEN);
	delArr2(dPX,nxn*XLEN);
	delArr2(dPY,nxn*XLEN);
	delArr2(dPZ,nxn*XLEN);
	delArr2(sPX,nxn*XLEN);
	delArr2(sPY,nxn*XLEN);
	delArr2(sPZ,nxn*XLEN);
	delete[] temp_storageX;
	delete[] temp_storageY;
	delete[] temp_storageZ;
	
	
	return(0);
}

