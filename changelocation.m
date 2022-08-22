function matrixcar=changelocation(matrixcar,Station,length,speed,areaStation,minarea)
    %matrixcar
    namecar=1;
    location=2;
    toStation=3;
    action=7;
        carstop=-4;
    direction=8;
    indogde=9;
    %Station
    willinStation=5;
    [soxe,~]=size(matrixcar);
    carneedrun=0;
    for car=1:soxe
        if matrixcar(car,action)>carstop
            carneedrun=car;
            break;
        end
    end
    if carneedrun==0
        return;
    end
    for car=carneedrun:soxe
        if matrixcar(car,indogde)~=0
            continue;
        end
        if matrixcar(car,direction)==1
            if matrixcar(car,location)-speed<0
                matrixcar(car,location)=matrixcar(car,location)-speed+length;
            else
                matrixcar(car,location)=matrixcar(car,location)-speed;
            end
        elseif matrixcar(car,direction)==-1
            if matrixcar(car,location)+speed>=length
                matrixcar(car,location)=matrixcar(car,location)+speed-length;
            else
                matrixcar(car,location)=matrixcar(car,location)+speed;
            end
        end
    end
    checksafe=zeros(4,soxe-carneedrun+2);
    [~,checksafesize]=size(checksafe);
    newlocation=3;
    checkin=4;
    for i=2:checksafesize
        checksafe(namecar,i)=i+carneedrun-2;
        if checkStation(matrixcar(i+carneedrun-2,:),areaStation/2,length,Station)==1
            checksafe(location,i)=matrixcar(i+carneedrun-2,location);
            checksafe(checkin,i)=1;
        else
            checksafe(location,i)=matrixcar(i+carneedrun-2,location);
        end
    end
    [stationsize,~]=size(Station);
    for i=2:checksafesize
        for station=1:stationsize
            if Station(station,willinStation)~=0
                if matrixcar(Station(station,willinStation),namecar)==matrixcar(checksafe(namecar,i),namecar)
                    imatrixcar=matrixcar(checksafe(namecar,i),:);
                    imatrixcar(toStation)=station;
                    if checkStation(imatrixcar,areaStation/2,length,Station)==1
                        checksafe(checkin,i)=1;
                    else
                        continue;
                    end
                else
                    continue;
                end
            else
                continue;
            end
        end
    end
    locatecheck=checksafe(location,2);
    for i=2:checksafesize
        if checksafe(location,i)<locatecheck
            checksafe(location,i)=checksafe(location,i)-locatecheck+length;
        else
            checksafe(location,i)=checksafe(location,i)-locatecheck;
        end
    end
    for i=1:checksafesize-1
        for j=i+1:checksafesize
            if checksafe(location,i)>checksafe(location,j)
                b=checksafe(:,i);
                checksafe(:,i)=checksafe(:,j);
                checksafe(:,j)=b;
            else
                continue;
            end
        end
    end
    checksafe(:,1)=checksafe(:,checksafesize);
    checksafe(location,1)=checksafe(location,1)-length;
    checkok=1;
    for i=1:checksafesize-1
        if checksafe(location,i+1)-checksafe(location,i)<minarea
            checkok=0;
            break;
        end
    end
    checksafe(newlocation,:)=checksafe(location,:);
    while checkok==0
        checkok=1;
        checksafe(location,:)=checksafe(newlocation,:);
        for i=1:checksafesize-1
            if checksafe(checkin,i)~=0
                if checksafe(checkin,i+1)~=0
                    if checksafe(namecar,i)>checksafe(namecar,i+1)
                        checksafe(newlocation,i)=checksafe(location,i+1)-minarea;
                        checksafe(checkin,i)=0;
                        if i==1
                            checksafe(:,checksafesize)=checksafe(:,1);
                            checksafe(newlocation,checksafesize)=checksafe(newlocation,checksafesize)+length;
                            checksafe(location,checksafesize)=checksafe(location,checksafesize)+length;
                        end
                        checkok=0;
                        break;
                    else
                        checksafe(newlocation,i+1)=checksafe(location,i)+minarea;
                        checksafe(checkin,i+1)=0;
                        if i+1==checksafesize
                            checksafe(:,1)=checksafe(:,checksafesize);
                            checksafe(newlocation,1)=checksafe(newlocation,1)-length;
                            checksafe(location,1)=checksafe(location,1)-length;
                        end
                        checkok=0;
                        break;
                    end
                else
                    if checksafe(location,i+1)-checksafe(location,i)<minarea
                        checksafe(newlocation,i+1)=checksafe(location,i)+minarea;
                        if i+1==checksafesize
                            checksafe(:,1)=checksafe(:,checksafesize);
                            checksafe(newlocation,1)=checksafe(newlocation,1)-length;
                            checksafe(location,1)=checksafe(location,1)-length;
                        end
                        checkok=0;
                        break;
                    else
                        continue;
                    end
                end
            else
                if checksafe(checkin,i+1)~=0
                    if checksafe(location,i+1)-checksafe(location,i)<minarea
                        checksafe(newlocation,i)=checksafe(location,i+1)-minarea;
                        if i==1
                            checksafe(:,checksafesize)=checksafe(:,1);
                            checksafe(newlocation,checksafesize)=checksafe(newlocation,checksafesize)+length;
                            checksafe(location,checksafesize)=checksafe(location,checksafesize)+length;
                        end
                        checkok=0;
                        break;
                    else
                        continue;
                    end
                else
                    if checksafe(location,i+1)-checksafe(location,i)<minarea
                        distance=checksafe(location,i+1)-checksafe(location,i);
                        checksafe(newlocation,i+1)=checksafe(location,i+1)+(minarea-distance)/2;
                        checksafe(newlocation,i)=checksafe(location,i)-(minarea-distance)/2;
                        if i+1==checksafesize
                            checksafe(:,1)=checksafe(:,checksafesize);
                            checksafe(newlocation,1)=checksafe(newlocation,1)-length;
                            checksafe(location,1)=checksafe(location,1)-length;
                        end
                        if i==1
                            checksafe(:,checksafesize)=checksafe(:,1);
                            checksafe(newlocation,checksafesize)=checksafe(newlocation,checksafesize)+length;
                            checksafe(location,checksafesize)=checksafe(location,checksafesize)+length;
                        end
                        checkok=0;
                        break;
                    else
                        continue;
                    end
                end
            end
        end
    end
    for i=2:checksafesize
        if checksafe(location,i)+locatecheck>length
            checksafe(location,i)=checksafe(location,i)+locatecheck-length;
        else
            checksafe(location,i)=checksafe(location,i)+locatecheck;
        end
        matrixcar(checksafe(namecar,i),location)=checksafe(location,i);
    end
% 
    
        
end