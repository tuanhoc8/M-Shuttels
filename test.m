clc;
syms t;
locateStation=1;
directStation=2;
timeofStation=3;
timechange=12;
length=3000+600*2*pi;
areaStation=300;
soport=3;
ratio=length/(3000+600*2*pi);
Station=zeros(soport,5);
for i=1:soport
   Station(i,locateStation)=fix(length*(i-1)/soport);
   Station(i,directStation)=-1;
   Station(i,timeofStation)=timechange/2;
end

x=[-500 500];
y=[1700/2 1700/2];
plot(x,y,'b','LineWidth',3);
hold on;
x=[-500 500];
y=-[1700/2 1700/2];
plot(x,y,'b','LineWidth',3);
x=[1100 1100];
y=[-250 250];
plot(x,y,'b','LineWidth',3);
x=-[1100 1100];
y=[-250 250];
plot(x,y,'b','LineWidth',3);
xt=@(t) 600*cos(t)-500;
yt=@(t) 600*sin(t)+250;
fplot(xt,yt,[pi/2 pi],'b','LineWidth',3);
xt=@(t) 600*cos(t)-500;
yt=@(t) 600*sin(t)-250;
fplot(xt,yt,[pi 3*pi/2],'b','LineWidth',3);
xt=@(t) 600*cos(t)+500;
yt=@(t) 600*sin(t)+250;
fplot(xt,yt,[0 pi/2],'b','LineWidth',3);
xt=@(t) 600*cos(t)+500;
yt=@(t) 600*sin(t)-250;
fplot(xt,yt,[-pi/2 0],'b','LineWidth',3);
for i=1:soport
    action=Station(i,directStation);
    if action==0
        fun=0;
    elseif action==-1
        fun=Station(i,timeofStation)/timechange;
    else
        fun=1-(12-Station(i,timeofStation))/timechange;
    end
    if Station(i,locateStation)<=250*ratio
        if Station(i,locateStation)+areaStation/2>250*ratio
            angle=(Station(i,locateStation)+areaStation/2-250*ratio)/(600*ratio);
            x=[1100 1100]+300*fun*[1 1];
            y=[250 (Station(i,locateStation)-areaStation/2)/ratio];
            plot(x,y,'r','LineWidth',3);
            xt=@(t) 600*cos(t)+500+300*fun;
            yt=@(t) 600*sin(t)+250;
            fplot(xt,yt,[0 angle],'r','LineWidth',3);
            x=[800 800]+300*fun*[1 1];
            y=[250 (Station(i,locateStation)-areaStation/2)/ratio];
            plot(x,y,'r','LineWidth',3);
            xt=@(t) 600*cos(t)+200+300*fun;
            yt=@(t) 600*sin(t)+250;
            fplot(xt,yt,[0 angle],'r','LineWidth',3);
            x=[800 1100]+300*fun*[1 1];
            y=[Station(i,locateStation) Station(i,locateStation)]/ratio;
            plot(x,y,'r','LineWidth',3);
        else
            x=[1100 1100]+300*fun*[1 1];
            y=[(Station(i,locateStation)+areaStation/2)/ratio (Station(i,locateStation)-areaStation/2)/ratio];
            plot(x,y,'r','LineWidth',3);
            x=[800 800]+300*fun*[1 1];
            y=[(Station(i,locateStation)+areaStation/2)/ratio (Station(i,locateStation)-areaStation/2)/ratio];
            plot(x,y,'r','LineWidth',3);
            x=[800 1100]+300*fun*[1 1];
            y=[Station(i,locateStation) Station(i,locateStation)]/ratio;
            plot(x,y,'r','LineWidth',3);
        end
    elseif Station(i,locateStation)>250*ratio && Station(i,locateStation)<=ratio*(250+600*pi/2)
        if Station(i,locateStation)-areaStation/2<=250*ratio
            angle=(Station(i,locateStation)-areaStation/2-250*ratio)/(600*ratio);
            x=[1100 1100]+300*fun*[1 1];
            y=[250 (Station(i,locateStation)-areaStation/2)/ratio];
            plot(x,y,'r','LineWidth',3);
            xt=@(t) 600*cos(t)+500+300*fun;
            yt=@(t) 600*sin(t)+250;
            fplot(xt,yt,[0 -angle],'r','LineWidth',3);
            x=[800 800]+300*fun*[1 1];
            y=[250 (Station(i,locateStation)-areaStation/2)/ratio];
            plot(x,y,'r','LineWidth',3);
            xt=@(t) 600*cos(t)+200+300*fun;
            yt=@(t) 600*sin(t)+250;
            fplot(xt,yt,[0 -angle],'r','LineWidth',3);
            x=[800 1100]+300*fun*[1 1];
            y=[Station(i,locateStation) Station(i,locateStation)]/ratio;
            plot(x,y,'r','LineWidth',3);
        elseif Station(i,locateStation)+areaStation/2>=ratio*(250+600*pi/2)
            angle=(Station(i,locateStation)-areaStation/2-250*ratio)/(600*ratio);
            x=[500 500-(Station(i,locateStation)+areaStation/2)/ratio+(250+600*pi/2)];
            y=[850 850]+300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
            xt=@(t) 600*cos(t)+500;
            yt=@(t) 600*sin(t)+250+300*fun;
            fplot(xt,yt,[angle pi/2],'r','LineWidth',3);
            xt=@(t) 600*cos(t)+500;
            yt=@(t) 600*sin(t)-50+300*fun;
            fplot(xt,yt,[angle pi/2],'r','LineWidth',3);
            x=[500 500-(Station(i,locateStation)+areaStation/2)/ratio+(250+600*pi/2)];
            y=[550 550]+300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
            anglestation=(Station(i,locateStation)-250*ratio)/(600*ratio);
            x=[500+600*cos(anglestation) 500+600*cos(anglestation)];
            y=[550 850]+300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
        else
            angle=areaStation/(600*ratio);
            anglestation=Station(i,locateStation)/(600*ratio);
            xt=@(t) 600*cos(t)+500+300*fun*cos(anglestation);
            yt=@(t) 600*sin(t)+250+300*fun*sin(anglestation);
            fplot(xt,yt,[anglestation-angle/2 anglestation+angle/2],'r','LineWidth',3);
            xt=@(t) 600*cos(t)+500-300*cos(anglestation)+300*fun*cos(anglestation);
            yt=@(t) 600*sin(t)+250-300*sin(anglestation)+300*fun*sin(anglestation);
            fplot(xt,yt,[anglestation-angle/2 anglestation+angle/2],'r','LineWidth',3);
            x=[300*cos(anglestation)+500 600*cos(anglestation)+500]+300*fun*cos(anglestation)*[1 1];
            y=[300*sin(anglestation)+250 600*sin(anglestation)+250]+300*fun*sin(anglestation)*[1 1];
            plot(x,y,'r','LineWidth',3);
        end
    elseif Station(i,locateStation)>(250+600*pi/2)*ratio && Station(i,locateStation)<(1250+600*pi/2)*ratio
        if Station(i,locateStation)-areaStation/2<= (250+600*pi/2)*ratio
            angle=((250+600*pi/2)*ratio-Station(i,locateStation)+areaStation/2)/(600*ratio);
            x=[500-(Station(i,locateStation)+areaStation/2-(250+600*pi/2)*ratio)/ratio 500];
            y=[850 850]+300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
            xt=@(t) 600*cos(t)+500;
            yt=@(t) 600*sin(t)+250+300*fun;
            fplot(xt,yt,[pi/2-angle pi/2],'r','LineWidth',3);
            x=[500-(Station(i,locateStation)+areaStation/2-(250+600*pi/2)*ratio)/ratio 500];
            y=[550 550]+300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
            xt=@(t) 600*cos(t)+500;
            yt=@(t) 600*sin(t)-50+300*fun;
            fplot(xt,yt,[pi/2-angle pi/2],'r','LineWidth',3);
            x=(500-(Station(i,locateStation)/ratio-250-600*pi/2))*[1 1];
            y=[850 550]+300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
        elseif Station(i,locateStation)+areaStation/2>=(1250+600*pi/2)*ratio
            angle=(Station(i,locateStation)+areaStation/2-(1250+600*pi/2)*ratio)/(600*ratio);
            xt=@(t) 600*cos(t)-500;
            yt=@(t) 600*sin(t)+250+300*fun;
            fplot(xt,yt,[pi/2 pi/2+angle],'r','LineWidth',3);
            x=[-500 500-(Station(i,locateStation)-areaStation/2-(250+600*pi/2))/ratio];
            y=[850 850]+300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
            xt=@(t) 600*cos(t)-500;
            yt=@(t) 600*sin(t)-50+300*fun;
            fplot(xt,yt,[pi/2 pi/2+angle],'r','LineWidth',3);
            x=[-500 500-(Station(i,locateStation)-areaStation/2-(250+600*pi/2))/ratio];
            y=[550 550]+300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
            x=(500-(Station(i,locateStation)-(250+600*pi/2)*ratio)/ratio)*[1 1];
            y=[850 550]+300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
        else
            x=(500-(Station(i,locateStation)-(250+600*pi/2)*ratio)/ratio)*[1 1]+areaStation/(2*ratio)*[-1 1];
            y=[850 850]+300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
            x=(500-(Station(i,locateStation)-(250+600*pi/2)*ratio)/ratio)*[1 1]+areaStation/(2*ratio)*[-1 1];
            y=[550 550]+300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
            x=(500-(Station(i,locateStation)-(250+600*pi/2)*ratio)/ratio)*[1 1];
            y=[550 850]+300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
        end
    elseif Station(i,locateStation)>=(1250+600*pi/2)*ratio && Station(i,locateStation)<=(1250+600*pi)*ratio
        if Station(i,locateStation)+areaStation/2>=(1250+600*pi)*ratio
            angle=((1250+600*pi)*ratio-Station(i,locateStation)+areaStation/2)/(600*ratio);
            xt=@(t) 600*cos(t)-500-300*fun;
            yt=@(t) 600*sin(t)+250;
            fplot(xt,yt,[pi-angle pi],'r','LineWidth',3);
            x=[-1100 -1100]-300*fun*[1 1];
            y=[250 250-(Station(i,locateStation)+areaStation/2-(1250+600*pi)*ratio)/ratio];
            plot(x,y,'r','LineWidth',3);
            xt=@(t) 600*cos(t)-200-300*fun;
            yt=@(t) 600*sin(t)+250;
            fplot(xt,yt,[pi-angle pi],'r','LineWidth',3);
            x=[-800 -800]-300*fun*[1 1];
            y=[250 250-(Station(i,locateStation)+areaStation/2-(1250+600*pi)*ratio)/ratio];
            plot(x,y,'r','LineWidth',3);
            anglestation=((1250+600*pi)*ratio-Station(i,locateStation))/(600*ratio);
            x=[600*cos(pi-anglestation)-200 600*cos(pi-anglestation)-500]-300*fun*[1 1];
            y=[600*sin(pi-anglestation)+250 600*sin(pi-anglestation)+250];
            plot(x,y,'r','LineWidth',3);
        elseif Station(i,locateStation)-areaStation/2<=(1250+600*pi/2)*ratio
            angle=(Station(i,locateStation)+areaStation/2-(1250+600*pi/2)*ratio)/(600*ratio);
            xt=@(t) 600*cos(t)-500;
            yt=@(t) 600*sin(t)+250+300*fun;
            fplot(xt,yt,[pi/2 pi/2+angle],'r','LineWidth',3);
            x=[-500 -500+((1250+600*pi/2)*ratio-Station(i,locateStation)+areaStation/2)/ratio];
            y=[850 850]+300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
            xt=@(t) 600*cos(t)-500;
            yt=@(t) 600*sin(t)-50+300*fun;
            fplot(xt,yt,[pi/2 pi/2+angle],'r','LineWidth',3);
            x=[-500 -500+((1250+600*pi/2)*ratio-Station(i,locateStation)+areaStation/2)/ratio];
            y=[550 550]+300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
            anglestation=(Station(i,locateStation)-(1250+600*pi/2)*ratio)/(600*ratio);
            x=[600*cos(pi/2+anglestation)-500 600*cos(pi/2+anglestation)-500];
            y=[600*sin(pi/2+anglestation)-50 600*sin(pi/2+anglestation)+250]+300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
        else
            anglestation=(Station(i,locateStation)-(1250+600*pi/2)*ratio)/(600*ratio)+pi/2;
            angle=areaStation/(600*ratio);
            xt=@(t) 600*cos(t)-500+300*fun*cos(anglestation);
            yt=@(t) 600*sin(t)+250+300*fun*sin(anglestation);
            fplot(xt,yt,[anglestation-angle/2 anglestation+angle/2],'r','LineWidth',3);
            xt=@(t) 600*cos(t)-500-300*cos(anglestation)+300*fun*cos(anglestation);
            yt=@(t) 600*sin(t)+250-300*sin(anglestation)+300*fun*sin(anglestation);
            fplot(xt,yt,[anglestation-angle/2 anglestation+angle/2],'r','LineWidth',3);
            x=[300*cos(anglestation)-500 600*cos(anglestation)-500]+300*fun*cos(anglestation)*[1 1];
            y=[300*sin(anglestation)+250 600*sin(anglestation)+250]+300*fun*sin(anglestation)*[1 1];
            plot(x,y,'r','LineWidth',3);
        end
    elseif Station(i,locateStation)>(1250+600*pi)*ratio && Station(i,locateStation)<(1750+600*pi)*ratio
        if Station(i,locateStation)+areaStation/2>=(1750+600*pi)*ratio
            angle=(Station(i,locateStation)+areaStation/2-(1750+600*pi)*ratio)/(600*ratio)+pi;
            x=[-1100 -1100]-300*fun*[1 1];
            y=[-250 -250+((1750+600*pi)*ratio-Station(i,locateStation)+areaStation/2)/ratio];
            plot(x,y,'r','LineWidth',3);
            xt=@(t) 600*cos(t)-500-300*fun;
            yt=@(t) 600*sin(t)-250;
            fplot(xt,yt,[pi angle],'r','LineWidth',3);
            x=[-800 -800]-300*fun*[1 1];
            y=[-250 -250+((1750+600*pi)*ratio-Station(i,locateStation)+areaStation/2)/ratio];
            plot(x,y,'r','LineWidth',3);
            xt=@(t) 600*cos(t)-200-300*fun;
            yt=@(t) 600*sin(t)-250;
            fplot(xt,yt,[pi angle],'r','LineWidth',3);
            x=[-1100 -800]-300*fun*[1 1];
            y=-250+((1750+600*pi)*ratio-Station(i,locateStation))/ratio*[1 1];
            plot(x,y,'r','LineWidth',3);
        elseif Station(i,locateStation)-areaStation/2<=(1250+600*pi)*ratio
            angle=((1250+600*pi)*ratio-Station(i,locateStation)+areaStation/2)/(600*ratio);
            xt=@(t) 600*cos(t)-500-300*fun;
            yt=@(t) 600*sin(t)+250;
            fplot(xt,yt,[pi-angle pi],'r','LineWidth',3);
            x=[-1100 -1100]-300*fun*[1 1];
            y=[250 250-(Station(i,locateStation)+areaStation/2-(1250+600*pi)*ratio)/ratio];
            plot(x,y,'r','LineWidth',3);
            xt=@(t) 600*cos(t)-200-300*fun;
            yt=@(t) 600*sin(t)+250;
            fplot(xt,yt,[pi-angle pi],'r','LineWidth',3);
            x=[-800 -800]-300*fun*[1 1];
            y=[250 250-(Station(i,locateStation)+areaStation/2-(1250+600*pi)*ratio)/ratio];
            plot(x,y,'r','LineWidth',3);
            x=[-1100 -800]-300*fun*[1 1];
            y=(250-(Station(i,locateStation)-(1250+600*pi)*ratio)/ratio)*[1 1];
            plot(x,y,'r','LineWidth',3);
        else
            x=[-1100 -1100]-300*fun*[1 1];
            y=250*[1 1]-(Station(i,locateStation)-(1250+600*pi)*ratio)/ratio*[1 1]-areaStation/(2*ratio)*[-1 1];
            plot(x,y,'r','LineWidth',3);
            x=[-800 -800]-300*fun*[1 1];
            y=250*[1 1]-(Station(i,locateStation)-(1250+600*pi)*ratio)/ratio*[1 1]-areaStation/(2*ratio)*[-1 1];
            plot(x,y,'r','LineWidth',3);
            x=[-1100 -800]-300*fun*[1 1];
            y=250*[1 1]-(Station(i,locateStation)-(1250+600*pi)*ratio)/ratio*[1 1];
            plot(x,y,'r','LineWidth',3);
        end
    elseif Station(i,locateStation)>=(1750+600*pi)*ratio && Station(i,locateStation)<=(1750+900*pi)*ratio
        if Station(i,locateStation)-areaStation/2 <=(1750+600*pi)*ratio
            angle=(Station(i,locateStation)+areaStation/2-(1750+600*pi)*ratio)/(600*ratio);
            xt=@(t) 600*cos(t)-500-300*fun;
            yt=@(t) 600*sin(t)-250;
            fplot(xt,yt,[pi pi+angle],'r','LineWidth',3);
            x=[-1100 -1100]-300*fun*[1 1];
            y=[-250 -250+((1750+600*pi)*ratio-Station(i,locateStation)+areaStation/2)/ratio];
            plot(x,y,'r','LineWidth',3);
            xt=@(t) 600*cos(t)-200-300*fun;
            yt=@(t) 600*sin(t)-250;
            fplot(xt,yt,[pi pi+angle],'r','LineWidth',3);
            x=[-800 -800]-300*fun*[1 1];
            y=[-250 -250+((1750+600*pi)*ratio-Station(i,locateStation)+areaStation/2)/ratio];
            plot(x,y,'r','LineWidth',3);
            anglestation=(Station(i,locateStation)-(1750+600*pi)*ratio)/(600*ratio);
            x=[600*cos(pi+anglestation)-500 600*cos(pi+anglestation)-200]-300*fun*[1 1];
            y=[600*sin(pi+anglestation)-250 600*sin(pi+anglestation)-250];
            plot(x,y,'r','LineWidth',3);
        elseif Station(i,locateStation)+areaStation/2>=(1750+900*pi)*ratio
            angle=((1750+900*pi)*ratio-Station(i,locateStation)+areaStation/2)/(600*ratio);
            xt=@(t) 600*cos(t)-500;
            yt=@(t) 600*sin(t)-250-300*fun;
            fplot(xt,yt,[3*pi/2-angle 3*pi/2],'r','LineWidth',3);
            x=[-500 -500+(Station(i,locateStation)+areaStation/2-(1750+900*pi)*ratio)/ratio];
            y=[-850 -850]-300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
            xt=@(t) 600*cos(t)-500;
            yt=@(t) 600*sin(t)+50-300*fun;
            fplot(xt,yt,[3*pi/2-angle 3*pi/2],'r','LineWidth',3);
            x=[-500 -500+(Station(i,locateStation)+areaStation/2-(1750+900*pi)*ratio)/ratio];
            y=[-550 -550]-300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
            anglestation=(Station(i,locateStation)-(1750+600*pi)*ratio)/(600*ratio);
            x=[600*cos(pi+anglestation)-500 600*cos(pi+anglestation)-500];
            y=[600*sin(pi+anglestation)-250 600*sin(pi+anglestation)+50]-300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
        else
            angle=areaStation/(600*ratio);
            anglestation=(Station(i,locateStation)-(1750+600*pi)*ratio)/(600*ratio)+pi;
            xt=@(t) 600*cos(t)-500+300*fun*cos(anglestation);
            yt=@(t) 600*sin(t)-250+300*fun*sin(anglestation);
            fplot(xt,yt,[anglestation-angle/2 anglestation+angle/2],'r','LineWidth',3);
            xt=@(t) 600*cos(t)-500-300*cos(anglestation)+300*fun*cos(anglestation);
            yt=@(t) 600*sin(t)-250-300*sin(anglestation)+300*fun*sin(anglestation);
            fplot(xt,yt,[anglestation-angle/2 anglestation+angle/2],'r','LineWidth',3);
            x=[300*cos(anglestation)-500 600*cos(anglestation)-500]+300*fun*cos(anglestation)*[1 1];
            y=[300*sin(anglestation)-250 600*sin(anglestation)-250]+300*fun*sin(anglestation)*[1 1];
            plot(x,y,'r','LineWidth',3);
        end
    elseif Station(i,locateStation)>(1750+900*pi)*ratio && Station(i,locateStation)<(2750+900*pi)*ratio
        if Station(i,locateStation)-areaStation/2<=(1750+900*pi)*ratio
            angle=((1750+900*pi)*ratio-Station(i,locateStation)+areaStation/2)/(600*ratio);
            xt=@(t) 600*cos(t)-500;
            yt=@(t) 600*sin(t)-250-300*fun;
            fplot(xt,yt,[3*pi/2-angle 3*pi/2],'r','LineWidth',3);
            x=[-500 -500+(Station(i,locateStation)+areaStation/2-(1750+900*pi)*ratio)/ratio];
            y=[-850 -850]-300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
            xt=@(t) 600*cos(t)-500;
            yt=@(t) 600*sin(t)+50-300*fun;
            fplot(xt,yt,[3*pi/2-angle 3*pi/2],'r','LineWidth',3);
            x=[-500 -500+(Station(i,locateStation)+areaStation/2-(1750+900*pi)*ratio)/ratio];
            y=[-550 -550]-300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
            x=(-500+(Station(i,locateStation)-(1750+900*pi)*ratio)/ratio)*[1 1];
            y=[-550 -850]-300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
        elseif Station(i,locateStation)+areaStation/2>=(2750+900*pi)*ratio
            angle=(Station(i,locateStation)+areaStation/2-(2750+900*pi)*ratio)/(600*ratio);
            xt=@(t) 600*cos(t)+500;
            yt=@(t) 600*sin(t)-250-300*fun;
            fplot(xt,yt,[-pi/2 -pi/2+angle],'r','LineWidth',3);
            x=[500 500-((2750+900*pi)*ratio-Station(i,locateStation)+areaStation/2)/ratio];
            y=[-850 -850]-300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
            xt=@(t) 600*cos(t)+500;
            yt=@(t) 600*sin(t)+50-300*fun;
            fplot(xt,yt,[-pi/2 -pi/2+angle],'r','LineWidth',3);
            x=[500 500-((2750+900*pi)*ratio-Station(i,locateStation)+areaStation/2)/ratio];
            y=[-550 -550]-300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
            x=(-500+(Station(i,locateStation)-(1750+900*pi)*ratio)/ratio)*[1 1];
            y=[-550 -850]-300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
        else
            x=(-500+(Station(i,locateStation)-(1750+900*pi)*ratio)/ratio)*[1 1]+areaStation/2*[1 -1];
            y=[-850 -850]-300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
            x=(-500+(Station(i,locateStation)-(1750+900*pi)*ratio)/ratio)*[1 1]+areaStation/2*[1 -1];
            y=[-550 -550]-300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
            x=(-500+(Station(i,locateStation)-(1750+900*pi)*ratio)/ratio)*[1 1];
            y=[-550 -850]-300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
        end
    elseif Station(i,locateStation)>=(2750+900*pi)*ratio && Station(i,locateStation)<=(2750+1200*pi)*ratio
        if Station(i,locateStation)-areaStation/2<=(2750+900*pi)*ratio
            angle=(Station(i,locateStation)+areaStation/2-(2750+900*pi)*ratio)/(600*ratio);
            xt=@(t) 600*cos(t)+500;
            yt=@(t) 600*sin(t)-250-300*fun;
            fplot(xt,yt,[-pi/2 -pi/2+angle],'r','LineWidth',3);
            x=[500 500-((2750+900*pi)*ratio-Station(i,locateStation)+areaStation/2)/ratio];
            y=[-850 -850]-300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
            xt=@(t) 600*cos(t)+500;
            yt=@(t) 600*sin(t)+50-300*fun;
            fplot(xt,yt,[-pi/2 -pi/2+angle],'r','LineWidth',3);
            x=[500 500-((2750+900*pi)*ratio-Station(i,locateStation)+areaStation/2)/ratio];
            y=[-550 -550]-300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
            anglestaion=(Station(i,locateStation)-(2750+900*pi)*ratio)/(600*ratio);
            x=[600*cos(anglestaion-pi/2)+500 600*cos(anglestaion-pi/2)+500];
            y=[600*sin(anglestaion-pi/2)+50 600*sin(anglestaion-pi/2)-250]-300*fun*[1 1];
            plot(x,y,'r','LineWidth',3);
        elseif Station(i,locateStation)+areaStation/2>=(2750+1200*pi)*ratio
            angle=((2750+1200*pi)*ratio-Station(i,locateStation)+areaStation/2)/(600*ratio);
            xt=@(t) 600*cos(t)+500+300*fun;
            yt=@(t) 600*sin(t)-250;
            fplot(xt,yt,[-angle 0],'r','LineWidth',3);
            x=[1100 1100]+300*fun*[1 1];
            y=[-250 -250+(Station(i,locateStation)+areaStation/2-(2750+1200*pi)*ratio)/ratio];
            plot(x,y,'r','LineWidth',3);
            xt=@(t) 600*cos(t)+200+300*fun;
            yt=@(t) 600*sin(t)-250;
            fplot(xt,yt,[-angle 0],'r','LineWidth',3);
            x=[800 800]+300*fun*[1 1];
            y=[-250 -250+(Station(i,locateStation)+areaStation/2-(2750+1200*pi)*ratio)/ratio];
            plot(x,y,'r','LineWidth',3);
            anglestation=((2750+1200*pi)*ratio-Station(i,locateStation))/(600*ratio);
            x=[600*cos(-anglestation)+200 600*cos(-anglestation)+500]+300*fun*[1 1];
            y=[600*sin(-anglestation)-250 600*sin(-anglestation)-250];
            plot(x,y,'r','LineWidth',3);
        else
            anglestation=(Station(i,locateStation)-(2750+900*pi)*ratio)/(600*ratio)+3/2*pi;
            angle=areaStation/600*1/ratio;
            xt=@(t) 600*cos(t)+500+300*fun*cos(anglestation);
            yt=@(t) 600*sin(t)-250+300*fun*sin(anglestation);
            fplot(xt,yt,[anglestation-angle/2 anglestation+angle/2],'r','LineWidth',3);
            xt=@(t) 600*cos(t)+500-300*cos(anglestation)+300*fun*cos(anglestation);
            yt=@(t) 600*sin(t)-250-300*sin(anglestation)+300*fun*sin(anglestation);
            fplot(xt,yt,[anglestation-angle/2 anglestation+angle/2],'r','LineWidth',3);
            x=[600*cos(anglestation)+500 300*cos(anglestation)+500]+300*fun*cos(anglestation)*[1 1];
            y=[600*sin(anglestation)-250 300*sin(anglestation)-250]+300*fun*sin(anglestation)*[1 1];
            plot(x,y,'r','LineWidth',3);
        end
    else
        if Station(i,locateStation)-areaStation/2<=(2750+1200*pi)*ratio
            angle=((2750+1200*pi)*ratio-Station(i,locateStation)+areaStation/2)/(600*ratio);
            xt=@(t) 600*cos(t)+500+300*fun;
            yt=@(t) 600*sin(t)-250;
            fplot(xt,yt,[-angle 0],'r','LineWidth',3);
            x=[1100 1100]+300*fun*[1 1];
            y=[-250+(Station(i,locateStation)+areaStation/2-(2750+1200*pi)*ratio)/ratio -250];
            plot(x,y,'r','LineWidth',3);
            xt=@(t) 600*cos(t)+200+300*fun;
            yt=@(t) 600*sin(t)-250;
            fplot(xt,yt,[-angle 0],'r','LineWidth',3);
            x=[800 800]+300*fun*[1 1];
            y=[-250+(Station(i,locateStation)+areaStation/2-(2750+1200*pi)*ratio)/ratio -250];
            plot(x,y,'r','LineWidth',3);
            x=[800 1100]+300*fun*[1 1];
            y=(-250+(Station(i,locateStation)-(2750+1200*pi)*ratio)/ratio)*[1 1];
            plot(x,y,'r','LineWidth',3);
        else
            x=[1100 1100]+300*fun*[1 1];
            y=(-250+(Station(i,locateStation)-(2750+1200*pi)*ratio)/ratio)*[1 1]+areaStation/2*1/ratio*[1 -1];
            plot(x,y,'r','LineWidth',3);
            x=[800 800]+300*fun*[1 1];
            y=(-250+(Station(i,locateStation)-(2750+1200*pi)*ratio)/ratio)*[1 1]+areaStation/2*1/ratio*[1 -1];
            plot(x,y,'r','LineWidth',3);
            x=[800 1100]+300*fun*[1 1];
            y=(-250+(Station(i,locateStation)-(2750+1200*pi)*ratio)/ratio)*[1 1];
            plot(x,y,'r','LineWidth',3);
        end
    end
end
hold off;