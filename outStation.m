function [matrixcar,Station]=outStation(matrixcar,Station,batterysafe,timechange,length,areaStation)
    [soxe,~]=size(matrixcar);
    [stationsize,~]=size(Station);
    %matrixcar
    namecar=1;
    location=2;

    battery=4;
    good=5;
    
    action=7;
        carstop=-4;
        cardelivery=-1;
        carfree=0;
    direction=8;
    indogde=9;
    %Station
    locateStation=1;
    directStation=2;
    timeofStation=3;
    carsinStation=4;
    
    checkaction=0;
    for car=1:soxe
        if matrixcar(car,action)>carstop
            if matrixcar(car,indogde)~=0
                if Station(matrixcar(car,indogde),directStation)==-1
                    if Station(matrixcar(car,indogde),timeofStation)==timechange
                        if matrixcar(car,direction)~=0
                            Station(matrixcar(car,indogde),timeofStation)=Station(matrixcar(car,indogde),timeofStation)-1;
                        elseif matrixcar(car,toStation)==0
                            if matrixcar(car,battery)<batterysafe
                            else
                                checkcar=0;
                                for carcheck=1:soxe
                                    if matrixcar(carcheck,action)<=carstop
                                        continue;
                                    else
                                        if carcheck==car
                                            continue;
                                        else
                                            imatrixcar=matrixcar(carcheck,:);
                                            imatrixcar(toStation)=matrixcar(car,indogde);
                                            if checkStation(imatrixcar,areaStation/2,length,Station)==1
                                                checkcar=1;
                                                break;
                                            else
                                                continue;
                                            end
                                        end
                                    end
                                end
                                if checkcar==1
                                    continue;
                                else 
                                    Station(matrixcar(car,indogde),timeofStation)=Station(matrixcar(car,indogde),timeofStation)-1;
                                end
                            end
                        else
                            continue;
                        end
                    else
                        Station(matrixcar(car,indogde),timeofStation)=Station(matrixcar(car,indogde),timeofStation)-1;
                        if Station(matrixcar(car,indogde),timeofStation)==0
                            Station(matrixcar(car,indogde),directStation)=0;
                            Station(matrixcar(car,indogde),timeofStation)=timechange;
                            Station(matrixcar(car,indogde),carsinStation)=0;
                            matrixcar(car,indogde)=0;
                        end
                    end
                else
                    continue;
                end
            else
                continue;
            end
        else
            for station=1:stationsize
                if matrixcar(car,namecar)==Station(station,carsinStation)
                    break;
                end
            end
            if Station(station,directStation)==-1 
                if Station(station,timeofStation)==timechange
                    if matrixcar(car,battery)<batterysafe
                        continue;
                    else
                        check=0;
                        if Station(station,locateStation)+areaStation/2>length
                            locateup=Station(station,locateStation)+areaStation/2-length;
                        else
                            locateup=Station(station,locateStation)+areaStation/2;
                        end
                        if Station(station,locateStation)-areaStation/2<0
                            locatedown=Station(station,locateStation)-areaStation/2+length;
                        else
                            locatedown=Station(station,locateStation)-areaStation/2;
                        end
                        for checkcar=car:soxe
                            if matrixcar(checkcar,action)>carstop
                                if locateup>locatedown
                                    if matrixcar(checkcar,location)>=locatedown && matrixcar(checkcar,location)<=locateup
                                        check=1;
                                        break;
                                    else
                                        continue;
                                    end
                                else
                                    if matrixcar(checkcar,location)>=locatedown||matrixcar(checkcar,location)<=locateup
                                        check=1;
                                        break;
                                    else
                                        continue;
                                    end
                                end
                            else
                                continue;
                            end
                        end
                        if check==1
                            continue;
                        else
                            Station(station,timeofStation)=Station(station,timeofStation)-1;
                        end
                    end
                elseif Station(station,timeofStation)>0 && Station(station,timeofStation)<timechange
                    Station(station,timeofStation)=Station(station,timeofStation)-1;
                else
                    matrixcar(car,location)=Station(station,locateStation);
                    if matrixcar(car,good)==1
                        matrixcar(car,action)=cardelivery;
                    else
                        matrixcar(car,action)=carfree;
                    end
                    checkaction=1;
                    Station(station,directStation)=0;
                    Station(station,timeofStation)=timechange;
                    Station(station,carsinStation)=0;
                    for k=car:soxe-1
                        b=matrixcar(k+1,:);
                        matrixcar(k+1,:)=matrixcar(k,:);
                        matrixcar(k,:)=b;
                    end
                end
            end
        end
    end
    if checkaction==1
        matrixcar=sortmatrix(matrixcar);
    end
    
    
end