function [matrixcar,Station]=dogde(matrixcar,Station,areaStation,timechange,length)
    %matrixcar
    namecar=1;
    toStation=3;
    indogde=9;
    %Station
    directStation=2;
    timeofStation=3;
    carsinStation=4;
    willinStation=5;
    
    [soxe,~]=size(matrixcar);
    [stationsize,~]=size(Station);
    for station=1:stationsize
        if Station(station,willinStation)>0
            if Station(station,carsinStation)==0
                for car=1:soxe
                    if matrixcar(car,namecar)==Station(station,willinStation)
                        imatrixcar=matrixcar(car,:);
                        imatrixcar(toStation)=station;
                        if checkStation(imatrixcar,areaStation/2,length,Station)==1
                            matrixcar(car,indogde)=station;
                            Station(station,carsinStation)=matrixcar(car,namecar);
                            Station(station,willinStation)=0;
                            Station(station,timeofStation)=Station(station,timeofStation)-1;
                            Station(station,directStation)=1;
                        end
                        break;
                    else
                        continue;
                    end
                end
            else
                if Station(station,directStation)==1
                    for car=1:soxe
                        if matrixcar(car,namecar)==Station(station,carsinStation)
                            if matrixcar(car,indogde)==1
                                Station(station,timeofStation)=Station(station,timeofStation)-1;
                                if Station(station,timeofStation)==0
                                    Station(station,timeofStation)=timechange;
                                    Station(station,directStation)=-1;
                                end
                            else
                                continue;
                            end
                            break;
                        else
                            continue;
                        end
                    end
                else
                    continue;
                end
            end
        end
    end
    
end