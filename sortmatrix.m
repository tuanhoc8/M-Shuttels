function [matrixcar]=sortmatrix(matrixcar)
    [soxe,~]=size(matrixcar);
    action=7;
    carneedcharge=-2;
    battery=4;
    good=5;
    for j=1:soxe
        i=1;
        while(i<soxe)
            if(matrixcar(i,action)>matrixcar(i+1,action))
                b=matrixcar(i,:);
                matrixcar(i,:)=matrixcar(i+1,:);
                matrixcar(i+1,:)=b;
            end
            i=i+1;
        end
    end
    
    %%sap xep các xe can sac thanh 2 group
    %I la co hang va can sac
    %II la khong hang va can sac

    dau=0;
    for i=1:soxe
        if(matrixcar(1,action)==carneedcharge)
            dau=i;
            break;
        end
    end
    if dau~=0
        cuoi=soxe+1;
        if(matrixcar(soxe,action)>carneedcharge)
            cuoi=i;
        end
        for i=dau:(cuoi-2)
            for j=i+1:cuoi-1
                if(matrixcar(j,good)<matrixcar(j+1,good))
                    b=matrixcar(j,:);
                    matrixcar(j,:)=matrixcar(i,:);
                    matrixcar(i,:)=b;
                end
            end
        end
        cuoi1=dau;
        for i=dau:cuoi-1
            if matrixcar(i,good)==0
                cuoi1=i;
                break;
            end
        end
        %sap xep loai I theo pin
        for i=dau:cuoi1-2
            for j=i+1:cuoi1-1
                if(matrixcar(j,battery)>matrixcar(j+1,battery))
                    b=matrixcar(j,:);
                    matrixcar(j,:)=matrixcar(i,:);
                    matrixcar(i,:)=b;
                end
            end
        end
        
        %%sap xep II theo pin
        for i=cuoi1:cuoi-2
            for j=i+1:cuoi-1
                if(matrixcar(j,battery)>matrixcar(j+1,battery))
                    b=matrixcar(j,:);
                    matrixcar(j,:)=matrixcar(i,:);
                    matrixcar(i,:)=b;
                end
            end
        end
    end
end