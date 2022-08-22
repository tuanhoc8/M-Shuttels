function [matrixcar,Station]=unloading(matrixcar,Station,length,areaStation,timechange,timeload)
    %matrixcar
    namecar=1;
    toStation=3;
    good=5;
    time=6;
    action=7;
    carstop=-4;
    [soxe,~]=size(matrixcar);
    %Station
    directStation=2;
    timeofStation=3;  
    carsinStation=4;
    checkaction=0;
    for i=1:soxe
        if matrixcar(i,good)==1
            if checkStation(matrixcar(i,:),areaStation/2,length,Station)==1 && matrixcar(i,action)>carstop
                matrixcar(i,action)=carstop;
                Station(matrixcar(i,toStation),directStation)=1;
                Station(matrixcar(i,toStation),timeofStation)=Station(matrixcar(i,toStation),timeofStation)-1;
                Station(matrixcar(i,toStation),carsinStation)=matrixcar(i,namecar);
                checkaction=1;
            elseif Station(matrixcar(i,toStation),carsinStation)==matrixcar(i,namecar) && Station(matrixcar(i,toStation),directStation)==1
                if matrixcar(i,time)>0
                    if Station(matrixcar(i,toStation),directStation)==1
                        
                        if Station(matrixcar(i,toStation),timeofStation)>0
                            Station(matrixcar(i,toStation),timeofStation)=Station(matrixcar(i,toStation),timeofStation)-1;
                        else
                            matrixcar(i,time)=matrixcar(i,time)-1;
                            if matrixcar(i,time)==0
                                Station(matrixcar(i,toStation),timeofStation)=timechange;
                                Station(matrixcar(i,toStation),directStation)=-1;
                                matrixcar(i,toStation)=0;
                                matrixcar(i,time)=timeload;
                                matrixcar(i,good)=0;
                            end
                        end
                    end
                end
            end
        end   
    end
    if checkaction==1
        matrixcar=sortmatrix(matrixcar);
    end
end