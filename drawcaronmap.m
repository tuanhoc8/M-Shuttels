function drawcaronmap(matrixcar,length)
    kc=200;
    
    ratio=length/(3000+1200*pi);
    %matrixcar
    namecar=1;
    location=2;
    action=7;
        carstop=-4;
    indogde=9;
    [soxe,~]=size(matrixcar);
    for car=1:soxe
        if matrixcar(car,action)<=carstop || matrixcar(car,indogde)==1
            continue;
        else
            locate=matrixcar(car,location);
            if locate<=250*ratio
                x=1100;
                y=locate/ratio;
                txt=['car ' num2str(matrixcar(car,namecar))];
                text(x+kc,y,txt,'HorizontalAlignment','left','Color','k');
                plot(x,y,'o','LineWidth',3,'Color','k');
            elseif locate>250*ratio && locate<(250+300*pi)*ratio
                angle=(locate-250*ratio)/(600*ratio);
                x=600*cos(angle)+500;
                y=600*sin(angle)+250;
                txt=['car ' num2str(matrixcar(car,namecar))];
                text(x+kc*cos(angle),y+kc*sin(angle),txt,'HorizontalAlignment','left','Color','k');
                plot(x,y,'o','LineWidth',3,'Color','k');
            elseif locate>=(250+300*pi)*ratio && locate<=(1250+300*pi)*ratio
                x=500-(locate-(250+300*pi)*ratio)/ratio;
                y=850;
                txt=['car ' num2str(matrixcar(car,namecar))];
                text(x,y+kc,txt,'HorizontalAlignment','center','Color','k');
                plot(x,y,'o','LineWidth',3,'Color','k');
            elseif locate>(1250+300*pi)*ratio && locate<(1250+600*pi)*ratio
                angle=pi/2+(locate-(1250+300*pi)*ratio)/(600*ratio);
                x= 600*cos(angle)-500;
                y= 600*sin(angle)+250;
                txt=['car ' num2str(matrixcar(car,namecar))];
                text(x+kc*cos(angle),y+kc*sin(angle),txt,'HorizontalAlignment','right','Color','k');
                plot(x,y,'o','LineWidth',3,'Color','k');
            elseif locate>=(1250+600*pi)*ratio && locate<=(1750+600*pi)*ratio
                x=-1100;
                y=250-(locate-(1250+600*pi)*ratio)/ratio;
                txt=['car ' num2str(matrixcar(car,namecar))];
                text(x-kc,y,txt,'HorizontalAlignment','right','Color','k');
                plot(x,y,'o','LineWidth',3,'Color','k');
            elseif locate>(1750+600*pi)*ratio && locate<(1750+900*pi)*ratio
                angle=pi+(locate-(1750+600*pi)*ratio)/(600*ratio);
                x= 600*cos(angle)-500;
                y= 600*sin(angle)-250;
                txt=['car ' num2str(matrixcar(car,namecar))];
                text(x+kc*cos(angle),y+kc*sin(angle),txt,'HorizontalAlignment','right','Color','k');
                plot(x,y,'o','LineWidth',3,'Color','k');
            elseif locate>=(1750+900*pi)*ratio && locate<=(2750+900*pi)*ratio
                x=-500+(locate-(1750+900*pi)*ratio)/ratio;
                y=-850;
                txt=['car ' num2str(matrixcar(car,namecar))];
                text(x,y-kc,txt,'HorizontalAlignment','center','Color','k');
                plot(x,y,'o','LineWidth',3,'Color','k');
            elseif locate>(2750+900*pi)*ratio && locate<(2750+1200*pi)*ratio
                angle=3*pi/2+(locate-(2750+900*pi)*ratio)/(600*ratio);
                x= 600*cos(angle)+500;
                y= 600*sin(angle)-250;
                txt=['car ' num2str(matrixcar(car,namecar))];
                text(x+kc*cos(angle),y+kc*sin(angle),txt,'HorizontalAlignment','left','Color','k');
                plot(x,y,'o','LineWidth',3,'Color','k');
            else
                x=1100;
                y=-250+(locate-(2750+1200*pi)*ratio)/(600*ratio);
                txt=['car ' num2str(matrixcar(car,namecar))];
                text(x+kc,y,txt,'HorizontalAlignment','left','Color','k');
                plot(x,y,'o','LineWidth',3,'Color','k');
            end
        end
    end
end