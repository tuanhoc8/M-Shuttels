function [matrixcar,matrixwait,Station]=cardirection(matrixcar,matrixwait,Station,length,safearea,speed,timechange,areaStation)
    [soxe,~]=size(matrixcar);
    %matrixcar
    namecar=1;
    toStation=3;
    action=7;
        
        carstop=-4;
        
        carfree=0;
    direction=8;
    indogde=9;
    %Station
    directStation=2;
    timeofStation=3;
    carsinStation=4;
    
   
    
    [stationsize,~]=size(Station);
    hadrun=zeros(2*soxe+1,1);
    hadrun(1,1)=-1;
    sobuoc=fix(length/speed)+1;
    waycar=zeros(soxe,1+sobuoc);
    %waycar
    [hadrunsize,~]=size(hadrun);
    
    
    furlocate=sobuoc;
    %find car can run
    rowneedrun=0;
    
    for i=1:soxe
        if matrixcar(i,action)>carstop
            rowneedrun=i;
            break;
        end
    end
    if rowneedrun>0
        %delivery
        for rowcar=rowneedrun:soxe
            if matrixcar(rowcar,action)==carfree && matrixcar(rowcar,toStation)==0
                continue;
            else
                checkhadrun=0;
                for i=1:hadrunsize
                    if hadrun(i,:)==rowcar
                        checkhadrun=1;
                        break;
                    elseif hadrun(i,:)==0
                        break;
                    end
                end
                if checkhadrun==1
                    continue;
                end
                % add that car into hadrun
                hadrun(dontslot(hadrun),:)=rowcar;
                if matrixcar(rowcar,indogde)~=0
                    for station=1:stationsize
                        if matrixcar(rowcar,namecar)==Station(station,carsinStation)
                            break;
                        else
                            continue;
                        end
                    end
                    if Station(station,directStation)==1||Station(station,directStation)==-1&&Station(station,timeofStation)~=timechange
                        continue;
                    end
                end
                %find the nearest way
                matrixcar(rowcar,:)=nearestdirect(matrixcar(rowcar,:),Station,length);
                direct=matrixcar(rowcar,direction);
                %find group car is force
                [matrixcar,groupcar,numcar,checkrun,waycar]=groupforce(matrixcar,Station,hadrun,waycar,rowcar,rowneedrun,length,safearea,timechange,areaStation,speed);
                %find direction  car in group can run or not ?
                
                if checkrun==1
                    [matrixcar,Station,hadrun,waycar,furlocate]=makeruncargroup(matrixcar,hadrun,waycar,Station,groupcar,numcar,length,speed,areaStation,timechange,safearea,sobuoc,direct,furlocate);
                end
                
%                 if runok==1
%                     %find Station dogding for another car 
%                     [matrixcar,Station,hadrun,waycar]=dogding(matrixcar,Station,hadrun,waycar,waycheck,furlocate,length,areaStation,timechange);
%                 else
%                     delete(waycheck)
%                 end
                slot=dontslot(hadrun);
                hadrun(slot)=-1;
                
            end
        end
    else
        return;
    end
end