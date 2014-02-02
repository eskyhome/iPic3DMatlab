cd /home/gianni/Documents/workspace/Parsek2D/results/

cp ~/Desktop/parsek/Makefile .
cp -f ~/Desktop/parsek/readint.m .
cp -f ~/Desktop/parsek/secxzA.m .
cp -f ~/Desktop/parsek/secxzB.m .
#cp -f ~/Desktop/parsek/secxzAbu.m .
cp -f ~/Desktop/parsek/secxzC.m .
cp -f ~/Desktop/parsek/secxzD.m .
cp -f ~/Desktop/parsek/flightt.m .
cp -f ~/Desktop/parsek/flighttplot.m .
make clean
mkdir film1
mkdir film2
mkdir film3
mkdir film4
mkdir film5
mkdir film6
mkdir film7
mkdir film8
mkdir film9
mkdir film10
mkdir film11
mkdir film12
mkdir Bfilm1
mkdir Bfilm2
mkdir Bfilm3
mkdir Bfilm4
mkdir Bfilm5
mkdir Cfilm1
mkdir Cfilm2
mkdir Cfilm3
mkdir Cfilm4
mkdir Cfilm5
mkdir Cfilm6
mkdir Dfilm1
mkdir Dfilm2
mkdir Dfilm3

unset DISPLAYntime

echo "starting matlab"
/usr/local/matlab74/bin/matlab > matlab.out  2>&1 << EOF
results_dir=''
indexg=1;
flight_counter=0;
for reader_counter=1:5
time_counter_list=reader_counter
%for reader_counter=1:5/2
%time_counter_list=(reader_counter-1)*2+[1 2]
readint;
flightt;
secxzA;
secxzB;
secxzC;
secxzD;
indexg=indexf;
end

flighttplot;
exit
EOF
