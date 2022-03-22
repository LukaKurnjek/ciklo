% Ciklo - program for analysis of histeresic response of materials
% Author: Luka Kurnjek, Version: September 2012

% Deleting data from previous test
clear R
clear R1
clear R2
clear sila_vse
clear H6_vse
clear sila
clear H6
clear zanke
clear znacilne
clear izloci
clear izbrisane
clear vrstice
clear funkcije
clear Ovojnica
clear AmplitudeR
clear ampP
clear ampN
clear izlociAmp
clear SilaAmpN
clear SilaAmpP
clear interpFunkN
clear interpFunkP
clear funkP
clear funkN
clear TogostiP
clear TogostiN
clear TogostiPMat
clear TogostiNMat

% rezultati=load('Str1.mat');
% Time=rezultati.R(:,1);
% sila_vse=rezultati.R(:,23);
% H6_vse=rezultati.R(:,24);

% Results of tests. Big files with over 60.000 lines have to be
% splitted into two files
R=xlsread('sample_data.xlsx','List1','A51:X60352');
Time=R(:,1);
sila_vse=R(:,23);
H6_vse=R(:,24);     


%Control of length for read in vectors
if length(sila_vse) ~= length(H6_vse)
disp('Stevilo tock vektorjev za cas, silo in pomik niso enaka!')
end
if length(Time) ~= length(H6_vse)
disp('Stevilo tock vektorjev za cas, silo in pomik niso enaka!')
end

% Drawing the graph for displacment with time and force with time
Tdolzina=length(Time);
Tplus=0;
for j=2:Tdolzina-1
    if Time(j+1)<Time(j)
        Time(j+1:end)=Time(j+1:end)+2*Time(j)-Time(j-1)-Time(j+1);
    end
end
Time(end)='';
H6_vse(end)='';
sila_vse(end)='';
figure(1); % Figure for displacement
plot(Time, H6_vse, 'b')
xlabel('t (s)'), ylabel('d (mm)'), title('Vodenje pomika')
xmin=min(Time);
xmax=1.1*max(Time);
ymin=1.2*min(H6_vse);
ymax=1.2*max(H6_vse);
axis([xmin xmax ymin ymax])
grid on
figure(2); % Figure for force
plot(Time, sila_vse, 'b')
xlabel('t (s)'), ylabel('F (kN)'), title('Sila v odvisnosti od èasa')
xmin=min(Time);
xmax=1.1*max(Time);
ymin=1.2*min(sila_vse);
ymax=1.2*max(sila_vse);
axis([xmin xmax ymin ymax])
grid on

% Data for cycle amplitudes and number of snares in one cycle. The user gives this input.
% First has to be correct because the program uses it for first assessment.
Amplitude=[0.25, 3      % for sample_data
                     0.5,   3
                     0.75, 3
                     1.0,   3
                     1.5,   3
                     2.0,   3
                     3.0,   3
                     5.0,   3
                     7.5,   3
                     10.0, 3
                     12.5, 3
                     15.0, 3
                     17.5, 3
                     20.0, 3
                     25.0, 3
                     30.0, 3];
                 
        
                 
