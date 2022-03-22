% Ciklo - program for analysis of histeresic response of materials
% Author: Luka Kurnjek, Version: September 2012

% Drawing of charts for all cycles and the choosen cycle with all snares
cikelZaRisat=1; % the user chooses
figure(8);
plot(0,0,'b'), xlabel('d (mm)'), ylabel('F (kN)'), title('Vsi cikli')
hold on
Xmin=0; Xmax=0; Ymin=0; Ymax=0;
for j=1:VsiCikli
% writing down the end 0-points for exclusion from drawing
brisanje1=0;
brisanje2=0;
brisanje3=0;
s=size(zanke{j});
vrstice=1:2:s(1);
if Xmin>min(znacilne{j}(vrstice,6))
    Xmin=min(znacilne{j}(vrstice,6));
end
if Xmax<max(znacilne{j}(vrstice,3))
    Xmax=max(znacilne{j}(vrstice,3));
end
if Ymin>min(znacilne{j}(vrstice+1,5))
    Ymin=min(znacilne{j}(vrstice+1,5));
end
if Ymax<max(znacilne{j}(vrstice+1,2))
    Ymax=max(znacilne{j}(vrstice+1,2));
end
for i=s(2):-1:1
    if zanke{j}(1,i)==0
        if zanke{j}(2,i)==0
        brisanje1=brisanje1+1;
        else
            break
        end
    end
end
figure(8);
plot(zanke{j}(1,1:end-brisanje1),zanke{j}(2,1:end-brisanje1),'b')
if j==cikelZaRisat
    figure(9);
    plot(zanke{j}(1,1:end-brisanje1),zanke{j}(2,1:end-brisanje1),'b'), 
    xlabel('d (mm)'), ylabel('F (kN)'), title('Izbrani cikel')
    hold on
end
if s(1)>2
for i=s(2):-1:1
    if zanke{j}(3,i)==0
        if zanke{j}(4,i)==0
        brisanje2=brisanje2+1;
        else
            break
        end
    end
end
figure(8);
plot(zanke{j}(3,1:end-brisanje2),zanke{j}(4,1:end-brisanje2),'--','color',[0,0.8,0])
if j==cikelZaRisat
    figure(9);
    plot(zanke{j}(3,1:end-brisanje2),zanke{j}(4,1:end-brisanje2),'--','color',[0,0.8,0])
end
end
if s(1)>4
for i=s(2):-1:1
    if zanke{j}(5,i)==0
        if zanke{j}(6,i)==0
        brisanje3=brisanje3+1;
        else           
            break
        end
    end
end
figure(8);
plot(zanke{j}(5,1:end-brisanje3),zanke{j}(6,1:end-brisanje3),'r:')
if j==cikelZaRisat
    figure(9);
    plot(zanke{j}(5,1:end-brisanje3),zanke{j}(6,1:end-brisanje3),'r:')
end
end
end
figure(8);
axis(1.2*[Xmin Xmax Ymin Ymax])
grid on
hold off
xmin=min(znacilne{cikelZaRisat}(vrstice,6));
xmax=max(znacilne{cikelZaRisat}(vrstice,3));
ymin=min(znacilne{cikelZaRisat}(vrstice+1,5));
ymax=max(znacilne{cikelZaRisat}(vrstice+1,2));
figure(9);
axis(1.2*[xmin xmax ymin ymax])
grid on
hold off

