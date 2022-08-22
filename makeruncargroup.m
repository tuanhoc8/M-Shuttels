function [matrixcar,Station,hadrun,waycar,furlocate]=makeruncargroup(matrixcar,hadrun,waycar,Station,groupcar,numcar,length,speed,areaStation,timechange,safearea,sobuoc,direct,furlocate)
    
    column=9;
    %matrixcar 
    namecar=1;
    location=2;
    toStation=3;
    direction=8;
    indogde=9;
    %waycar
    nowlocation=2;
    newfurlocate=nowlocation;
    %Station
    carsinStation=4;
    willinStation=5;
    
    waycheck=zeros(numcar,sobuoc+1);
    matrixcheck=zeros(numcar,column);
    slot=dontslot(waycar(:,namecar));
    %make table location and new matrixcar for group car
    for i=1:numcar
        waycheck(i,1)=groupcar(i,:);
        waycheck(i,nowlocation)=matrixcar(waycheck(i,1),location);
        matrixcheck(i,:)=matrixcar(waycheck(i,1),:);
        matrixcheck(i,location)=waycheck(i,nowlocation);
        matrixcheck(i,direction)=direct;
    end
    checkout=1;
    if matrixcar(groupcar(1,:),indogde)~=0
        for i=1:timechange
            newfurlocate=newfurlocate+1;
            if numcar==1
                for carcheck=1:slot-1
                    compare=(waycar(carcheck,newfurlocate)-waycheck(numcar,nowlocation))*(waycar(carcheck,newfurlocate)-waycheck(numcar,nowlocation));
                    if compare<0
                        checkout=0;
                        break;
                    else
                        continue;
                    end   
                end
            end
            if checkout==0
                return;
            end
            for carcheck=1:slot-1
                compare=(waycheck(1,nowlocation)-waycar(carcheck,newfurlocate))*(waycheck(1,nowlocation)-waycar(carcheck,newfurlocate));
                if compare<0
                    checkout=0;
                    break;
                else
                    continue;
                end
            end
            if checkout==0
                return;
            else
                for j=1:numcar
                    waycheck(i,newfurlocation)=waycheck(j,nowlocation);
                end
            end
        end 
    end
    
    %check front can run or not
    imatrixcar=matrixcar(groupcar(numcar,:),:);
    imatrixcar(direction)=matrixcar(groupcar(1,:),direction);
    
    [checkfr,timecanrun]=checkfront(imatrixcar,Station,speed,areaStation,length,timechange);
    %if can't not run because of the directStation~=0
    if checkfr==1
        furlocate=nowlocation+timecanrun;
        for i=2:numcar
            slot=dontslot(hadrun);
            hadrun(slot)=groupcar(i,namecar);
        end
        for car=1:numcar
            matrixcar(groupcar(car,namecar),direction)=0;
            slot=dontslot(waycar(:,namecar));
            waycar(slot,namecar)=groupcar(car,namecar);
            for i=nowlocation:furlocate
                waycar(slot,i)=matrixcar(groupcar(car,namecar),location);
            end
        end
        return;
    else
       
    end
    [checkaccept,timecanrun]=acceptStation(imatrixcar,Station,speed,length,timechange,areaStation);
    
    if checkaccept==0
        furlocate=nowlocation+timecanrun;
        for i=2:numcar
            slot=dontslot(hadrun);
            hadrun(slot)=groupcar(i,namecar);
        end
        for car=1:numcar
            matrixcar(groupcar(car,namecar),direction)=0;
            slot=dontslot(waycar(:,namecar));
            waycar(slot,namecar)=groupcar(car,namecar);
            for i=nowlocation:furlocate
                waycar(slot,i)=matrixcar(groupcar(car,namecar),location);
            end
        end
        return;
    end
    %check car can run without dogde or not ?
    %if end while checkrun=0 || checktoStation=1
    %if checkrun=1 groupcar can run without dogde
    %else we need to check to dogding
    checkrun=1;
    checktoStation=0;
    while checkrun==1 && checktoStation==0 && newfurlocate<furlocate
        for cargroup=1:numcar
            if waycheck(cargroup,newfurlocate)-direct*speed>length
                waycheck(cargroup,newfurlocate+1)=waycheck(cargroup,newfurlocate)-direct*speed-length;
            elseif waycheck(cargroup,newfurlocate)-direct*speed<0
                waycheck(cargroup,newfurlocate+1)=waycheck(cargroup,newfurlocate)-direct*speed+length;
            else
                waycheck(cargroup,newfurlocate+1)=waycheck(cargroup,newfurlocate)-direct*speed;
            end
            matrixcheck(cargroup,location)=waycheck(cargroup,newfurlocate+1); 
        end
        newfurlocate=newfurlocate+1;
        for carcheck=1:slot-1
            if matrixcar(waycar(carcheck,namecar),direction)==direct
                continue;
            else
                if waycar(carcheck,newfurlocate)==0
                    continue;
                else
                    if waycar(carcheck,newfurlocate)==waycar(carcheck,newfurlocate-1)
                        compare=(waycheck(numcar,newfurlocate)-waycar(carcheck,newfurlocate))*(waycheck(numcar,newfurlocate-1)-waycar(carcheck,newfurlocate));
                        if compare<=0
                            checkrun=0;
                            break;
                        else
                            continue;
                        end
                    else
                        compare1=(waycheck(numcar,newfurlocate)-waycar(carcheck,newfurlocate))*(waycheck(numcar,newfurlocate-1)-waycar(carcheck,newfurlocate));
                        compare2=(waycar(carcheck,newfurlocate)-waycheck(numcar,newfurlocate))*(waycar(carcheck,newfurlocate-1)-waycheck(numcar,newfurlocate));
                        compare3=(waycheck(numcar,newfurlocate)-waycar(carcheck,newfurlocate-1))*(waycheck(numcar,newfurlocate-1)-waycar(carcheck,newfurlocate-1));
                        compare4=(waycar(carcheck,newfurlocate)-waycheck(numcar,newfurlocate-1))*(waycar(carcheck,newfurlocate-1)-waycheck(numcar,newfurlocate-1));                        
                        if (compare1<=0 && compare2<=0)||(compare3<=0 && compare4<=0)
                            checkrun=0;
                            break;
                        else
                            continue;
                        end
                    end
                end
            end
        end
        if checkrun==0
            break;
        end
        for cargroup=1:numcar
            if checkStation(matrixcheck(cargroup,:),areaStation/2,length,Station)==1
                checktoStation=1;
                break;
            end
        end
        if checktoStation==1
           break;
        end
    end
    furlocate=newfurlocate;
    %if checkrun=1 return
    if checkrun==1
        %add to hadrun %set direction
        for i=2:numcar
            slot=dontslot(hadrun);
            hadrun(slot)=waycheck(i,namecar);
            matrixcar(waycheck(i,namecar),direction)=matrixcar(waycheck(1,namecar),direction);
        end
        %add to waycar
        for i=1:numcar
            slot=dontslot(waycar(:,namecar));
            for j=1:furlocate
                waycar(slot,j)=waycheck(i,j);
            end
        end
        
        return;
    else
        [groupStation]=findStationdogde(matrixcar,Station,waycheck,direct,furlocate,length);
        [sizegroup,~]=size(groupStation);
        checkok=0;
        for i=1:sizegroup
            if Station(groupcar(i),carsinStation)~=0||Station(groupcar(i),willinStation)~=0
                continue;
            else
                checkok=1;
                Station(groupcar(i),willinStation)=matrixcar(groupcar(1,namecar),namecar);
                furlocate=furlocate-1;
                imatrixcar=zeros(1,column);
                imatrixcar(toStation)=groupcar(i);
                for j=nowlocation:furlocate
                    imatrixcar(location)=waycheck(1,j);
                    if checkStation(imatrixcar,areaStation/2,length,Station)==1
                        furlocate=j;
                        break;
                    else
                        continue;
                    end
                end
                break;
            end
        end
        if checkok==1
            %add to hadrun %set direction
            for i=2:numcar
                slot=dontslot(hadrun);
                hadrun(slot)=waycheck(i,namecar);
                matrixcar(waycheck(i,namecar),direction)=matrixcar(waycheck(1,namecar),direct);
            end
            %add to waycar
            for i=1:numcar
                slot=dontslot(waycar(:,namecar));
                for j=1:furlocate
                    waycar(slot,j)=waycheck(i,j);
                end
            end
            return;
        else
            furlocate=furlocate-1;
            if furlocate<3
                furlocate=3;
            end
            slot=dontslot(waycar(:,namecar));
            waycar(slot,namecar)=groupcar(1,:);
            for j=nowlocation:furlocate
                waycar(slot,j)=matrixcar(groupcar(1,:),location);
            end
            matrixcar(groupcar(1,:),direction)=0;
        end
    end
    
end