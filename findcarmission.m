function [matrixcar,matrixwait]=findcarmission(matrixcar,matrixwait,Station,length)
    %matrixcar
    namecar=1;
    toStation=3;
    good=5;
    action=7;
        carstop=-4;
        carfree=0;
    %matrixwait
    loadStation=1;
    cardojob=3;
    carchosen=4;
    %Station
    directStation=2;
    carsinStation=4;
        
    rowcarfree=0;
    [soxe,~]=size(matrixcar);
    for i=1:soxe
        if matrixcar(i,action)==carfree
            rowcarfree=i;
            break;
        end
    end
    if rowcarfree~=0
        for i=rowcarfree:soxe
            if matrixcar(i,toStation)~=0
                matrixcar(i,toStation)=0;
            end
        end
    end
    % choose car for take good
    [sizewait,~]=size(matrixwait);
    for order=1:sizewait
        matrixwait(order,carchosen)=0;
    end
    for order=1:sizewait
        if matrixwait(order,cardojob)~=0
            continue;
        end
        checksame=0;
        for orderbf=1:order-1
            if matrixwait(orderbf,loadStation)==matrixwait(order,loadStation)
                checksame=1;
                break;
            end
        end
        if checksame==1
            continue;
        end
        %that station have the order having car in 
        %check that car will free or will delivery
            %if that car will delivery  find another car
            %if that car will free chosen that car
        if Station(matrixwait(order,loadStation),carsinStation)~=0
            carin=0;
            for car=1:soxe
                if matrixcar(car,namecar)==Station(matrixwait(order,loadStation),carsinStation)
                    carin=car;
                    break;
                else
                    continue;
                end
            end
            if Station(matrixwait(order,loadStation),directStation)==1
                if matrixcar(carin,good)==1 && matrixcar(carin,action)==carstop
                    matrixwait(order,carchosen)=matrixcar(carin,namecar);
                elseif matrixcar(carin,action)==carfree
                    matrixwait(order,carchosen)=matrixcar(carin,namecar);
                else
                    [matrixcar,matrixwait]=findcarfree(matrixcar,matrixwait,Station,order,rowcarfree,length);
                end
            elseif Station(matrixwait(order,loadStation),directStation)==-1
                if matrixcar(carin,good)==0
                    matrixwait(order,carchosen)=matrixcar(carin,namecar);
                else
                    [matrixcar,matrixwait]=findcarfree(matrixcar,matrixwait,Station,order,rowcarfree,length);
                end
            end
        else
            [matrixcar,matrixwait]=findcarfree(matrixcar,matrixwait,Station,order,rowcarfree,length);
        end
    end

end