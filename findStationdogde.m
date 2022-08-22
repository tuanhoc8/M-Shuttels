function [groupStation]=findStationdogde(matrixcar,Station,waycheck,direct,furlocate,length)
    %matrixcar
    namecar=1;
    toStation=3;
    action=7;
        carstop=-4;
    %Station
    locateStation=1;
    %waycheck
    nowlocation=2;
    
    
    
    [Stationsize]=size(Station);
    locate=waycheck(1,furlocate-1);
    if direct==-1
        if locate<waycheck(1,nowlocation)
            comparedistance=locate-waycheck(1,nowlocation)+length;
        else
            comparedistance=locate-waycheck(1,nowlocation);
        end
    else
        if locate>waycheck(1,nowlocation)
            comparedistance=waycheck(1,nowlocation)-locate+length;
        else
            comparedistance=waycheck(1,nowlocation)-locate;
        end
    end
    
    group=[];
    %group
    distancegroup=2;
    check=0;
    for station=1:Stationsize
        for car=1:waycheck(1,namecar)-1
            if matrixcar(car,action)<=carstop
                continue;
            else
                if station==matrixcar(car,toStation)
                    check=1;
                    break;
                else
                    continue;
                end
            end
        end
        if check==1
            continue;
        end
        locate=Station(station,locateStation);
        if direct==-1
            if locate<waycheck(1,nowlocation)
                distance=locate-waycheck(1,nowlocation)+length;
            else
                distance=locate-waycheck(1,nowlocation);
            end
        else
            if locate>waycheck(1,nowlocation)
                distance=waycheck(1,nowlocation)-locate+length;
            else
                distance=waycheck(1,nowlocation)-locate;
            end
        end
        if distance<=comparedistance
            group=[group; station distance];
        else
            continue;
        end
    end
    [sizegroup,~]=size(group);
    for i=1:sizegroup
        
        for j=i+1:sizegroup
            if group(i,distancegroup)>group(j,distancegroup)
                b=group(i,:);
                group(i,:)=group(j,:);
                group(j,:)=b;
            end
        end
    end
    [sizegroup,~]=size(group);
    if sizegroup==0
        groupStation=[];
    else
        groupStation=group(1,:);
    end
end