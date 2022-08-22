clc;clear all;
syms t;


% matrixcar is the matrix which shows the state of the vehicle system
% row in matrixcar is the priority of the vehicles when performing the task
% column in matrixcar is:
% 1: name of car
% 2: location of the car
% 3: toSation is the location of car need to go
% 4: battery of that car
% 5: goods of that car ( car has good is 1 or not is 0)
% 6: time of car need to complete the unloading or loading
% 7: action of the car divide into 6 level:
    %level -5 is the highest: the car is charging in the station
    %level -4 is the car is loading or unloading
    %level -3 is the emergency car ( the car has battery is lower an danger)
    %level -2 is the car need to charge (the car has battery is lower tha limit battery
    %level -1 is the car delivery
    %level 0 is the car don't have work to do
% 8: the direction of the car

% matrixcar
column=9;
namecar=1;
location=2;
toStation=3;
battery=4; batterylimit=20; batterymax=100; batterysafe=50; batteryperunit=1;
good=5;
time=6; timeload=3;timeunload=3;
action=7;
    carstop=-4;
direction=8;
indogde=9;

% matrixwait is the matrix which shows the orders of the customers
% row in matrixcar is the priority of the tasks the car needs to do
% column of the matrixwait
% 1: the loadStation
% 2: the unloadStation
% 3: name of car do that job
% 4: name of car chosen to do that job( can be changed by the time)
loadStation=1;
unloadStation=2;
cardojob=3;
carchosen=4;

%Station is the matrix which show the action of the stations on map
%row in Station is the priority of the station
%column in Station 
% 1: location of that station
% 2: which direction of the railway
% 3: time to do job of station
% 4: name of car in that Station
% 5: name of car will go to that Station to dodge
locateStation=1;
directStation=2;
timeofStation=3;
carsinStation=4;
willinStation=5;


%create the data input ( soxe and the length of route,speed of the car, location of Station)
% soxe=input("enter the number of the car: ");
% length=input("enter the length of the route(mm): ");
% speed=input("enter the speed of car(mm/unit): ");
% lengthcar=input("enter the length of car (mm): ");
% areaStation=input("enter the length of roal way in Station: ");
% soport=input("enter the number of Station: ");
% timechange=input("enter the time change the roalway(unit): ");
% safearea=speed+lengthcar;
soxe=3;
length=3000+1200*pi;
speed=250;
lengthcar=250;
areaStation=300;
safearea=lengthcar+60+speed;
minarea=lengthcar+60;
soport=3;
timechange=12;
Station=zeros(soport,5);
for i=1:soport
%    Station(i,locateStation)=fix(length*(i-1)/soport);
%    Station(i,locateStation)=input(' nhap toa do station' );
   Station(i,timeofStation)=timechange;
end
Station(1,locateStation)=0;
Station(2,locateStation)=1500+600*pi;
Station(3,locateStation)=2500+900*pi;
%
%we meed to enter the location of Station but we do easy

%create the matrixcar
matrixcar=zeros(soxe,column);
for i=1:soxe
    matrixcar(i,namecar)=i;
    matrixcar(i,location)=fix(length/soxe*(i-1));
    matrixcar(i,battery)=randi(100);
    matrixcar(i,time)=timeload;
end
%create matrixwait
matrixwait=zeros(soxe,4);
for i=1:soxe
    matrixwait(i,loadStation)=randi(soport);
    matrixwait(i,unloadStation)=randi(soport);
    while(matrixwait(i,loadStation)==matrixwait(i,unloadStation))
        matrixwait(i,unloadStation)=mod(randi(1000),soport)+1;
    end
end
t=0;
%do job
 while (t<1000)
    
    %check battery
     matrixcar=checkbattery(matrixcar,batterylimit);
    %find the station to battery
     matrixcar=chargeStation(matrixcar,Station,length);
    %get car go to chargeStation
    [matrixcar,Station]=gocharge(matrixcar,Station,areaStation,length,timechange);
    %make car unloading
    [matrixcar,Station]=unloading(matrixcar,Station,length,areaStation,timechange,timeload);
    %find car free for matrixwait
    [matrixcar,matrixwait]=findcarmission(matrixcar,matrixwait,Station,length);
    %make car loading
    [matrixcar,matrixwait,Station]=loading(matrixcar,matrixwait,Station,length,areaStation,timechange,timeunload,soport,timeload);
    %find the station to battery
    matrixcar=chargeStation(matrixcar,Station,length);
    %get car go to chargeStation
    [matrixcar,Station]=gocharge(matrixcar,Station,areaStation,length,timechange);
    %go to dogde
    [matrixcar,Station]=dogde(matrixcar,Station,areaStation,timechange,length);
    %charging car
    [matrixcar,Station]=charging(matrixcar,Station,timechange,batterymax,batteryperunit);
    %out from Station
    [matrixcar,Station]=outStation(matrixcar,Station,batterysafe,timechange,length,areaStation);
    for i=1:soxe
        if matrixcar(i,action)>carstop
            matrixcar(i,direction)=0;
        end
    end
    for i=1:soport
        Station(i,willinStation)=0;
    end
    %do run
    [matrixcar,matrixwait,Station]=cardirection(matrixcar,matrixwait,Station,length,safearea,speed,timechange,areaStation);
    %change location
     matrixcar=changelocation(matrixcar,Station,length,speed,areaStation,minarea);
     %draw map
       drawmap();
       %add station on map
       hold on;
       axis([-1500 1500 -1500 1500]);
       drawStation(length,soport,areaStation,timechange,Station);
       drawcaronmap(matrixcar,length);
       hold off;
     matrixcar
     Station
     matrixwait
     pause(1);
     t=t+1;  
 end