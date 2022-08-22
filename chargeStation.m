function [matrixcar]=chargeStation(matrixcar,Station,length)
    %matrixcar
    namecar=1;
    location=2;
    toStation=3;
    good=5;
    action=7;
    carneedcharge=-2;
    %Station
    locateStation=1;
    willinStation=5;
    [soxe,~]=size(matrixcar);
    firstneed=0;
    for i=1:soxe
        if matrixcar(i,action)==carneedcharge 
            firstneed=i;
            break;
        end
    end
    if firstneed>0
        carlast=soxe;
        for i=firstneed:soxe
            if matrixcar(i,action)>carneedcharge
                carlast=i-1;
                break;
            end
        end
        
        [stationsize,~]=size(Station);
        Stationused=zeros(stationsize,1);
        for car=firstneed:carlast
            if matrixcar(car,good)==1 || matrixcar(car,action)<carneedcharge
                slotnot=dontslot(Stationused);
                if slotnot==0
                    return;
                end
                Stationused(slotnot)=matrixcar(car,toStation);
            else
                slotnot=dontslot(Stationused);
                if slotnot==0
                    return;
                end
                iStation=zeros(stationsize,2);
                for port=1:stationsize
                    iStation(port,1)=port;
                    if matrixcar(car,location)>Station(port,locateStation)
                        right=matrixcar(car,location)-Station(port,locateStation);
                        left=Station(port,locateStation)-matrixcar(car,location)+length;
                    else
                        left=Station(port,locateStation)-matrixcar(car,location);
                        right=matrixcar(car,location)-Station(port,locateStation)+length;
                    end
                    if right>left
                        iStation(port,2)=left;
                        
                    else
                        iStation(port,2)=right;
                    end
                    
                    
                end
                
                for i=1:stationsize-1
                    for j=i+1:stationsize
                        if iStation(i,2)>iStation(j,2)
                            b=iStation(i,:);
                            iStation(i,:)=iStation(j,:);
                            iStation(j,:)=b;
                        end
                    end
                end
                
                for i=1:stationsize
                    checkok=1;
                    for j=1:stationsize
                        if Stationused(j)==iStation(i,1)
                            checkok=0;
                            break;
                        end
                    end
                    if checkok==1
                        matrixcar(car,toStation)=iStation(i,1);
                        Station(matrixcar(car,toStation),willinStation)=matrixcar(car,namecar);
                        Stationused(slotnot)=iStation(i,1);
                        break;
                    end
                end
            end
        end
    else
        return;
    end
end