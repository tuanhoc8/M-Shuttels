function [matrixcar,matrixwait]=findcarfree(matrixcar,matrixwait,Station,order,rowcarfree,length)
    %matrixcar
    namecar=1;
    location=2;
    toStation=3;
    
    %matrixwait
    loadStation=1;
    cardojob=3;
    carchosen=4;
    %Station
    locateStation=1;
    if rowcarfree==0
        return;
    end
    [soxe,~]=size(matrixcar);
    matrixleft=zeros(2,soxe-rowcarfree+1);
    locate=Station(matrixwait(order,loadStation),locateStation);
    for i=1:soxe-rowcarfree+1
        matrixleft(namecar,i)=i-1+rowcarfree;
        matrixleft(location,i)=matrixcar(i-1+rowcarfree,location);
    end
    matrixright=matrixleft;
    
    %left
    for i=1:soxe-rowcarfree+1
        if matrixleft(location,i)>=locate
            matrixleft(location,i)= matrixleft(location,i)-locate;    
        else
            matrixleft(location,i)= matrixleft(location,i)-locate+length;    
        end
    end
    for i=1:soxe-rowcarfree
        for j=i+1:soxe-rowcarfree+1
            if matrixleft(location,i)>matrixleft(location,j)
                b=matrixleft(:,i);
                matrixleft(:,i)=matrixleft(:,j);
                matrixleft(:,j)=b;
            end
        end
    end
    
    
    left=1;
    while left<=soxe-rowcarfree+1
        checkleft=1;
        for j=1:order-1
           if matrixcar(matrixleft(namecar,left),namecar)==matrixwait(j,cardojob)||matrixcar(matrixleft(namecar,left),namecar)==matrixwait(j,carchosen)
                
                checkleft=0;
                break;
            end 
        end
        if checkleft==1
            break;
        end
        left=left+1;
    end
    
    %right
    for i=1:soxe-rowcarfree+1
        if matrixright(location,i)<=locate
            matrixright(location,i)= locate-matrixright(location,i);    
        else
            matrixright(location,i)= locate-matrixright(location,i)+length;    
        end
    end
    
    for i=1:soxe-rowcarfree
        for j=i+1:soxe-rowcarfree+1
            if matrixright(location,i)>matrixright(location,j)
                b=matrixright(:,i);
                matrixright(:,i)=matrixright(:,j);
                matrixright(:,j)=b;
            end
        end
    end
   
   right=1;
   while right<=soxe-rowcarfree+1
        checkright=1;
        for j=1:order-1
           if matrixcar(matrixright(namecar,right),namecar)==matrixwait(j,cardojob)||matrixcar(matrixright(namecar,right),namecar)==matrixwait(j,carchosen)
                checkright=0;
                break;
            end 
        end
        if checkright==1
            break;
        end
        right=right+1;
    end
    
   
    %compare
    if right>soxe-rowcarfree+1
        if left<=soxe-rowcarfree+1
            matrixwait(order,carchosen)=matrixcar(matrixleft(namecar,left),namecar);
            matrixcar(matrixleft(namecar,left),toStation)=matrixwait(order,loadStation);
        else
            return;
        end
    elseif left>soxe-rowcarfree+1
        if right<=soxe-rowcarfree+1
            matrixwait(order,carchosen)=matrixcar(matrixright(namecar,right),namecar);
            matrixcar(matrixright(namecar,right),toStation)=matrixwait(order,loadStation);
        else
            return;
        end
    else
        if matrixleft(location,left)>=matrixright(location,right)
            matrixwait(order,carchosen)=matrixcar(matrixright(namecar,right),namecar);
            matrixcar(matrixright(namecar,right),toStation)=matrixwait(order,loadStation);
        else
            matrixwait(order,carchosen)=matrixcar(matrixleft(namecar,left),namecar);
            matrixcar(matrixleft(namecar,left),toStation)=matrixwait(order,loadStation);
        end
    end
end