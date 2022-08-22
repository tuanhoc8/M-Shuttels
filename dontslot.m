function [slotmatrix]=dontslot(matrix)
    slotmatrix=0;
    [num,~]=size(matrix);
    for i=1:num
        if matrix(i,1)==0
            slotmatrix=i;
            return;
        end
    end
end