function [matrixcar,matrixwait,Station]=loading(matrixcar,matrixwait,Station,length,areaStation,timechange,timeunload,soport,timeload)
    [soxe,~]=size(matrixcar);
    %matrixcar
    namecar=1;
    toStation=3;
    good=5;
    time=6;
    action=7;
        carstop=-4;
        carfree=0;
    indogde=9;
    %matrixwait
    loadStation=1;
    unloadStation=2;
    cardojob=3;
    carchosen=4;
    %Station
    directStation=2;
    timeofStation=3;
    carsinStation=4;
    willinStation=5;
    checkaction=0;
    [sizewait,~]=size(matrixwait);
    for order=1:sizewait
        if matrixwait(order,cardojob)~=0
            if Station(matrixwait(order,loadStation),directStation)==1
                if Station(matrixwait(order,loadStation),timeofStation)>0
                    Station(matrixwait(order,loadStation),timeofStation)=Station(matrixwait(order,loadStation),timeofStation)-1;
                else
                    cardo=0;
                    for car=1:soxe
                        if matrixwait(order,cardojob)==matrixcar(car,namecar)
                            cardo=car;
                            break;
                        end
                    end
                    if matrixcar(cardo,time)>1
                        matrixcar(cardo,time)=matrixcar(cardo,time)-1;
                    else
                        matrixcar(cardo,time)=timeunload;
                        Station(matrixwait(order,loadStation),directStation)=-1;
                        Station(matrixwait(order,loadStation),timeofStation)=timechange;
                        matrixcar(cardo,indogde)=0;
                        matrixcar(cardo,good)=1;
                        matrixwait(order,cardojob)=0;
                        matrixcar(cardo,toStation)=matrixwait(order,unloadStation);
                        [matrixwait]=createmission(matrixwait,order,soport);
                    end
                end
            end
        else
            
            if matrixwait(order,carchosen)==0
                continue;
            else
                if Station(matrixwait(order,loadStation),directStation)==1
                    if Station(matrixwait(order,loadStation),carsinStation)==matrixwait(order,carchosen)
                       carchoose=0;
                       for car=1:soxe
                           if matrixcar(car,namecar)==matrixwait(order,carchosen)
                               carchoose=car;
                               break;
                           end
                       end
                       if matrixcar(carchoose,action)==carfree
                           matrixwait(order,cardojob)=matrixcar(carchoose,namecar);
                           matrixwait(order,carchosen)=0;
                           Station(matrixwait(order,loadStation),willinStation)=0;
                           matrixcar(carchoose,indogde)=0;
                           matrixcar(carchoose,action)=carstop;
                           
                           if Station(matrixwait(order,loadStation),timeofStation)>0
                               Station(matrixwait(order,loadStation),timeofStation)=Station(matrixwait(order,loadStation),timeofStation)-1;
                           end
                           checkaction=1;
                       end
                    else
                        continue;
                    end
                elseif Station(matrixwait(order,loadStation),directStation)==0
                    
                    carchoose=0;
                    for car=1:soxe
                        if matrixcar(car,namecar)==matrixwait(order,carchosen)
                            carchoose=car;
                            break;
                        end
                    end
                    
                    imatrixcar=matrixcar(carchoose,:);
                    imatrixcar(toStation)=matrixwait(order,loadStation);
                    checkStation(imatrixcar,areaStation/2,length,Station)
                    if checkStation(imatrixcar,areaStation/2,length,Station)==1
                        matrixwait(order,cardojob)=matrixwait(order,carchosen);
                        matrixwait(order,carchosen)=0;
                        Station(matrixwait(order,loadStation),directStation)=1;
                        Station(matrixwait(order,loadStation),timeofStation)=Station(matrixwait(order,loadStation),timeofStation)-1;
                        Station(matrixwait(order,loadStation),carsinStation)=matrixwait(order,cardojob);
                        matrixcar(carchoose,action)=carstop;
                        checkaction=1;
                    else
                        continue;
                    end
                else
                    if matrixwait(order,carchosen)==Station(matrixwait(order,loadStation),carsinStation)
                        Station(matrixwait(order,loadStation),directStation)=1;
                        Station(matrixwait(order,loadStation),timeofStation)=timechange-Station(matrixwait(order,loadStation),timeofStation);
                        carchoose=0;
                        for car=1:soxe
                            if matrixcar(car,namecar)==matrixwait(order,carchosen)
                                carchoose=car;
                                break;
                            end
                        end
                        matrixcar(carchoose,time)=timeload;
                        if matrixcar(carchoose,action)~=carstop % it is free car
                            matrixcar(carchoose,action)=carstop;
                            checkaction=1;
                            matrixcar(carchoose,indogde)=0;
                        end
                        matrixwait(order,cardojob)=matrixwait(order,carchosen);
                        matrixwait(order,carchosen)=0;
                    else
                        continue;
                    end
                end
            end
        end
    end
    if checkaction==1
        matrixcar=sortmatrix(matrixcar);
    end
end