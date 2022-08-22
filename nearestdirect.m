function [car]=nearestdirect(car,Station,length)
    %matrixcar
    location=2;
    toStation=3;
    direction=8;
    %Station
    locateStation=1;
    %find way
    
    tolocate=Station(car(:,toStation),locateStation);
    if tolocate>car(:,location)
        left=tolocate-car(:,location);
        right=car(:,location)-tolocate+length;
    elseif tolocate==car(:,location)
        car(:,direction)=0;
        return;
    else
        right=car(:,location)-tolocate;
        left=tolocate-car(:,location)+length;
    end
    %compare
    if right>left
        car(:,direction)=-1;
    else
        car(:,direction)=1;
    end
end