/***************************************************************************
 convHDF5.cpp  -  Convert program to open Parsek Output
 -------------------
 begin                : Jun 2008
 copyright            : (C) 2004 by Stefano Markidis, Giovanni Lapenta
 ************************************************************************** */

#include "hdf5.h"
#include "Alloc.h"
#include "math.h"


#include <iostream>
#include <fstream>
#include <string>
#include <sstream>


using std::string;
using std::stringstream;
using std::ofstream;
using std::cout;
using std::endl;

int readsettings();

void readvect(int it, string campo, string vectname, double ***EX, double ***EY,double ***EZ);

void addreadvect(int it, string campo, string vectname, double ***EX, double ***EY,double ***EZ);

void readscalar(int it, string campo, string scalarname, double ***EX);

void addreadscalar(int it, string campo, string scalarname, double ***EX);

void readpotential(int it, string campo, string scalarname, double ***POT);

void writeGDAvect(int it, string vectname, string addname, double ***EX, double ***EY,double ***EZ);

void writeGDAscalar(int it, string scalarname, string addname, double ***f);

void writeGDAscalar_species(int it, string scalarname,  double ***f1, double ***f2);

void writeGDAscalar_species(int it, string scalarname,  double ***f1, double ***f2, double ***f3);

void extract_pressure(double qom, double*** VX, double*** VY, double*** VZ,
		double*** N, double*** pXX, double*** pXY,
		double*** pXZ, double*** pYY, double*** pYZ, double*** pZZ);

void cross(double*** BX, double*** BY, double*** BZ, 
		double*** EX, double*** EY, double*** EZ, 
		double*** VXBX, double*** VXBY, double*** VXBZ);

void vnonfrozen(double*** N, double*** BX, double*** BY, double*** BZ, 
		double*** EX, double*** EY, double*** EZ, 
		double*** VX, double*** VY, double*** VZ);

void ohm(double*** N, double*** BX, double*** BY, double*** BZ, 
		double*** EX, double*** EY, double*** EZ, 
		double*** VX, double*** VY, double*** VZ,
		double*** OHMX, double*** OHMY, double*** OHMZ);

int nxn, nyn, nzn;
int nxc, nyc, nzc;
int XLEN, YLEN, ZLEN;
int nproc;
int ns;
double* qom;

double Lx, Ly, Lz;

int MaxLevel;
int DeltaT;
int InitT;
int nlevels;
int initlevel;

double *temp_storageX;
double *temp_storageY;
double *temp_storageZ;

// hdf stuff
hid_t    file_id;
hid_t    dataset_id;
herr_t   status;

// binary files 
FILE *fp;

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
	double*** OHMX = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** OHMY = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** OHMZ = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** NE = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	double*** NI = newArr3(double,nxn*XLEN,nyn*YLEN,nzn*ZLEN);
	
	//Electric field
	for (int it = initlevel; it < nlevels+1; it++){
    readvect(it, "/fields/","E", EX, EY, EZ);
    writeGDAvect(it, "E", "", EX, EY, EZ);

	//Magnetic field
    readvect(it,"/fields/","B", BX, BY, BZ);
    writeGDAvect(it,"B", "", BX, BY, BZ);

	//Compute ExB
    //cross(BX, BY, BZ, EX, EY, EZ, VXBX, VXBY, VXBZ)

	//Rho by species
    readscalar(it,"/moments/species_0/","rho",  NE);
    readscalar(it,"/moments/species_1/","rho",  NI);
    if (ns >2) addreadscalar(it,"/moments/species_2/","rho",  NE);
    if (ns >2) addreadscalar(it,"/moments/species_3/","rho",  NI);
    writeGDAscalar_species(it,"rho", NE, NI);
   // writeVTKscalar("rho", "e", VX);

	//Currents species0
    readvect(it,"/moments/species_0/","J",  VX, VY, VZ);
    if (ns >2) addreadvect(it,"/moments/species_2/","J",  VX, VY, VZ);
    writeGDAvect(it,"J", "e", VX, VY, VZ);
    
	//Evaluate and save E+VxB
    ohm(NE, BX, BY, BZ, EX, EY, EZ, VX, VY, VZ, OHMX, OHMY, OHMZ);
    writeGDAvect(it,"EMF", "e", VX, VY, VZ);
    vnonfrozen(NE, BX, BY, BZ, EX, EY, EZ, VX, VY, VZ);
    writeGDAvect(it,"VNF", "e", VX, VY, VZ);

    //Currents species1
    readvect(it,"/moments/species_1/","J",  VX, VY, VZ);
    if (ns >2) addreadvect(it,"/moments/species_3/","J",  VX, VY, VZ);
    writeGDAvect(it,"J", "i", VX, VY, VZ);

	//Evaluate and save E+VxB
    ohm(NE, BX, BY, BZ, EX, EY, EZ, VX, VY, VZ, OHMX, OHMY, OHMZ);
    writeGDAvect(it,"EMF", "i", VX, VY, VZ);
    vnonfrozen(NI, BX, BY, BZ, EX, EY, EZ, VX, VY, VZ);
    writeGDAvect(it,"VNF", "i", VX, VY, VZ);

}
	delArr3(BX,nxn*XLEN,nyn*YLEN);
	delArr3(BY,nxn*XLEN,nyn*YLEN);
	delArr3(BZ,nxn*XLEN,nyn*YLEN);
	delArr3(EX,nxn*XLEN,nyn*YLEN);
	delArr3(EY,nxn*XLEN,nyn*YLEN);
	delArr3(EZ,nxn*XLEN,nyn*YLEN);
	delArr3(VX,nxn*XLEN,nyn*YLEN);
	delArr3(VY,nxn*XLEN,nyn*YLEN);
	delArr3(VZ,nxn*XLEN,nyn*YLEN);
	delete[] temp_storageX;
	delete[] temp_storageY;
	delete[] temp_storageZ;
	
	
	return(0);
}


int readsettings(){
// Open the  settings file
file_id = H5Fopen("settings.hdf", H5F_ACC_RDWR, H5P_DEFAULT);
if (file_id < 0){
	cout << "couldn't open file: settings.hdf" << endl;

	return -1;
}
else
{
// First read the topology
int nproc;
dataset_id = H5Dopen(file_id, "/topology/Nprocs");
status = H5Dread(dataset_id, H5T_NATIVE_INT, H5S_ALL, H5S_ALL, H5P_DEFAULT,&nproc);
status = H5Dclose(dataset_id);

dataset_id = H5Dopen(file_id, "/topology/XLEN");
status = H5Dread(dataset_id, H5T_NATIVE_INT, H5S_ALL, H5S_ALL, H5P_DEFAULT,&XLEN);
status = H5Dclose(dataset_id);

dataset_id = H5Dopen(file_id, "/topology/YLEN");
status = H5Dread(dataset_id, H5T_NATIVE_INT, H5S_ALL, H5S_ALL, H5P_DEFAULT,&YLEN);
status = H5Dclose(dataset_id);

dataset_id = H5Dopen(file_id, "/topology/ZLEN");
status = H5Dread(dataset_id, H5T_NATIVE_INT, H5S_ALL, H5S_ALL, H5P_DEFAULT,&ZLEN);
status = H5Dclose(dataset_id);

// read Lx
dataset_id = H5Dopen(file_id, "/collective/Lx");
status = H5Dread(dataset_id, H5T_NATIVE_DOUBLE, H5S_ALL, H5S_ALL, H5P_DEFAULT,&Lx);
status = H5Dclose(dataset_id);
// read Ly
dataset_id = H5Dopen(file_id, "/collective/Ly");
status = H5Dread(dataset_id, H5T_NATIVE_DOUBLE, H5S_ALL, H5S_ALL, H5P_DEFAULT,&Ly);
status = H5Dclose(dataset_id);
// read Lz
dataset_id = H5Dopen(file_id, "/collective/Lz");
status = H5Dread(dataset_id, H5T_NATIVE_DOUBLE, H5S_ALL, H5S_ALL, H5P_DEFAULT,&Lz);
status = H5Dclose(dataset_id);
// read nxc
dataset_id = H5Dopen(file_id, "/collective/Nxc");
status = H5Dread(dataset_id, H5T_NATIVE_INT, H5S_ALL, H5S_ALL, H5P_DEFAULT,&nxc);
status = H5Dclose(dataset_id);
// read nyc
dataset_id = H5Dopen(file_id, "/collective/Nyc");
status = H5Dread(dataset_id, H5T_NATIVE_INT, H5S_ALL, H5S_ALL, H5P_DEFAULT,&nyc);
status = H5Dclose(dataset_id);
// read nyc
dataset_id = H5Dopen(file_id, "/collective/Nzc");
status = H5Dread(dataset_id, H5T_NATIVE_INT, H5S_ALL, H5S_ALL, H5P_DEFAULT,&nzc);
status = H5Dclose(dataset_id);
// read ns
dataset_id = H5Dopen(file_id, "/collective/Ns");
status = H5Dread(dataset_id, H5T_NATIVE_INT, H5S_ALL, H5S_ALL, H5P_DEFAULT,&ns);
// read qom
qom = new double[ns];
stringstream specie;
string temp;
for (int is=0; is<ns; is++){
specie.clear();
specie.str("");
specie << is;
temp = "/collective/species_"+specie.str()+"/qom";
dataset_id = H5Dopen(file_id, temp.c_str());
status = H5Dread(dataset_id, H5T_NATIVE_DOUBLE, H5S_ALL, H5S_ALL, H5P_DEFAULT,&qom[is]);
}
// at this point you can close settings
status = H5Fclose(file_id);
return 0;
}
}


void readvect(int it, string campo, string vectname, double*** EX, double*** EY,double*** EZ) {

	hid_t proc_file_id;
	int cycle;
	stringstream cc;
    cycle = it * DeltaT;
	  cout << "READING VECTOR FROM HDF5 FILES  Time Level="<<cycle << endl;

    cc.clear();
    cc.str("");
	cc << cycle;
	string temp;
	int proc;
	for (int i=0; i < XLEN;i++)
	for (int j=0; j < YLEN;j++)
    for (int k=0; k < ZLEN;k++){
	    cout << "i="<<i << " j="<<j<< " k="<<k << endl;
        proc= i*YLEN*ZLEN+j*ZLEN+k;
		stringstream ss;
		ss << proc;
		cout << "ss="<<ss.str() << endl;
		temp = "proc" + ss.str() + ".hdf";
		proc_file_id = H5Fopen(temp.c_str(), H5F_ACC_RDWR, H5P_DEFAULT);
		// read data
	    cout << "file = " << temp << endl;
		temp = campo+vectname+"x/cycle_"+ cc.str();
	    cout << "dataset = " << temp << endl;
		dataset_id = H5Dopen(proc_file_id,temp.c_str());
		status = H5Dread(dataset_id, H5T_NATIVE_DOUBLE, H5S_ALL,H5S_ALL,H5P_DEFAULT,temp_storageX); status = H5Dclose(dataset_id);
		temp = campo+vectname+"y/cycle_"+ cc.str();
	    cout << "dataset = " << temp << endl;
		dataset_id = H5Dopen(proc_file_id,temp.c_str());
		status = H5Dread(dataset_id, H5T_NATIVE_DOUBLE, H5S_ALL,H5S_ALL,H5P_DEFAULT,temp_storageY); status = H5Dclose(dataset_id);
		temp = campo+vectname+"z/cycle_"+ cc.str();
	    cout << "dataset = " << temp << endl;
		dataset_id = H5Dopen(proc_file_id,temp.c_str());
		status = H5Dread(dataset_id, H5T_NATIVE_DOUBLE, H5S_ALL,H5S_ALL,H5P_DEFAULT,temp_storageZ); status = H5Dclose(dataset_id);
		int node=0;
		for (int ii=0; ii < (nxn+1);ii++)
			for (int jj=0; jj < (nyn+1);jj++)
				for (int kk=0; kk < (nzn+1);kk++){
					if (ii!=nxn && jj!= nyn && kk!= nzn){
						EX[ii + nxn*i][jj + nyn*j][kk + nzn*k] = temp_storageX[node];
						EY[ii + nxn*i][jj + nyn*j][kk + nzn*k] = temp_storageY[node];
						EZ[ii + nxn*i][jj + nyn*j][kk + nzn*k] = temp_storageZ[node];
					}
					node++;
				}
		// close the file
		H5Fclose(proc_file_id);
		// go to other proc
	}

}

void addreadvect(int it, string campo, string vectname, double*** EX, double*** EY,double*** EZ) {

	hid_t proc_file_id;
	int cycle;
	stringstream cc;
    cycle = it * DeltaT;
	  cout << "READING VECTOR FROM HDF5 FILES  Time Level="<<cycle << endl;

    cc.clear();
    cc.str("");
	cc << cycle;
	string temp;
	int proc;
	for (int i=0; i < XLEN;i++)
	for (int j=0; j < YLEN;j++)
    for (int k=0; k < ZLEN;k++){
	    cout << "i="<<i << " j="<<j<< " k="<<k << endl;
        proc= i*YLEN*ZLEN+j*ZLEN+k;
		stringstream ss;
		ss << proc;
		cout << "ss="<<ss.str() << endl;
		temp = "proc" + ss.str() + ".hdf";
		proc_file_id = H5Fopen(temp.c_str(), H5F_ACC_RDWR, H5P_DEFAULT);
		// read data
	    cout << "file = " << temp << endl;
		temp = campo+vectname+"x/cycle_"+ cc.str();
	    cout << "dataset = " << temp << endl;
		dataset_id = H5Dopen(proc_file_id,temp.c_str());
		status = H5Dread(dataset_id, H5T_NATIVE_DOUBLE, H5S_ALL,H5S_ALL,H5P_DEFAULT,temp_storageX); status = H5Dclose(dataset_id);
		temp = campo+vectname+"y/cycle_"+ cc.str();
	    cout << "dataset = " << temp << endl;
		dataset_id = H5Dopen(proc_file_id,temp.c_str());
		status = H5Dread(dataset_id, H5T_NATIVE_DOUBLE, H5S_ALL,H5S_ALL,H5P_DEFAULT,temp_storageY); status = H5Dclose(dataset_id);
		temp = campo+vectname+"z/cycle_"+ cc.str();
	    cout << "dataset = " << temp << endl;
		dataset_id = H5Dopen(proc_file_id,temp.c_str());
		status = H5Dread(dataset_id, H5T_NATIVE_DOUBLE, H5S_ALL,H5S_ALL,H5P_DEFAULT,temp_storageZ); status = H5Dclose(dataset_id);
		int node=0;
		for (int ii=0; ii < (nxn+1);ii++)
			for (int jj=0; jj < (nyn+1);jj++)
				for (int kk=0; kk < (nzn+1);kk++){
					if (ii!=nxn && jj!= nyn && kk!= nzn){
						EX[ii + nxn*i][jj + nyn*j][kk + nzn*k] += temp_storageX[node];
						EY[ii + nxn*i][jj + nyn*j][kk + nzn*k] += temp_storageY[node];
						EZ[ii + nxn*i][jj + nyn*j][kk + nzn*k] += temp_storageZ[node];
					}
					node++;
				}
		// close the file
		H5Fclose(proc_file_id);
		// go to other proc
	}

}

void readscalar(int it, string campo, string scalarname, double*** EX) {

	hid_t proc_file_id;
	int cycle;
	stringstream cc;
    cycle = it * DeltaT;
	  cout << "READING VECTOR FROM HDF5 FILES  Time Level="<<cycle << endl;

    cc.clear();
    cc.str("");
	cc << cycle;
	string temp;
	int proc;
	int i=XLEN/2;
	int k=ZLEN/2;
	for (int i=0; i < XLEN;i++)
	for (int j=0; j < YLEN;j++)
    for (int k=0; k < ZLEN;k++){
	    cout << "i="<<i << " j="<<j<< " k="<<k << endl;
	    proc= i*YLEN*ZLEN+j*ZLEN+k;
		stringstream ss;
		ss << proc;
		cout << "ss="<<ss.str() << endl;
		temp = "proc" + ss.str() + ".hdf";
		proc_file_id = H5Fopen(temp.c_str(), H5F_ACC_RDWR, H5P_DEFAULT);
		// read data
	    cout << "file = " << temp << endl;
		temp = campo+scalarname+"/cycle_"+ cc.str();
	    cout << "dataset = " << temp << endl;
		dataset_id = H5Dopen(proc_file_id,temp.c_str());
		status = H5Dread(dataset_id, H5T_NATIVE_DOUBLE, H5S_ALL,H5S_ALL,H5P_DEFAULT,temp_storageX); status = H5Dclose(dataset_id);

		int node=0;
		for (int ii=0; ii < (nxn+1);ii++)
			for (int jj=0; jj < (nyn+1);jj++)
				for (int kk=0; kk < (nzn+1);kk++){
					if (ii!=nxn && jj!= nyn && kk!= nzn){
						EX[ii + nxn*i][jj + nyn*j][kk + nzn*k] = temp_storageX[node];
					}
					node++;
				}
		// close the file
		H5Fclose(proc_file_id);
		// go to other proc
    }
}
void addreadscalar(int it, string campo, string scalarname, double*** EX) {

	hid_t proc_file_id;
	int cycle;
	stringstream cc;
    cycle = it * DeltaT;
	  cout << "READING VECTOR FROM HDF5 FILES  Time Level="<<cycle << endl;

    cc.clear();
    cc.str("");
	cc << cycle;
	string temp;
	int proc;
	int i=XLEN/2;
	int k=ZLEN/2;
	for (int i=0; i < XLEN;i++)
	for (int j=0; j < YLEN;j++)
    for (int k=0; k < ZLEN;k++){
	    cout << "i="<<i << " j="<<j<< " k="<<k << endl;
	    proc= i*YLEN*ZLEN+j*ZLEN+k;
		stringstream ss;
		ss << proc;
		cout << "ss="<<ss.str() << endl;
		temp = "proc" + ss.str() + ".hdf";
		proc_file_id = H5Fopen(temp.c_str(), H5F_ACC_RDWR, H5P_DEFAULT);
		// read data
	    cout << "file = " << temp << endl;
		temp = campo+scalarname+"/cycle_"+ cc.str();
	    cout << "dataset = " << temp << endl;
		dataset_id = H5Dopen(proc_file_id,temp.c_str());
		status = H5Dread(dataset_id, H5T_NATIVE_DOUBLE, H5S_ALL,H5S_ALL,H5P_DEFAULT,temp_storageX); status = H5Dclose(dataset_id);

		int node=0;
		for (int ii=0; ii < (nxn+1);ii++)
			for (int jj=0; jj < (nyn+1);jj++)
				for (int kk=0; kk < (nzn+1);kk++){
					if (ii!=nxn && jj!= nyn && kk!= nzn){
						EX[ii + nxn*i][jj + nyn*j][kk + nzn*k] += temp_storageX[node];
					}
					node++;
				}
		// close the file
		H5Fclose(proc_file_id);
		// go to other proc
    }
}

void readpotential(int it, string campo, string scalarname, double*** EX) {

	hid_t proc_file_id;
	int cycle;
	stringstream cc;
    cycle = it * DeltaT;
	  cout << "READING VECTOR FROM HDF5 FILES  Time Level="<<cycle << endl;

    cc.clear();
    cc.str("");
	cc << cycle;
	string temp;
	int proc;
	for (int i=0; i < XLEN;i++)
	for (int j=0; j < YLEN;j++)
    for (int k=0; k < ZLEN;k++){
	    cout << "i="<<i << " j="<<j<< " k="<<k << endl;
	    proc= i*YLEN*ZLEN+j*ZLEN+k;
		stringstream ss;
		ss << proc;
		cout << "ss="<<ss.str() << endl;
		temp = "proc" + ss.str() + ".hdf";
		proc_file_id = H5Fopen(temp.c_str(), H5F_ACC_RDWR, H5P_DEFAULT);
		// read data
	    cout << "file = " << temp << endl;
		temp = campo+scalarname+"/cycle_"+ cc.str();
	    cout << "dataset = " << temp << endl;
		dataset_id = H5Dopen(proc_file_id,temp.c_str());
		status = H5Dread(dataset_id, H5T_NATIVE_DOUBLE, H5S_ALL,H5S_ALL,H5P_DEFAULT,temp_storageX); status = H5Dclose(dataset_id);

		int node=0;
		for (int ii=0; ii < (nxn);ii++)
			for (int jj=0; jj < (nyn);jj++)
				for (int kk=0; kk < (nzn);kk++){
						EX[ii + nxn*i][jj + nyn*j][kk + nzn*k] = temp_storageX[node];
					node++;
				}
		// close the file
		H5Fclose(proc_file_id);
		// go to other proc
	}
}

void writeGDAvect(int it, string vectname, string addname, double*** EX, double*** EY,double*** EZ) {

	

    int cycle = it * DeltaT;
	stringstream stringcycle;
	stringcycle << cycle;
	string temp;
	temp = vectname +addname +"_x_cycle" +stringcycle.str();
	temp += ".gda";
	fp=fopen(temp.c_str(),"wb");
	for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
			for (int ii=0; ii < nxn*XLEN;ii++){
				fwrite(&EX[ii][jj][kk],sizeof(float),1,fp);
			}
	fclose(fp);
	
	temp = vectname +addname +"_y_cycle" +stringcycle.str();
	temp += ".gda";
	fp=fopen(temp.c_str(),"wb");
	for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
			for (int ii=0; ii < nxn*XLEN;ii++){
				fwrite(&EY[ii][jj][kk],sizeof(float),1,fp);
			}
	fclose(fp);
	
	temp = vectname +addname +"_z_cycle" +stringcycle.str();
	temp += ".gda";
	fp=fopen(temp.c_str(),"wb");
	for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
			for (int ii=0; ii < nxn*XLEN;ii++){
				fwrite(&EZ[ii][jj][kk],sizeof(float),1,fp);
			}
	fclose(fp);
}


void writeGDAscalar(int it, string scalarname, string addname, double*** EX) {


    int cycle = it * DeltaT;
	string temp;
	stringstream stringcycle;
	stringcycle << cycle;
	temp = scalarname +addname +"_cycle" +stringcycle.str();
	temp += ".gda";
	fp=fopen(temp.c_str(),"wb");
	for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
			for (int ii=0; ii < nxn*XLEN;ii++){
				fwrite(&EX[ii][jj][kk],sizeof(float),1,fp);
			}
	fclose(fp);
}


void writeGDAscalar_species(int it, string scalarname, double*** EX, double*** EY) {


    int cycle = it * DeltaT;
	string temp;
	stringstream stringcycle;
	stringcycle << cycle;
	temp = scalarname +"_0_cycle" +stringcycle.str();
	temp += ".gda";
	fp=fopen(temp.c_str(),"wb");
	for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
			for (int ii=0; ii < nxn*XLEN;ii++){
				fwrite(&EX[ii][jj][kk],sizeof(float),1,fp);
			}
	fclose(fp);
	temp = scalarname +"_1_cycle" +stringcycle.str();
	temp += ".gda";
	fp=fopen(temp.c_str(),"wb");
	for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
			for (int ii=0; ii < nxn*XLEN;ii++){
				fwrite(&EY[ii][jj][kk],sizeof(float),1,fp);
			}
	fclose(fp);
	
	
}

void writeGDAscalar_species(int it, string scalarname, double*** EX, double*** EY, double*** EZ) {
    int cycle = it * DeltaT;
	string temp;
	stringstream stringcycle;
	stringcycle << cycle;
	temp = scalarname +"_0_cycle" +stringcycle.str();
	temp += ".gda";
	fp=fopen(temp.c_str(),"wb");
	for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
			for (int ii=0; ii < nxn*XLEN;ii++){
				fwrite(&EX[ii][jj][kk],sizeof(float),1,fp);
			}
	fclose(fp);
	temp = scalarname +"_1_cycle" +stringcycle.str();
	temp += ".gda";
	fp=fopen(temp.c_str(),"wb");
	for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
			for (int ii=0; ii < nxn*XLEN;ii++){
				fwrite(&EY[ii][jj][kk],sizeof(float),1,fp);
			}
	fclose(fp);
	temp = scalarname +"_2_cycle" +stringcycle.str();
	temp += ".gda";
	fp=fopen(temp.c_str(),"wb");
	for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
			for (int ii=0; ii < nxn*XLEN;ii++){
				fwrite(&EZ[ii][jj][kk],sizeof(float),1,fp);
			}
	fclose(fp);
	
}

void extract_pressure(double qom, double*** VX, double*** VY, double*** VZ,
		double*** N, double*** pXX, double*** pXY,
		double*** pXZ, double*** pYY, double*** pYZ, double*** pZZ) {
	for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
		   for (int ii=0; ii < nxn*XLEN;ii++){
    	if(N[ii][jj][kk]!=0.0)
    		pXX[ii][jj][kk] = pXX[ii][jj][kk]-VX[ii][jj][kk]*VX[ii][jj][kk]/N[ii][jj][kk];
	    pXX[ii][jj][kk] = pXX[ii][jj][kk] / qom;
    	if(N[ii][jj][kk]!=0.0)
	    pXY[ii][jj][kk] = pXY[ii][jj][kk]-VX[ii][jj][kk]*VY[ii][jj][kk]/N[ii][jj][kk];
	    pXY[ii][jj][kk] = pXY[ii][jj][kk] / qom;
    	if(N[ii][jj][kk]!=0.0)
	    pXZ[ii][jj][kk] = pXZ[ii][jj][kk]-VX[ii][jj][kk]*VZ[ii][jj][kk]/N[ii][jj][kk];
	    pXZ[ii][jj][kk] = pXZ[ii][jj][kk] / qom;
    	if(N[ii][jj][kk]!=0.0)
	    pYY[ii][jj][kk] = pYY[ii][jj][kk]-VY[ii][jj][kk]*VY[ii][jj][kk]/N[ii][jj][kk];
	    pYY[ii][jj][kk] = pYY[ii][jj][kk] / qom;
    	if(N[ii][jj][kk]!=0.0)
	    pYZ[ii][jj][kk] = pYZ[ii][jj][kk]-VY[ii][jj][kk]*VZ[ii][jj][kk]/N[ii][jj][kk];
	    pYZ[ii][jj][kk] = pYZ[ii][jj][kk] / qom;
    	if(N[ii][jj][kk]!=0.0)
	    pZZ[ii][jj][kk] = pZZ[ii][jj][kk]-VZ[ii][jj][kk]*VZ[ii][jj][kk]/N[ii][jj][kk];
	    pZZ[ii][jj][kk] = pZZ[ii][jj][kk] / qom;
	}
}

void cross(double*** BX, double*** BY, double*** BZ, 
		double*** EX, double*** EY, double*** EZ, 
		double*** VXBX, double*** VXBY, double*** VXBZ){
	for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
		   for (int ii=0; ii < nxn*XLEN;ii++){
			double b = 1e-10 + BX[ii][jj][kk]*BX[ii][jj][kk] + 
				   	   BY[ii][jj][kk]*BY[ii][jj][kk] +
					   BZ[ii][jj][kk]*BZ[ii][jj][kk];
			VXBX[ii][jj][kk] = (EY[ii][jj][kk]*BZ[ii][jj][kk] - EZ[ii][jj][kk]*BY[ii][jj][kk])/b;
			VXBY[ii][jj][kk] = (EZ[ii][jj][kk]*BX[ii][jj][kk] - EX[ii][jj][kk]*BZ[ii][jj][kk])/b;
			VXBZ[ii][jj][kk] = (EX[ii][jj][kk]*BY[ii][jj][kk] - EY[ii][jj][kk]*BX[ii][jj][kk])/b;

	}
}

void vnonfrozen(double*** N, double*** BX, double*** BY, double*** BZ, 
		double*** EX, double*** EY, double*** EZ, 
		double*** VX, double*** VY, double*** VZ){
	for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
		   for (int ii=0; ii < nxn*XLEN;ii++){
			double b = 1e-10 + BX[ii][jj][kk]*BX[ii][jj][kk] + 
				   	   BY[ii][jj][kk]*BY[ii][jj][kk] +
					   BZ[ii][jj][kk]*BZ[ii][jj][kk];
			VX[ii][jj][kk] = VX[ii][jj][kk] / N[ii][jj][kk] - 
				(EY[ii][jj][kk]*BZ[ii][jj][kk] - EZ[ii][jj][kk]*BY[ii][jj][kk])/b;

			VY[ii][jj][kk] = VY[ii][jj][kk] / N[ii][jj][kk] -
				(EZ[ii][jj][kk]*BX[ii][jj][kk] - EX[ii][jj][kk]*BZ[ii][jj][kk])/b;

			VZ[ii][jj][kk] = VZ[ii][jj][kk] / N[ii][jj][kk] -
				(EX[ii][jj][kk]*BY[ii][jj][kk] - EY[ii][jj][kk]*BX[ii][jj][kk])/b;

	}
}

void ohm(double*** N, double*** BX, double*** BY, double*** BZ, 
		double*** EX, double*** EY, double*** EZ, 
		double*** VX, double*** VY, double*** VZ,
		double*** OHMX, double*** OHMY, double*** OHMZ){
	for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
		   for (int ii=0; ii < nxn*XLEN;ii++){

			OHMX[ii][jj][kk] = EX[ii][jj][kk]  + 
				(VY[ii][jj][kk]*BZ[ii][jj][kk] - VZ[ii][jj][kk]*BY[ii][jj][kk]) / N[ii][jj][kk];

			OHMY[ii][jj][kk] = EY[ii][jj][kk]  +
				(VZ[ii][jj][kk]*BX[ii][jj][kk] - VX[ii][jj][kk]*BZ[ii][jj][kk]) / N[ii][jj][kk];

			OHMZ[ii][jj][kk] = EZ[ii][jj][kk]  +
				(VX[ii][jj][kk]*BY[ii][jj][kk] - VY[ii][jj][kk]*BX[ii][jj][kk]) / N[ii][jj][kk];

	}
}
