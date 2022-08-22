function [matrixcar,Station]=charging(matrixcar,Station,timechange,batterymax,batteryperunit)
    %matrixcar
    namecar=1;
    toStation=3;
    battery=4;
    action=7;
    carcharge=-5;
    
    %Station
    directStation=2;
    timeofStation=3;
    carsinStation=4;
    [soxe,~]=size(matrixcar);
    [stationsize,~]=size(Station);
    for station=1:stationsize
        if (Station(station,timeofStation)==timechange && Station(station,directStation)==-1)||(Station(station,timeofStation)==0 && Station(station,directStation)==1)
            for car=1:soxe
                if matrixcar(car,namecar)==Station(station,carsinStation)
                    if matrixcar(car,battery)+batteryperunit>batterymax
                        matrixcar(car,battery)=batterymax;
                    else
                        matrixcar(car,battery)=matrixcar(car,battery)+batteryperunit;
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