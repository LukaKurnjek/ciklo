%Ciklo - program for analysis of histeresic response of materials
%Author: Luka Kurnjek, Version: September 2012

% We determine the matrix for points of all stiffnesses of snares and their displacements
% In one row first the stifness in written and its displacement
TogostiP=[0,0]; TogostiN=[0,0];
TogostiPMat=0; TogostiNMat=0;
for j=1:VsiCikli
    s=size(znacilne{j});
    for i=1:s(1)/2
        TogostiP=[TogostiP; znacilne{j}(2*i,2)/znacilne{j}(2*i-1,2), znacilne{j}(2*i-1,2)];
        TogostiN=[TogostiN; znacilne{j}(2*i,5)/znacilne{j}(2*i-1,5), -znacilne{j}(2*i-1,5)];
        % We use the units N and m
        TogostiPMat(j,2*i-1:2*i)=[znacilne{j}(2*i,2)/znacilne{j}(2*i-1,2)*10^6, znacilne{j}(2*i-1,2)*10^-3];
        TogostiNMat(j,2*i-1:2*i)=[znacilne{j}(2*i,5)/znacilne{j}(2*i-1,5)*10^6, -znacilne{j}(2*i-1,5)*10^-3];
    end
end
TogostiP(1,:)=[];
TogostiN(1,:)=[];

% We interpolate points for stiffness and displacements with a hyperbolic function y(x) = a/(x^n)
% For n 0.01, 0.02, ..., 1 we set with the method of levelling with logarithems and calculate
% the value r2 for a specific n and a. The largest r^2 means that the acompanied function 
% is the best approximation for the given stiffness and displacement. 
% A perfect fit we would get for the value r^2=1.
interpFunkP=[0,0,0]; % Code for positive stiffness
s=size(TogostiP);
for j=1:100
    n=j/100;
    a=10^(1/s(1)*(sum(log10(TogostiP(:,1)))+n*sum(log10(TogostiP(:,2)))));
    Ymean=mean(TogostiP(:,1));
    S=sum((TogostiP(:,1)-Ymean).^2);
    A=sum((a./(TogostiP(:,2).^n)-TogostiP(:,1)).^2);
    r2=1-A/S;
    interpFunkP=[interpFunkP; n, a, r2];
end
interpFunkP(1,:)=[];
[r2maxP, in]=max(interpFunkP(:,3));
n=interpFunkP(in,1);
a=interpFunkP(in,2);
disp 'Interpolacijska natancnost r^2 pri pozitivni interpolaciji je:'
r2maxP
figure(10);
funkP=[TogostiP(:,2), a./TogostiP(:,2).^n];
plot(funkP(:,1),funkP(:,2), 'color',[0,0,0.6])
hold on
plot(TogostiP(:,2), TogostiP(:,1), '^','color',[0,0.5,0])
xlabel('d (mm)'), ylabel('Kp (kN/mm)'), title 'Upadanje pozitivnih togosti'
axis([-0.05*TogostiP(end,2), 1.1*TogostiP(end,2), -0.05*TogostiP(1,1), 1.1*a/TogostiP(1,2)^n])
grid on
hold off
interpFunkN=[0,0,0]; % Code for negative stiffnesses
s=size(TogostiN);
for j=1:100
    n=j/100;
    a=10^(1/s(1)*(sum(log10(TogostiN(:,1)))+n*sum(log10(TogostiN(:,2)))));
    Ymean=mean(TogostiN(:,1));
    S=sum((TogostiN(:,1)-Ymean).^2);
    A=sum((a./(TogostiN(:,2).^n)-TogostiN(:,1)).^2);
    r2=1-A/S;
    interpFunkN=[interpFunkN; n, a, r2];
end
interpFunkN(1,:)=[];
[r2maxN, in]=max(interpFunkN(:,3));
n=interpFunkN(in,1);
a=interpFunkN(in,2);
disp 'Interpolacijska natancnost r^2 pri negativni interpolaciji je:'
r2maxN
figure(11);
funkN=[TogostiN(:,2), a./TogostiN(:,2).^n];
plot(funkN(:,1),funkN(:,2), 'color',[0,0,0.6])
hold on
plot(TogostiN(:,2), TogostiN(:,1), '^','color',[0,0.5,0])
xlabel('d (mm)'), ylabel('Kn (kN/mm)'), title 'Upadanje negativnih togosti'
axis([-0.05*TogostiN(end,2), 1.1*TogostiN(end,2), -0.05*TogostiN(1,1), 1.1*a/TogostiN(1,2)^n])
grid on
hold off

% Determination of surface of every histeresic snare for positive and negative side. 
% In EdNeg we write in rows the energies for different amplitude displacements and in
% columns we write energies for repetitions for one amplitude displacement
EdPoz=0; EdNeg=0;
for i=1:VsiCikli
    s=size(zanke{i});
    for zanka=1:s(1)/2
        ploscinaP=0;
        ploscinaN=0;
        [Umax,inMax]=max(zanke{i}(2*zanka-1,:));
        [Umin,inMin]=min(zanke{i}(2*zanka-1,:));
        for j=2:s(2)-1            
            if zanke{i}(2*zanka,j)>0
                if j<inMax               
                    deltaU=(zanke{i}(2*zanka-1,j+1)-zanke{i}(2*zanka-1,j-1))*0.5;
                    ploscinaP=ploscinaP+deltaU*zanke{i}(2*zanka,j);                                    
                end
                if j>inMax
                deltaU=(-zanke{i}(2*zanka-1,j+1)+zanke{i}(2*zanka-1,j-1))*0.5;
                ploscinaP=ploscinaP-deltaU*zanke{i}(2*zanka,j);
                end
            end
            if zanke{i}(2*zanka,j)<0
                if j<inMin
                deltaU=(-zanke{i}(2*zanka-1,j+1)+zanke{i}(2*zanka-1,j-1))*0.5;
                ploscinaN=ploscinaN+deltaU*(-zanke{i}(2*zanka,j));
                end
                if j>inMin
                deltaU=(zanke{i}(2*zanka-1,j+1)-zanke{i}(2*zanka-1,j-1))*0.5;
                ploscinaN=ploscinaN-deltaU*(-zanke{i}(2*zanka,j));
                end
            end
        end
        EdPoz(i,zanka)=ploscinaP;
        EdNeg(i,zanka)=ploscinaN;
    end
end
 
% Drawing of graph for disipation of energy
% Upper bound for displacement 30mm, for energy 2*1400J for high precompression
% Upper bound for displacement 70mm, for energy 2*750J for low precompression
figure(12);
hold on
s=size(EdPoz);
a=[0,0,0.8;0,0.8,0;0.8,0,0];
Ed=0;
for i=1:s(2)
    for j=1:s(1)
        Ed(j,i)=EdPoz(j,i)+EdNeg(j,i);
    end
end
for i=1:s(2)
    plot(AmplitudeR(:,1),Ed(:,i),'o',AmplitudeR(:,1),Ed(:,i),'color',a(i,:))
end
xlabel('d (mm)'), ylabel('Ed (J)'), title 'Disipacija energije'
axis([0, 1.2*max(AmplitudeR(:,1)), 0, 1.2*max(max(Ed(:,:)))])
grid on
hold off

% Determination of equivalent coefficient of viscosity damping ksi.
% For every amplitude in rows and every repetition in columns we write
% ksi-s in the matrixes ksiP and ksiN
ksiP=0; ksiN=0;
for i=1:VsiCikli
    s=size(znacilne{i});
    for j=1:s(1)/2
        ksiP(i,j)=EdPoz(i,j)/(2*pi*TogostiPMat(i,2*j)^2*TogostiPMat(i,2*j-1));
        ksiN(i,j)=EdNeg(i,j)/(2*pi*TogostiNMat(i,2*j)^2*TogostiNMat(i,2*j-1));
    end
end

% Additional posibilities for interpolation
% s = fitoptions('Method','NonlinearLeastSquares',...
%                 'Lower',[0,0],... %spodnji meji za a in b
%                 'Upper',[100,1],... %zgornji meji za a in b
% vrstni red za a in b jemlje po abecedi in ne po zaporedju v enaèbi
%                 'Startpoint',TogostiP(1,1:2)); % toèka kjer zaène
% Ftype = fittype('a*(x)^(-b)+c','problem','c','options',s);
% [funk,podat] = fit( TogostiP(:,2), TogostiP(:,1), Ftype, 'problem', 0 );
% ali izberemo kar eno od vgrajenih interpolacij kolt kubièna polinomska
% [funk,podat] = fit(TogostiP(:,2), TogostiP(:,1),'poly3');

