function [check,timecanrun]=checkfront(matrixcar,Station,speed,areaStation,length,timechange)
%check=0 can run and check=1 can't run
    timecanrun=0;
    %matrixcar
    location=2;
    toStation=3;
    direction=8;
    %Station
    locateStation=1;
    directStation=2;
    timeofStation=3;
    %do
    check=0;
    locate=matrixcar(:,location);
    direct=matrixcar(:,direction);
    if locate-direct*speed>length
        newlocate=locate-direct*speed-length;
    elseif locate-direct*speed<0
        newlocate=locate-direct*speed+length;
    else
        newlocate=locate-direct*speed;
    end
    [stationsize,~]=size(Station);
    for station=1:stationsize
        if Station(station,directStation)==0
            continue;
        else
            if direct==-1
                if Station(station,locateStation)-areaStation/2<length
                    downlocate=Station(station,locateStation)-areaStation/2;
                else
                    downlocate=Station(station,locateStation)-areaStation/2-length;
                end
                if newlocate>locate
                    if downlocate>=locate && downlocate<=newlocate
                        if Station(station,directStation)==1 && Station(station,timeofStation)==0
                            check=0;
                            timecanrun=timechange;
                        elseif Station(station,directStation)==-1 && (Station(station,timeofStation)==timechange||Station(station,timeofStation)==0)
                            check=0;
                            timecanrun=Station(station,timeofStation);
                        else
                            check=1;
                            timecanrun=timechange;
                        end
                        return;
                    else
                        continue;
                    end
                else
                    if downlocate>=locate || downlocate<=newlocate
                        if Station(station,directStation)==1 && Station(station,timeofStation)==0
                            check=0;
                            timecanrun=timechange;
                        elseif Station(station,directStation)==-1 && (Station(station,timeofStation)==timechange||Station(station,timeofStation)==0)
                            check=0;
                            timecanrun=Station(station,timeofStation);
                        else
                            check=1;
                            timecanrun=timechange;
                        end
                        return;
                    else
                        continue;
                    end
                end
            else
                if Station(station,locateStation)+areaStation/2<length
                    uplocate=Station(station,locateStation)+areaStation/2;
                else
                    uplocate=Station(station,locateStation)+areaStation/2-length;
                end
                if newlocate<locate
                    if uplocate>=newlocate && uplocate<=locate
                        if Station(station,directStation)==1 && Station(station,timeofStation)==0
                            check=0;
                            timecanrun=timechange;
                        elseif Station(station,directStation)==-1 && (Station(station,timeofStation)==timechange||Station(station,timeofStation)==0)
                            check=0;
                            timecanrun=Station(station,timeofStation);
                        else
                            check=1;
                            timecanrun=timechange;
                        end
                        return;
                    else
                        continue;
                    end
                else
                    if uplocate>=newlocate || uplocate<=locate
                        if Station(station,directStation)==1 && Station(station,timeofStation)==0
                            check=0;
                            timecanrun=timechange;
                        elseif Station(station,directStation)==-1 && (Station(station,timeofStation)==timechange||Station(station,timeofStation)==0)
                            check=0;
                            timecanrun=Station(station,timeofStation);
                        else
                            check=1;
                            timecanrun=timechange;
                        end
                        return;
                    else
                        continue;
                    end
                end
            end

        end
    end
end