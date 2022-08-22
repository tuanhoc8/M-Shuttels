function [matrixcar]=checkbattery(matrixcar,batterylimit)
    [soxe,~]=size(matrixcar);
    battery=4;
    action=7;
    carneedcharge=-2;
    checkaction=0;
    for i=1:soxe
        if matrixcar(i,action)>carneedcharge
            if matrixcar(i,battery)<batterylimit
                matrixcar(i,action)=carneedcharge;
                checkaction=1;
            end
        end
    end
    if checkaction==1
        matrixcar=sortmatrix(matrixcar);
    end
end