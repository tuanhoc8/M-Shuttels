function [matrixcar,Station]=gocharge(matrixcar,Station,areaStation,length,timechange)
    %Station
    locateStation=1;
    directStation=2;
    timeofStation=3;
    carsinStation=4;
    %matrixcar
    namecar=1;
    location=2;
    toStation=3;
    action=7;
        carneedcharge=-2;
        carcharge=-5;
    [soxe,~]=size(matrixcar);
    
    checkaction=0; 
    for car=1:soxe
        if matrixcar(car,action)==carcharge
            if Station(matrixcar(car,toStation),directStation)==1
                if Station(matrixcar(car,toStation),timeofStation)>0
                    Station(matrixcar(car,toStation),timeofStation)=Station(matrixcar(car,toStation),timeofStation)-1;
                else
                    Station(matrixcar(car,toStation),directStation)=-1;
                    Station(matrixcar(car,toStation),timeofStation)=timechange;
                end
            else
                continue;
            end
        elseif matrixcar(car,action)==carneedcharge
            if checkStation(matrixcar(car,:),areaStation/2,length,Station)==1
                matrixcar(car,location)=Station(matrixcar(car,toStation),locateStation);
                Station(matrixcar(car,toStation),carsinStation)=matrixcar(car,namecar);
                Station(matrixcar(car,toStation),timeofStation)=Station(matrixcar(car,toStation),timeofStation)-1;
                Station(matrixcar(car,toStation),directStation)=1;
                matrixcar(car,action)=carcharge;
                checkaction=1;
            else
                continue;
            end
        elseif matrixcar(car,action)>carneedcharge
            break;
        else
            continue
        end
    end
    
    if checkaction==1
        matrixcar=sortmatrix(matrixcar);
    end

end