 function check=checkStation(carcheck,area,length,Station)
    toStation=3;
    location=2;
    %Station 
    locateStation=1;
    if carcheck(:,toStation)==0
        check=0;
        return;
    end
    if Station(carcheck(:,toStation),locateStation)+area>length
        locateup=Station(carcheck(:,toStation),locateStation)+area-length;
    else
        locateup=Station(carcheck(:,toStation),locateStation)+area;
    end
    if Station(carcheck(:,toStation),locateStation)-area<0
        locatedown=length+Station(carcheck(:,toStation),locateStation)-area;
    else
        locatedown=Station(carcheck(:,toStation),locateStation)-area;
    end
    if locateup>locatedown
        if carcheck(:,location)>=locatedown && carcheck(:,location)<=locateup
            check=1;
        else
            check=0;
        end
    else
        if carcheck(:,location)>=locatedown|| carcheck(:,location)<=locateup
            check=1;
        else
            check=0;
        end
    end
end