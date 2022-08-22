function [matrixcar,Station,hadrun,waycar]=dogding(matrixcar,Station,hadrun,waycar,waycheck,furlocate,length,areaStation,timechange)
    %namecar in waycheck is row that car in matrixcar
    %matrixcar
    namecar=1;
    location=2;
    toStation=3;
    direction=8;
    %Station
    locateStation=1;
    carsinStation=4;
    willinStation=5;
    [numcar,~]=size(waycheck);
    [stationsize,~]=size(Station);
    checkok=0;
    if numcar==1
        slot=dontslot(waycar(:,namecar));
        for i=1:furlocate
            waycar(slot,i)=waycheck(1,i);
        end
        return;
    end
    for car=2:numcar
        imatrixcar=matrixcar(waycheck(car,namecar),:);
        if imatrixcar(toStation)==0
            continue;
        else
            imatrixcar=nearestdirect(imatrixcar,Station,length);
        end
        
        if imatrixcar(direction)==matrixcar(waycheck(1,namecar),direction)
            continue;
        else
            %kiemtra co xe nao dag nam tren Station ko co xe xai hay khong?
            for station=1:stationsize
                if Station(station,locateStation)+areaStation/2>length
                    stationup=Station(station,locateStation)+areaStation/2-length;
                else
                    stationup=Station(station,locateStation)+areaStation/2;
                end
                if Station(station,locateStation)-areaStation/2<0
                    stationdown=Station(station,locateStation)-areaStation/2+length;
                else
                    stationdown=Station(station,locateStation)-areaStation/2;
                end
                locate=matrixcar(waycheck(car,namecar),location);
                
                if stationup>stationdown
                    if locate<=stationup &&locate>=stationdown
                        if Station(station,carsinStation)==0 && Station(station,willinStation)==0
                            checkok=1;
                            break;
                        else
                            continue;
                        end
                    else
                        continue;
                    end
                else
                    if locate<=stationup||locate>=stationdown
                        if Station(station,carsinStation)==0 && Station(station,willinStation)==0
                            checkok=1;
                            break;
                        else
                            continue;
                        end
                    else
                        continue;
                    end
                end
            end
        end
    end
    if checkok==1
        for i=1:car
            matrixcar(waycheck(i,namecar),direction)=0;
            slot=dontslot(waycar(:,namecar));
            for j=1:timechange
                waycar(slot,2+j)=matrixcar(waycheck(i,namecar),location);
            end
            if i>1
                slot=dontslot(hadrun);
                hadrun(slot)=waycheck(i,namecar);
            end
        end
    else
        for i=1:numcar
            matrixcar(waycheck(i,namecar),direction)=matrixcar(waycheck(1,namecar),direction);
            slot=dontslot(waycar(:,namecar));
            for j=1:furlocate
                waycar(slot,j)=waycheck(i,j);
            end
            if i>1
                slot=dontslot(hadrun);
                hadrun(slot)=waycheck(i,namecar);
            end
        end
    end
end