% Ciklo - program for analysis of histeresic response of materials
% Author: Luka Kurnjek, Version: September 2012

% Idealized diagram for positive cycles with criteria 2/3*Fmax
% Equation for idealization: Epoz*UelP^2/2+Epoz*UelP*(Umax-UelP)=ploscinaP
performance=zeros(4,6);
korakiOvojP=length(OvojnicaMax);
ploscinaP=0;
Umax=0;
OvojnicaMax(end+1,1:2)=OvojnicaMax(end,1:2);
for j=2:korakiOvojP
    deltaU=(OvojnicaMax(j+1,1)-OvojnicaMax(j-1,1))*0.5;
    ploscinaP=ploscinaP+deltaU*OvojnicaMax(j,2);
end
[Fmax,inMax]=max(OvojnicaMax(:,2));
for j=1:korakiOvojP
    if OvojnicaMax(j,2)>=2/3*Fmax
        FtogostP=OvojnicaMax(j,2);
        UtogostP=OvojnicaMax(j,1);
        break
    end
end
Epoz=FtogostP/UtogostP;
for i=inMax+1:korakiOvojP
    if OvojnicaMax(i,2)>=OvojnicaMax(i+1,2)
        if OvojnicaMax(i,2)>=OvojnicaMax(i-1,2)
         if OvojnicaMax(i,2)<=0.8*Fmax           
            Umax=OvojnicaMax(i,1); 
            break
         end
        end
    end  
end
if Umax==0
    Umax=UmejniP;
end
a=Epoz/2; b=-Epoz*Umax; c=ploscinaP;
root1P=((-b+sqrt(b*b-4*a*c))/(2*a));
root2P=((-b-sqrt(b*b-4*a*c))/(2*a));
if root1P<Umax
    if root1P>0
        UelP=root1P;
    else
        UelP=root2P;
    end
    else
        UelP=root2P;
end
OvojnicaMax(end,:)=[];
fmax=OvojnicaMax(inMax,1:2);
umax=OvojnicaMax(end,1:2);
performance(1:2,1:2)=[fmax(2),umax(1);fmax(1),umax(2)];
performance(1:4,3)=[UelP*Epoz; UelP; Umax/UelP; Epoz];

% Idealized diagram for negative cycles for criteria 2/3*Fmin
korakiOvojN=length(OvojnicaMin);
ploscinaN=0;
Umin=0;
OvojnicaMin(end+1,1:2)=OvojnicaMin(end,1:2);
for j=2:korakiOvojN
    deltaU=(OvojnicaMin(j+1,1)-OvojnicaMin(j-1,1))*0.5;
    ploscinaN=ploscinaN+deltaU*OvojnicaMin(j,2);
end
[Fmin,inMin]=min(OvojnicaMin(:,2));
for j=1:korakiOvojN
    if OvojnicaMin(j,2)<=2/3*Fmin
        FtogostN=OvojnicaMin(j,2);
        UtogostN=OvojnicaMin(j,1);
        break
    end
end
Eneg=FtogostN/UtogostN;
for i=inMin+1:korakiOvojN
    if OvojnicaMin(i,2)<=OvojnicaMin(i+1,2)
        if OvojnicaMin(i,2)<=OvojnicaMin(i-1,2)
            if OvojnicaMin(i,2)>=0.8*Fmin
            Umin=OvojnicaMin(i,1);       
            break
            end
        end
    end   
end
if Umin==0
    Umin=UmejniN;
end
a=Eneg/2; b=-Eneg*Umin; c=ploscinaN;
root1N=((-b+sqrt(b*b-4*a*c))/(2*a));
root2N=((-b-sqrt(b*b-4*a*c))/(2*a));
if root1N>Umin
    if root1N<0
        UelN=root1N;
    else
        UelN=root2N;
    end
    else
        UelN=root2N;
end
OvojnicaMin(end,:)=[];
fmin=OvojnicaMin(inMin,1:2);
umin=OvojnicaMin(end,1:2);
performance(3:4,1:2)=[fmin(2),umin(1);fmin(1),umin(2)];
performance(1:4,4)=[UelN*Eneg; UelN; Umin/UelN; Eneg];

% Drawing of envelope and idealization for criteria 2/3Fmax (2/3Fmin)
figure(4);
plot(OvojnicaMax(:,1),OvojnicaMax(:,2),'b'),
xlabel('d (mm)'), ylabel('F (kN)'), title('Pozitivna ovojnica za kriterij 2/3Fmax')
xmax=max(OvojnicaMax(:,1));
xmin=-xmax/10;
ymax=max(OvojnicaMax(:,2));
ymin=-ymax/10;
axis(1.2*[xmin xmax ymin ymax])
grid on
hold on
plot([0,UelP,Umax],[0,UelP*Epoz,UelP*Epoz],'--','color',[0,0.6,0])
hold off
figure(5);
plot(OvojnicaMin(:,1),OvojnicaMin(:,2),'b'),
xlabel('d (mm)'), ylabel('F (kN)'), title('Negativna ovojnica za kriterij 2/3Fmin')
xmin=min(OvojnicaMin(:,1));
xmax=-xmin/10;
ymin=min(OvojnicaMin(:,2));
ymax=-ymin/10;
axis(1.2*[xmin xmax ymin ymax])
grid on
hold on
plot([0,UelN,Umin],[0,UelN*Eneg,UelN*Eneg],'--','color',[0.8,0,0])
hold off
