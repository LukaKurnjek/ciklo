% Ciklo - program for analysis of histeresic response of materials
% Author: Luka Kurnjek, Version: September 2012

% First snare we apply manualy
% In the matrix zanke{1} we have 2x n rows data for 3 or less similar 
% snares that have the same amplitude displacement
% n is the number of snares for one amplitude displacement
zamik=0;
zanka=1;
znacilne{1}(1:2,1)=[0,0];% or [H6(1);sila(1)]
zanke{1}(1:2,1)=[0,0];% or [H6(1);sila(1)]
for i=2:koraki
   zanke{1}(2*zanka-1:2*zanka,i-zamik)=[H6(i);sila(i)];
   if sila(i)<0 % control for jump from + to -
       if sila(i-1)>0
           znacilne{1}(2*zanka-1:2*zanka,4)=[(H6(i)+H6(i-1))/2;0];             
       end
   end
    if sila(i)>0 % control for jump from - to +
       if sila(i-1)<0
           znacilne{1}(2*zanka-1:2*zanka,7)=[(H6(i)+H6(i-1))/2;0];
           zanka=zanka+1;
           zamik=i;
           if zanka==AmplitudeR(1,2)+1% control for start of new cycle
               indeks=i;
               zanka=1;
                break
           end
           znacilne{1}(2*zanka-1:2*zanka,1)=[(H6(i)+H6(i+1))/2;0];
       end
    end
end

% Division of vector Sila and H6 into the matrix of vector points for sample cycles
% In the i-th matrix zanke{i} we have 2x n rows data for 3 or less similar snares
cikel=2;
for i=indeks+1:koraki-1 % -1 because for last control we need i+1
zanke{cikel}(2*zanka-1:2*zanka,i-zamik)=[H6(i);sila(i)];
if sila(i)>0 % control for jump from - to +
    if sila(i-1)<0
        znacilne{cikel}(2*zanka-1:2*zanka,1)=[(H6(i)+H6(i-1))/2;0];            
    end
end
   if sila(i)<0 % control for jump from + to -
       if sila(i-1)>0
           znacilne{cikel}(2*zanka-1:2*zanka,4)=[(H6(i)+H6(i-1))/2;0];      
       end     
   end
if i>indeks+5 % control for jump from - to +
   if sila(i)<0 
       if sila(i+1)>0
           znacilne{cikel}(2*zanka-1:2*zanka,7)=[(H6(i)+H6(i+1))/2;0];
           zanka=zanka+1;
           zamik=i;
           if zanka==AmplitudeR(cikel,2)+1
               cikel=cikel+1;
               zanka=1;
           end
       end
   end
end
end
VsiCikli=cikel;

% Exclusion of last cycle if it is not regulary
s1=size(zanke{VsiCikli});
s2=size(zanke{VsiCikli-1});
UendP=max(max([zanke{VsiCikli}(1:2:s1(1),:)]));
UpredEndP=max(max(zanke{VsiCikli-1}(1:2:s2(1),:)));
if UendP>UpredEndP % if last max displacment is the largest it is a regular cycle
    UmejniP=UendP;
    disp 'Stevilo vseh ciklov je:'
    VsiCikli=cikel
else                          % else we exclude him
    UmejniP=UpredEndP;
%     znacilne{VsiCikli}=0;
%     zanke{VsiCikli}=0;
    disp 'Stevilo vseh ciklov je:'
    VsiCikli=cikel-1
    disp 'Zadnji je bil izlocen'
end
UendN=min(min([zanke{VsiCikli}(1:2:s1(1),:)]));
UpredEndN=min(min(zanke{VsiCikli-1}(1:2:s2(1),:)));
if UendN<UpredEndN
    UmejniN=UendN;
else
    UmejniN=UpredEndN;
end

% Important points of snares
% znacilne{i}; for i-th cycle there are in 2n rows written important points for
% n snares for a single cycle. In odd rows there are displacements and in even
% there are forces. In columns follow points: (d_zac, F=0) (1.toèka), 
% (Fmax, dprip) (2.point), (dmax, Fprip) (3.point), (d_sred, F=0) (4.point), 
% (Fmin, dprip) (5.point), (dmin, Fprip) (6.point), (d_konc, F=0) (7.point)
for i=1:VsiCikli
s=size(zanke{i});
   for zanka=1:s(1)/2
       % Determination of important points for single snares
     [Fmax,inMax]=max(zanke{i}(2*zanka,:));
     uPripMax=zanke{i}(2*zanka-1,inMax);
     znacilne{i}(2*zanka-1:2*zanka,2)=[uPripMax;Fmax];
     [Umax,in]=max(zanke{i}(2*zanka-1,:));
     znacilne{i}(2*zanka-1:2*zanka,3)=[Umax;zanke{i}(2*zanka,in)];
     [Fmin,inMin]=min(zanke{i}(2*zanka,:));
     uPripMin=zanke{i}(2*zanka-1,inMin);
     znacilne{i}(2*zanka-1:2*zanka,5)=[uPripMin;Fmin];
     [Umin,in]=min(zanke{i}(2*zanka-1,:));
     znacilne{i}(2*zanka-1:2*zanka,6)=[Umin;zanke{i}(2*zanka,in)];
   end
end
