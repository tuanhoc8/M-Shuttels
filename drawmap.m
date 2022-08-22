function drawmap()
   
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
    xt=@(t) 600*cos(t)+500;
    yt=@(t) 600*sin(t)+250;
    fplot(xt,yt,[0 pi/2],'b','LineWidth',3);
    xt=@(t) 600*cos(t)-500;
    yt=@(t) 600*sin(t)+250;
    fplot(xt,yt,[pi/2 pi],'b','LineWidth',3);
    xt=@(t) 600*cos(t)-500;
    yt=@(t) 600*sin(t)-250;
    fplot(xt,yt,[pi 3*pi/2],'b','LineWidth',3);
    
    xt=@(t) 600*cos(t)+500;
    yt=@(t) 600*sin(t)-250;
    fplot(xt,yt,[-pi/2 0],'b','LineWidth',3);
    
    
end