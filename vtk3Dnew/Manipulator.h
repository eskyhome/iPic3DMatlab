/*
 *  Manipulator.h
 *  
 *
 *  Created by Giovanni Lapenta on 7/29/13.
 *  Copyright 2013 __MyCompanyName__. All rights reserved.
 *
 */

#include "hdf5.h"
#include "Alloc.h"
#include "math.h"


#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

using namespace std;
using std::string;
using std::stringstream;
using std::ofstream;
using std::cout;
using std::endl;

// Manipulations

void average(double** EXB, double*** EX);

void averageSTD(double** EXB, double** EXSTD, double*** EX);

void average(double** EXB, double** EYB, double** EZB, double*** EX, double*** EY, double*** EZ);

void averagedot(double** EdotJX, double** EdotJY, double** EdotJZ,
		   double** dEdotJX, double** dEdotJY, double** dEdotJZ,
		   double** EXB, double** EYB, double** EZB,
		   double** VXB, double** VYB, double** VZB,
		   double*** EX, double*** EY, double*** EZ, 
		   double*** VX, double*** VY, double*** VZ);

void averagedot(double** EdotJX, double** EdotJY, double** EdotJZ,
                double** dEdotJX, double** dEdotJY, double** dEdotJZ,
                double** sEdotJX, double** sEdotJY, double** sEdotJZ,
                double** EXB, double** EYB, double** EZB,
                double** VXB, double** VYB, double** VZB,
                double*** EX, double*** EY, double*** EZ,
                double*** VX, double*** VY, double*** VZ);

void averagecross(double** CX, double** CY, double** CZ,
				double** dCX, double** dCY, double** dCZ,
				double** EXB, double** EYB, double** EZB,
				double** BXB, double** BYB, double** BZB,
				double*** EX, double*** EY, double*** EZ, 
				double*** BX, double*** BY, double*** BZ);

void averagecross(double** CX, double** CY, double** CZ,
                  double** dCX, double** dCY, double** dCZ,
                  double** sCX, double** sCY, double** sCZ,
                  double** EXB, double** EYB, double** EZB,
                  double** BXB, double** BYB, double** BZB,
                  double*** EX, double*** EY, double*** EZ,
                  double*** BX, double*** BY, double*** BZ);

 void average_energy(double** AVGENTH, double** AVGENIN, double** AVGJDOTE,
		double** STDENTH, double** STDENIN, double** STDJDOTE,
		double*** VDIVP, double*** DIVJV, double*** JDOTE);

void extract_pressure(double qom, double*** BX, double*** BY, double*** BZ,
					  double*** VX, double*** VY, double*** VZ,
					  double*** N, double*** pXX, double*** pXY,
					  double*** pXZ, double*** pYY, double*** pYZ, double*** pZZ,
					  double*** pPAR, double*** pPER1, double*** pPER2, double*** EPS);


void divergence(double*** div, double*** EX, double*** EY, double*** EZ);

void vdiv(double*** vdiv, double*** PXX, double*** PYY, double*** PZZ,
                         double*** PXY, double*** PXZ, double*** PYZ,
                         double*** RHO, 
                         double*** JX, double*** JY, double*** JZ);
void divj(double qom, double*** divj,  
          double*** EX, double*** EY, double*** EZ, double VSQ);
          
void dot(double*** dot, 
          double*** AX, double*** AY, double*** AZ, 
          double*** BX, double*** BY, double*** BZ, double*** RHO);
          
void dot(double*** dot, 
          double*** AX, double*** AY, double*** AZ, 
          double*** BX, double*** BY, double*** BZ);            

// Computation of ExB/B^2 for 3D arrays
void cross(double*** BX, double*** BY, double*** BZ, 
		   double*** EX, double*** EY, double*** EZ, 
		   double*** VXBX, double*** VXBY, double*** VXBZ);

// Computation of ExB for 2D arrays
void cross(double** BX, double** BY, double** BZ, 
		   double** EX, double** EY, double** EZ, 
		   double** VXBX, double** VXBY, double** VXBZ);


void vnonfrozen(double*** N, double*** BX, double*** BY, double*** BZ, 
				double*** EX, double*** EY, double*** EZ, 
				double*** VX, double*** VY, double*** VZ);

void ohm(double*** N, double*** BX, double*** BY, double*** BZ, 
		 double*** EX, double*** EY, double*** EZ, 
		 double*** VX, double*** VY, double*** VZ,
		 double*** OHMX, double*** OHMY, double*** OHMZ);

void zenitani(double*** NE, double*** NI, 
 		 double*** BX, double*** BY, double*** BZ, 
		 double*** EX, double*** EY, double*** EZ, 
		 double*** JEX, double*** JEY, double*** JEZ,
		 double*** JIX, double*** JIY, double*** JIZ,
		 double*** DE, double*** DI);

double vecpot(double*** AZ, double*** BX, double*** BY, double*** BZ);

int nxn, nyn, nzn;
int nxc, nyc, nzc;
int XLEN, YLEN, ZLEN;
int nproc;
int ns;
double* qom;

double Lx, Ly, Lz;
double Dx, Dy, Dz;

void average(double** EXB, double** EYB, double** EZB, double*** EX, double*** EY, double*** EZ){
	
	for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			EXB[ii][jj] = 0.0;
			EYB[ii][jj] = 0.0;
			EZB[ii][jj] = 0.0;
		}			
	for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
			for (int ii=0; ii < nxn*XLEN;ii++){
				EXB[ii][jj] += EX[ii][jj][kk];				
				EYB[ii][jj] += EY[ii][jj][kk];
				EZB[ii][jj] += EZ[ii][jj][kk];			
			}
	for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			EXB[ii][jj] = EXB[ii][jj] / nzn/ZLEN;
			EYB[ii][jj] = EYB[ii][jj] / nzn/ZLEN;
			EZB[ii][jj] = EZB[ii][jj] / nzn/ZLEN;
		}	
}

void average(double** EXB, double*** EX){
	
	for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			EXB[ii][jj] = 0.0;

		}			
	for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
			for (int ii=0; ii < nxn*XLEN;ii++){
				EXB[ii][jj] += EX[ii][jj][kk];				
			
			}
	for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			EXB[ii][jj] = EXB[ii][jj] / nzn/ZLEN;

		}	
}


void averageSTD(double** EXB, double** EXSTD, double*** EX){
	
	for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			EXB[ii][jj] = 0.0;
            
		}
	for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
			for (int ii=0; ii < nxn*XLEN;ii++){
				EXB[ii][jj] += EX[ii][jj][kk];
                
			}
	for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			EXB[ii][jj] = EXB[ii][jj] / nzn/ZLEN;
            
		}	
	for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			EXSTD[ii][jj] = 0.0;
            
		}
	for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
			for (int ii=0; ii < nxn*XLEN;ii++){
				EXSTD[ii][jj] += pow(EX[ii][jj][kk]-EXB[ii][jj],2);
            }
    for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			EXSTD[ii][jj] = sqrt(EXSTD[ii][jj] / nzn/ZLEN);
            
		}
                
}

void averagedot(double** EdotJX, double** EdotJY, double** EdotJZ,
				double** dEdotJX, double** dEdotJY, double** dEdotJZ,
				double** EXB, double** EYB, double** EZB,
				double** VXB, double** VYB, double** VZB,
				double*** EX, double*** EY, double*** EZ, 
				double*** VX, double*** VY, double*** VZ){
	
	for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			EdotJX[ii][jj] = EXB[ii][jj] * VXB[ii][jj];
			EdotJY[ii][jj] = EYB[ii][jj] * VYB[ii][jj];
			EdotJZ[ii][jj] = EZB[ii][jj] * VZB[ii][jj];
			dEdotJX[ii][jj] = 0.0;
			dEdotJY[ii][jj] = 0.0;
			dEdotJZ[ii][jj] = 0.0;		
		}			
	for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
			for (int ii=0; ii < nxn*XLEN;ii++){
				dEdotJX[ii][jj] += (EX[ii][jj][kk]-EXB[ii][jj]) * (VX[ii][jj][kk]-VXB[ii][jj]);				
				dEdotJY[ii][jj] += (EY[ii][jj][kk]-EYB[ii][jj]) * (VY[ii][jj][kk]-VYB[ii][jj]);		
				dEdotJZ[ii][jj] += (EZ[ii][jj][kk]-EZB[ii][jj]) * (VZ[ii][jj][kk]-VZB[ii][jj]);							
			}
	for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			dEdotJX[ii][jj] = dEdotJX[ii][jj] / nzn/ZLEN;
			dEdotJY[ii][jj] = dEdotJY[ii][jj] / nzn/ZLEN;
			dEdotJZ[ii][jj] = dEdotJZ[ii][jj] / nzn/ZLEN;
		}	
	
}

void averagedot(double** EdotJX, double** EdotJY, double** EdotJZ,
				double** dEdotJX, double** dEdotJY, double** dEdotJZ,
				double** sEdotJX, double** sEdotJY, double** sEdotJZ,
				double** EXB, double** EYB, double** EZB,
				double** VXB, double** VYB, double** VZB,
				double*** EX, double*** EY, double*** EZ,
				double*** VX, double*** VY, double*** VZ){
	
	for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			EdotJX[ii][jj] = EXB[ii][jj] * VXB[ii][jj];
			EdotJY[ii][jj] = EYB[ii][jj] * VYB[ii][jj];
			EdotJZ[ii][jj] = EZB[ii][jj] * VZB[ii][jj];
			dEdotJX[ii][jj] = 0.0;
			dEdotJY[ii][jj] = 0.0;
			dEdotJZ[ii][jj] = 0.0;
			sEdotJX[ii][jj] = 0.0;
			sEdotJY[ii][jj] = 0.0;
			sEdotJZ[ii][jj] = 0.0;
		}
	for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
			for (int ii=0; ii < nxn*XLEN;ii++){
				dEdotJX[ii][jj] += (EX[ii][jj][kk]-EXB[ii][jj]) * (VX[ii][jj][kk]-VXB[ii][jj]);
				dEdotJY[ii][jj] += (EY[ii][jj][kk]-EYB[ii][jj]) * (VY[ii][jj][kk]-VYB[ii][jj]);
				dEdotJZ[ii][jj] += (EZ[ii][jj][kk]-EZB[ii][jj]) * (VZ[ii][jj][kk]-VZB[ii][jj]);
			}
	for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			dEdotJX[ii][jj] = dEdotJX[ii][jj] / nzn/ZLEN;
			dEdotJY[ii][jj] = dEdotJY[ii][jj] / nzn/ZLEN;
			dEdotJZ[ii][jj] = dEdotJZ[ii][jj] / nzn/ZLEN;
		}
    for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
			for (int ii=0; ii < nxn*XLEN;ii++){
				sEdotJX[ii][jj] += pow(EX[ii][jj][kk] * VX[ii][jj][kk]
                                    - EdotJX[ii][jj] - dEdotJX[ii][jj], 2);
				sEdotJY[ii][jj] += pow(EY[ii][jj][kk] * VY[ii][jj][kk]
                                       - EdotJY[ii][jj] - dEdotJY[ii][jj], 2);
				sEdotJZ[ii][jj] += pow(EZ[ii][jj][kk] * VZ[ii][jj][kk]
                                       - EdotJZ[ii][jj] - dEdotJZ[ii][jj], 2);
            }
	for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			sEdotJX[ii][jj] = sqrt(sEdotJX[ii][jj] / nzn/ZLEN);
			sEdotJY[ii][jj] = sqrt(sEdotJY[ii][jj] / nzn/ZLEN);
			sEdotJZ[ii][jj] = sqrt(sEdotJZ[ii][jj] / nzn/ZLEN);
		}

}


void averagecross(double** CX, double** CY, double** CZ,
				double** dCX, double** dCY, double** dCZ,
				double** EXB, double** EYB, double** EZB,
				double** BXB, double** BYB, double** BZB,
				double*** EX, double*** EY, double*** EZ, 
				double*** BX, double*** BY, double*** BZ){
	
	cross(BXB,BYB,BZB,EXB,EYB,EZB,CX,CY,CZ);

	for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			dCX[ii][jj] = 0.0;
			dCY[ii][jj] = 0.0;
			dCZ[ii][jj] = 0.0;		
		}			
	for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
			for (int ii=0; ii < nxn*XLEN;ii++){

				dCX[ii][jj] += (EY[ii][jj][kk] - EYB[ii][jj]) *
                                               (BZ[ii][jj][kk] - BZB[ii][jj]) - 
                                               (EZ[ii][jj][kk] - EZB[ii][jj]) *
					       (BY[ii][jj][kk] - BYB[ii][jj]);
				
				dCY[ii][jj] += (EZ[ii][jj][kk] - EZB[ii][jj]) *
                                               (BX[ii][jj][kk] - BXB[ii][jj]) - 
                                               (EX[ii][jj][kk] - EXB[ii][jj]) *
					       (BZ[ii][jj][kk] - BZB[ii][jj]);

				dCZ[ii][jj] += (EX[ii][jj][kk] - EXB[ii][jj]) *
                                               (BY[ii][jj][kk] - BYB[ii][jj]) - 
                                               (EY[ii][jj][kk] - EYB[ii][jj]) *
					       (BX[ii][jj][kk] - BXB[ii][jj]);
			}
	for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			dCX[ii][jj] = dCX[ii][jj] / nzn/ZLEN;
			dCY[ii][jj] = dCY[ii][jj] / nzn/ZLEN;
			dCZ[ii][jj] = dCZ[ii][jj] / nzn/ZLEN;
		}	
	
}	


void averagecross(double** CX, double** CY, double** CZ,
                  double** dCX, double** dCY, double** dCZ,
                  double** sCX, double** sCY, double** sCZ,
                  double** EXB, double** EYB, double** EZB,
                  double** BXB, double** BYB, double** BZB,
                  double*** EX, double*** EY, double*** EZ,
                  double*** BX, double*** BY, double*** BZ){
	
	cross(BXB,BYB,BZB,EXB,EYB,EZB,CX,CY,CZ);
    
	for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			dCX[ii][jj] = 0.0;
			dCY[ii][jj] = 0.0;
			dCZ[ii][jj] = 0.0;
            sCX[ii][jj] = 0.0;
			sCY[ii][jj] = 0.0;
			sCZ[ii][jj] = 0.0;
		}
	for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
			for (int ii=0; ii < nxn*XLEN;ii++){
                
				dCX[ii][jj] += (EY[ii][jj][kk] - EYB[ii][jj]) *
                (BZ[ii][jj][kk] - BZB[ii][jj]) -
                (EZ[ii][jj][kk] - EZB[ii][jj]) *
                (BY[ii][jj][kk] - BYB[ii][jj]);
				
				dCY[ii][jj] += (EZ[ii][jj][kk] - EZB[ii][jj]) *
                (BX[ii][jj][kk] - BXB[ii][jj]) -
                (EX[ii][jj][kk] - EXB[ii][jj]) *
                (BZ[ii][jj][kk] - BZB[ii][jj]);
                
				dCZ[ii][jj] += (EX[ii][jj][kk] - EXB[ii][jj]) *
                (BY[ii][jj][kk] - BYB[ii][jj]) -
                (EY[ii][jj][kk] - EYB[ii][jj]) *
                (BX[ii][jj][kk] - BXB[ii][jj]);
			}
	for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			dCX[ii][jj] = dCX[ii][jj] / nzn/ZLEN;
			dCY[ii][jj] = dCY[ii][jj] / nzn/ZLEN;
			dCZ[ii][jj] = dCZ[ii][jj] / nzn/ZLEN;
		}
    for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
			for (int ii=0; ii < nxn*XLEN;ii++){
                
				sCX[ii][jj] += pow(EY[ii][jj][kk] * BZ[ii][jj][kk]  -
                                   EZ[ii][jj][kk] * BY[ii][jj][kk] - CX[ii][jj]
                                   -dCX[ii][jj],2);

                sCY[ii][jj] += pow(EZ[ii][jj][kk] * BX[ii][jj][kk]  -
                                   EX[ii][jj][kk] * BZ[ii][jj][kk] - CY[ii][jj]
                                   -dCY[ii][jj],2);

                sCZ[ii][jj] += pow(EX[ii][jj][kk] * BY[ii][jj][kk]  -
                                   EY[ii][jj][kk] * BX[ii][jj][kk] - CZ[ii][jj]
                                   -dCZ[ii][jj],2);
                
			}
    for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			sCX[ii][jj] = sqrt(sCX[ii][jj] / nzn/ZLEN);
			sCY[ii][jj] = sqrt(sCY[ii][jj] / nzn/ZLEN);
			sCZ[ii][jj] = sqrt(sCZ[ii][jj] / nzn/ZLEN);
		}

	
}


void average_energy(double** AVGENTH, double** AVGENIN, double** AVGJDOTE,
		double** STDENTH, double** STDENIN, double** STDJDOTE,
		double*** VDIVP, double*** DIVJV, double*** JDOTE){

	for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			AVGJDOTE[ii][jj] = 0.0;
			STDJDOTE[ii][jj] = 0.0;
			AVGENTH[ii][jj] = 0.0;
			AVGENIN[ii][jj] = 0.0;
			STDENTH[ii][jj] = 0.0;
			STDENIN[ii][jj] = 0.0;
		}

    for (int kk=1; kk < nzn*ZLEN-1;kk++)
		for (int jj=1; jj < nyn*YLEN-1;jj++)
			for (int ii=1; ii < nxn*XLEN-1;ii++){

				AVGENTH[ii][jj] += VDIVP[ii][jj][kk]  ;
				AVGENIN[ii][jj] += (JDOTE[ii][jj][kk] - VDIVP[ii][jj][kk])  ;
				AVGJDOTE[ii][jj] += JDOTE[ii][jj][kk]   ;
			}

    for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			AVGENTH[ii][jj] = AVGENTH[ii][jj] / (nzn*ZLEN-2);
			AVGENIN[ii][jj] = AVGENIN[ii][jj] / (nzn*ZLEN-2);
			AVGJDOTE[ii][jj] = AVGJDOTE[ii][jj] / (nzn*ZLEN-2);
		}


    for (int kk=1; kk < nzn*ZLEN-1;kk++)
		for (int jj=1; jj < nyn*YLEN-1;jj++)
			for (int ii=1; ii < nxn*XLEN-1;ii++){

				STDENTH[ii][jj] += pow(VDIVP[ii][jj][kk]  - AVGENTH[ii][jj],2);
				STDENIN[ii][jj] += pow(JDOTE[ii][jj][kk] - VDIVP[ii][jj][kk]  - AVGENIN[ii][jj],2);
				STDJDOTE[ii][jj] += pow(JDOTE[ii][jj][kk]  - AVGJDOTE[ii][jj],2);

			}
    for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			STDENTH[ii][jj] = sqrt(STDENTH[ii][jj] / (nzn*ZLEN-2));
			STDENIN[ii][jj] = sqrt(STDENIN[ii][jj] / (nzn*ZLEN-2));
			STDJDOTE[ii][jj] = sqrt(STDJDOTE[ii][jj] / (nzn*ZLEN-2));
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


void cross(double** BX, double** BY, double** BZ, 
		   double** EX, double** EY, double** EZ, 
		   double** VXBX, double** VXBY, double** VXBZ){
		for (int jj=0; jj < nyn*YLEN;jj++)
			for (int ii=0; ii < nxn*XLEN;ii++){
				VXBX[ii][jj] = (EY[ii][jj]*BZ[ii][jj] - EZ[ii][jj]*BY[ii][jj]);
				VXBY[ii][jj] = (EZ[ii][jj]*BX[ii][jj] - EX[ii][jj]*BZ[ii][jj]);
				VXBZ[ii][jj] = (EX[ii][jj]*BY[ii][jj] - EY[ii][jj]*BX[ii][jj]);
				
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

void zenitani(double*** NE, double*** NI, 
 		 double*** BX, double*** BY, double*** BZ, 
		 double*** EX, double*** EY, double*** EZ, 
		 double*** JEX, double*** JEY, double*** JEZ,
		 double*** JIX, double*** JIY, double*** JIZ,
		 double*** DE, double*** DI){
	for (int kk=0; kk < nzn*ZLEN;kk++)
		for (int jj=0; jj < nyn*YLEN;jj++)
			for (int ii=0; ii < nxn*XLEN;ii++){
				
// Compute E + ve x B
				double OHMEX = EX[ii][jj][kk]  + 
				(JEY[ii][jj][kk]*BZ[ii][jj][kk] - JEZ[ii][jj][kk]*BY[ii][jj][kk]) / NE[ii][jj][kk];
				
				double OHMEY = EY[ii][jj][kk]  +
				(JEZ[ii][jj][kk]*BX[ii][jj][kk] - JEX[ii][jj][kk]*BZ[ii][jj][kk]) / NE[ii][jj][kk];
				
				double OHMEZ = EZ[ii][jj][kk]  +
				(JEX[ii][jj][kk]*BY[ii][jj][kk] - JEY[ii][jj][kk]*BX[ii][jj][kk]) / NE[ii][jj][kk];

// compute E + vi x B
				double OHMIX = EX[ii][jj][kk]  + 
				(JIY[ii][jj][kk]*BZ[ii][jj][kk] - JIZ[ii][jj][kk]*BY[ii][jj][kk]) / NI[ii][jj][kk];
				
				double OHMIY = EY[ii][jj][kk]  +
				(JIZ[ii][jj][kk]*BX[ii][jj][kk] - JIX[ii][jj][kk]*BZ[ii][jj][kk]) / NI[ii][jj][kk];
				
				double OHMIZ = EZ[ii][jj][kk]  +
				(JIX[ii][jj][kk]*BY[ii][jj][kk] - JIY[ii][jj][kk]*BX[ii][jj][kk]) / NI[ii][jj][kk];

// Compute rho_net
				double rhonet= NE[ii][jj][kk] + NI[ii][jj][kk];

// Compute De
				DE[ii][jj][kk] = (JEX[ii][jj][kk] + JIX[ii][jj][kk]) * OHMEX +
						 (JEY[ii][jj][kk] + JIY[ii][jj][kk]) * OHMEY +
						 (JEZ[ii][jj][kk] + JIZ[ii][jj][kk]) * OHMEZ -
						 rhonet * ( JEX[ii][jj][kk] * EX[ii][jj][kk] + JEY[ii][jj][kk] * EY[ii][jj][kk] + JEZ[ii][jj][kk] * EZ[ii][jj][kk]) / NE[ii][jj][kk]; 
				
// Compute Di
				DI[ii][jj][kk] = (JEX[ii][jj][kk] + JIX[ii][jj][kk]) * OHMIX +
						 (JEY[ii][jj][kk] + JIY[ii][jj][kk]) * OHMIY +
						 (JEZ[ii][jj][kk] + JIZ[ii][jj][kk]) * OHMIZ -
						 rhonet * ( JIX[ii][jj][kk] * EX[ii][jj][kk] + JIY[ii][jj][kk] * EY[ii][jj][kk] + JIZ[ii][jj][kk] * EZ[ii][jj][kk]) / NI[ii][jj][kk]; 

			}
}




void extract_pressure(double qom, double*** BX, double*** BY, double*** BZ,
					  double*** VX, double*** VY, double*** VZ,
					  double*** N, double*** pXX, double*** pXY,
					  double*** pXZ, double*** pYY, double*** pYZ, double*** pZZ,
					  double*** pPAR, double*** pPER1, double*** pPER2, double*** EPS) {
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
				
				double b2D = 1e-10 + BX[ii][jj][kk]*BX[ii][jj][kk] + BY[ii][jj][kk]*BY[ii][jj][kk];
				double b = b2D + BZ[ii][jj][kk]*BZ[ii][jj][kk];
				double perp2x = BZ[ii][jj][kk]*BX[ii][jj][kk] /sqrt(b*b2D);
				double perp2y = BZ[ii][jj][kk]*BY[ii][jj][kk] /sqrt(b*b2D);
				double perp2z = -sqrt(b2D/b);
				
				pPAR[ii][jj][kk] = BX[ii][jj][kk]*pXX[ii][jj][kk]*BX[ii][jj][kk] + 
				2*BX[ii][jj][kk]*pXY[ii][jj][kk]*BY[ii][jj][kk] + 
				2*BX[ii][jj][kk]*pXZ[ii][jj][kk]*BZ[ii][jj][kk];
				pPAR[ii][jj][kk]+= BY[ii][jj][kk]*pYY[ii][jj][kk]*BY[ii][jj][kk] + 
				2*BY[ii][jj][kk]*pYZ[ii][jj][kk]*BZ[ii][jj][kk];
				pPAR[ii][jj][kk]+= BZ[ii][jj][kk]*pZZ[ii][jj][kk]*BZ[ii][jj][kk];
				
				pPAR[ii][jj][kk] = pPAR[ii][jj][kk]/b;
				
				pPER1[ii][jj][kk] = BY[ii][jj][kk]*pXX[ii][jj][kk]*BY[ii][jj][kk] - 
				2*BY[ii][jj][kk]*pXY[ii][jj][kk]*BX[ii][jj][kk];
				pPER1[ii][jj][kk]+= BX[ii][jj][kk]*pYY[ii][jj][kk]*BX[ii][jj][kk];
				
				pPER1[ii][jj][kk] = pPER1[ii][jj][kk]/b2D;
				
				pPER2[ii][jj][kk] = perp2x*pXX[ii][jj][kk]*perp2x + 2*perp2x*pXY[ii][jj][kk]*perp2y + 2*perp2x*pXZ[ii][jj][kk]*perp2z;
				pPER2[ii][jj][kk]+= perp2y*pYY[ii][jj][kk]*perp2y + 2*perp2y*pYZ[ii][jj][kk]*perp2z;
				pPER2[ii][jj][kk]+= perp2z*pZZ[ii][jj][kk]*perp2z;  
				
				EPS[ii][jj][kk] = 1.0 - 4.0* M_PI * ( pPAR[ii][jj][kk] - sqrt(pPER1[ii][jj][kk] * pPER2[ii][jj][kk] ) ) / b;
				
			}
}


void divergence(double*** div, double*** EX, double*** EY, double*** EZ){
  
 for (int kk=0; kk < nzn*ZLEN;kk++)
	for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			    
		div[ii][jj][kk] = 0.0;
			}
  
 if(nzn*ZLEN==1) {
     int kk=0;
    	for (int jj=1; jj < nyn*YLEN-1;jj++)
    		for (int ii=1; ii < nxn*XLEN-1;ii++){

    		div[ii][jj][kk] = (EX[ii+1][jj][kk] - EX[ii-1][jj][kk])/2.0/Dx +
    			              (EY[ii][jj+1][kk] - EY[ii][jj-1][kk])/2.0/Dy ;
    			}
 }
 else
 {
 for (int kk=1; kk < nzn*ZLEN-1;kk++)
	for (int jj=1; jj < nyn*YLEN-1;jj++)
		for (int ii=1; ii < nxn*XLEN-1;ii++){
			    
		div[ii][jj][kk] = (EX[ii+1][jj][kk] - EX[ii-1][jj][kk])/2.0/Dx +
			              (EY[ii][jj+1][kk] - EY[ii][jj-1][kk])/2.0/Dy +
				          (EZ[ii][jj][kk+1] - EZ[ii][jj][kk-1])/2.0/Dz;
			}
 }
}  

// Computes div( E VSQ /2)
void divj(double qom, double*** divj,
          double*** EX, double*** EY, double*** EZ, double*** VSQ){
  
 for (int kk=0; kk < nzn*ZLEN;kk++)
	for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			    
		divj[ii][jj][kk] = 0.0;
			}
  
 if(nzn*ZLEN==1) {
     int kk=0;
    	for (int jj=1; jj < nyn*YLEN-1;jj++)
    		for (int ii=1; ii < nxn*XLEN-1;ii++){


    		divj[ii][jj][kk] = (EX[ii+1][jj][kk] * VSQ[ii+1][jj][kk] - EX[ii-1][jj][kk] * VSQ[ii-1][jj][kk])/ 4.0/ Dx/ qom +
    			               (EY[ii][jj+1][kk] * VSQ[ii][jj+1][kk] - EY[ii][jj-1][kk] * VSQ[ii][jj-1][kk])/ 4.0/ Dy/ qom ;
    			}
     }
     else
     {
 for (int kk=1; kk < nzn*ZLEN-1;kk++)
	for (int jj=1; jj < nyn*YLEN-1;jj++)
		for (int ii=1; ii < nxn*XLEN-1;ii++){
			    
		
		divj[ii][jj][kk] = (EX[ii+1][jj][kk] * VSQ[ii+1][jj][kk] - EX[ii-1][jj][kk] * VSQ[ii-1][jj][kk])/ 4.0/ Dx/ qom +
			               (EY[ii][jj+1][kk] * VSQ[ii][jj+1][kk] - EY[ii][jj-1][kk] * VSQ[ii][jj-1][kk])/ 4.0/ Dy/ qom +
				           (EZ[ii][jj][kk+1] * VSQ[ii][jj][kk+1] - EZ[ii][jj][kk-1] * VSQ[ii][jj][kk-1])/ 4.0/ Dz/ qom;
			}
     }
}  

void dot(double*** dot,  
          double*** AX, double*** AY, double*** AZ, 
          double*** BX, double*** BY, double*** BZ){
  
 for (int kk=0; kk < nzn*ZLEN;kk++)
	for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			    
		dot[ii][jj][kk] = 0.0;
			}
  
 for (int kk=0; kk < nzn*ZLEN;kk++)
	for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			    
		
		dot[ii][jj][kk] = AX[ii][jj][kk] * BX[ii][jj][kk] + 
						  AY[ii][jj][kk] * BY[ii][jj][kk] + 
						  AZ[ii][jj][kk] * BZ[ii][jj][kk] ;
			}
  
}  

void dot(double*** dot,  
          double*** AX, double*** AY, double*** AZ, 
          double*** BX, double*** BY, double*** BZ, double*** RHO){
  
 for (int kk=0; kk < nzn*ZLEN;kk++)
	for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			    
		dot[ii][jj][kk] = 0.0;
			}
  
 for (int kk=0; kk < nzn*ZLEN;kk++)
	for (int jj=0; jj < nyn*YLEN;jj++)
		for (int ii=0; ii < nxn*XLEN;ii++){
			    
		
		dot[ii][jj][kk] = AX[ii][jj][kk] * BX[ii][jj][kk] /pow(RHO[ii][jj][kk],2)+ 
						  AY[ii][jj][kk] * BY[ii][jj][kk] /pow(RHO[ii][jj][kk],2)+ 
						  AZ[ii][jj][kk] * BZ[ii][jj][kk] /pow(RHO[ii][jj][kk],2);
			}
  
}  


void vdiv(double*** vdiv, double*** PXX, double*** PYY, double*** PZZ,
                         double*** PXY, double*** PXZ, double*** PYZ,
                         double*** RHO, 
                         double*** JX, double*** JY, double*** JZ){
    
    for (int kk=0; kk < nzn*ZLEN;kk++)
        for (int jj=0; jj < nyn*YLEN;jj++)
            for (int ii=0; ii < nxn*XLEN;ii++){
			    
                vdiv[ii][jj][kk] = 0.0;
			}
    if(nzn*ZLEN==1) {
        int kk=0;
            for (int jj=1; jj < nyn*YLEN-1;jj++)
                for (int ii=1; ii < nxn*XLEN-1;ii++){

                    vdiv[ii][jj][kk] = ((PXX[ii+1][jj][kk] - PXX[ii-1][jj][kk])/2.0/Dx +
                                        (PXY[ii][jj+1][kk] - PXY[ii][jj-1][kk])/2.0/Dy ) *
                                        JX[ii][jj][kk] / RHO[ii][jj][kk];


                    vdiv[ii][jj][kk] += ((PXY[ii+1][jj][kk] - PXY[ii-1][jj][kk])/2.0/Dx +
                                        (PYY[ii][jj+1][kk] - PYY[ii][jj-1][kk])/2.0/Dy ) *
                                        JY[ii][jj][kk] / RHO[ii][jj][kk];


                    vdiv[ii][jj][kk] += ((PXZ[ii+1][jj][kk] - PXZ[ii-1][jj][kk])/2.0/Dx +
                                        (PYZ[ii][jj+1][kk] - PYZ[ii][jj-1][kk])/2.0/Dy ) *
                                        JZ[ii][jj][kk] / RHO[ii][jj][kk];
    			}

    }
    else
    {
    for (int kk=1; kk < nzn*ZLEN-1;kk++)
        for (int jj=1; jj < nyn*YLEN-1;jj++)
            for (int ii=1; ii < nxn*XLEN-1;ii++){
			    
                vdiv[ii][jj][kk] = ((PXX[ii+1][jj][kk] - PXX[ii-1][jj][kk])/2.0/Dx +
                                    (PXY[ii][jj+1][kk] - PXY[ii][jj-1][kk])/2.0/Dy +
                                    (PXZ[ii][jj][kk+1] - PXZ[ii][jj][kk-1])/2.0/Dz) *
                                    JX[ii][jj][kk] / RHO[ii][jj][kk];
                                    
                                    
                vdiv[ii][jj][kk] += ((PXY[ii+1][jj][kk] - PXY[ii-1][jj][kk])/2.0/Dx +
                                    (PYY[ii][jj+1][kk] - PYY[ii][jj-1][kk])/2.0/Dy +
                                    (PYZ[ii][jj][kk+1] - PYZ[ii][jj][kk-1])/2.0/Dz) *
                                    JY[ii][jj][kk] / RHO[ii][jj][kk];
                                    
                                    
                vdiv[ii][jj][kk] += ((PXZ[ii+1][jj][kk] - PXZ[ii-1][jj][kk])/2.0/Dx +
                                    (PYZ[ii][jj+1][kk] - PYZ[ii][jj-1][kk])/2.0/Dy +
                                    (PZZ[ii][jj][kk+1] - PZZ[ii][jj][kk-1])/2.0/Dz) *
                                    JZ[ii][jj][kk] / RHO[ii][jj][kk];
			}
    }
}  

double vecpot(double*** AZ, double*** BX, double*** BY, double*** BZ){
    for (int kk=0; kk < nzn*ZLEN;kk++){
    	AZ[0][0][kk] = 0.0;
        for (int jj=0; jj < nyn*YLEN;jj++)
        {
            for (int ii=1; ii < nxn*XLEN;ii++){

                AZ[ii][jj][kk] = AZ[ii-1][jj][kk] - (BY[ii][jj][kk] + BY[ii][jj][kk])*Dx/2.0;
			}
         AZ[0][jj+1][kk] = AZ[0][jj][kk] + (BX[0][jj][kk] + BX[0][jj+1][kk])*Dy/2.0;
    }
}
    double maxmax = -1.0e10;
    double minmax = 1.0e10;
    for (int kk=0; kk < nzn*ZLEN;kk++)
            for (int ii=1; ii < nxn*XLEN;ii++){
            	double maxAz =0.0;
            	for (int jj=0; jj < nyn*YLEN;jj++){
            		if (AZ[ii][jj][kk] > maxAz) maxAz = AZ[ii][jj][kk];
			}
         if(maxAz < minmax) minmax = maxAz;
         if(maxAz > maxmax) maxmax = maxAz;
     }
    double recflux = maxmax-minmax;
    cout << "RecFlux = " << recflux << endl;
    //cout << "RecFlux = " << maxmax << "    " << minmax << endl;
    return(recflux);
}
