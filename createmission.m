function [matrixwait]=createmission(matrixwait,row,soport)
    %matrixwait
    loadStation=1;
    unloadStation=2;
    
    [sizewait,~]=size(matrixwait);
    for i=row:sizewait-1
        b=matrixwait(i,:);
        matrixwait(i,:)=matrixwait(i+1,:);
        matrixwait(i+1,:)=b;
    end
    matrixwait(sizewait,loadStation)=randi(soport);
    matrixwait(sizewait,unloadStation)=randi(soport);
    while(matrixwait(sizewait,loadStation)==matrixwait(sizewait,unloadStation))
        matrixwait(sizewait,unloadStation)=mod(randi(1000),soport)+1;
    end
end