function [checkaccept,timecanrun]=acceptStation(matrixcarcheck,Station,speed,length,timechange,areaStation)
    %matrixcarcheck
    location=2;
    toStation=3;
    direction=8;
    %Station
    directStation=2;
    timeofStation=3;
    timecanrun=0;
    if matrixcarcheck(toStation)==0
        checkaccept=1;
        return;
    end
    locatenow=matrixcarcheck(location);
    direct=matrixcarcheck(direction);
    if locatenow-direct*speed>length
        locatenow=locatenow-direct*speed-length;
    elseif locatenow-direct*speed<0
        locatenow=locatenow-direct*speed+length;
    else
        locatenow=locatenow-direct*speed;
    end
    
    imatrixcar=matrixcarcheck;
    imatrixcar(location)=locatenow;
    station=imatrixcar(toStation);
    if checkStation(imatrixcar,areaStation/2,length,Station)==1
        if Station(station,directStation)==0
            checkaccept=1;
            return;
        elseif Station(station,directStation)==-1
            checkaccept=0;
            timecanrun=Station(station,timeofStation);
            return;
        else
            checkaccept=0;
            timecanrun=timechange;
            return;
        end
    else
        checkaccept=1;
        return;
    end
        
end