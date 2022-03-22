% Ciklo - program for analysis of histeresic response of materials
% Author: Luka Kurnjek, Version: September 2012

% Exclusion of all points which have value for displacment or force 0
izloci=0;
H6=H6_vse;
sila=sila_vse;
for i=2:length(H6)
    if H6(i)==0
        izloci=[izloci,i];
    else
    if sila(i)==0
        izloci=[izloci,i];
    end
    end
end
izloci(1)=''; Time(izloci)='';
H6(izloci)=''; sila(izloci)='';

% First 300 points we exclude if they are negative
% Warning: in the begining the should not be a jump back to negative value
% because then when we process the first snare i can become negative
% For this reason we should look through the first points by hand.
izloci=0;
for i=1:300
    if H6(i)>0.8*Amplitude(1,1)
        break
    end
    if H6(i)<0
        izloci=[izloci,i];
    else
        if sila(i)<0
            izloci=[izloci,i];
        end
    end
end
izloci(1)=''; Time(izloci)='';
H6(izloci)=''; sila(izloci)='';
koraki=length(H6);
                 
% Exclusion of points for oscillation around 0
zanka=0; cikel=1;
start=1; izlociAmp=0;
ampP=Amplitude(1,1);
ampN=-Amplitude(1,1);
for i=1:koraki-1
    if H6(i)>0
        if H6(i+1)<0            
            amp=max(H6(start:i));
            if amp<0.8*ampP(end) % next amplitude can be a little lower
            % if it is lower for more then 80% we exclude her
                izlociAmp=[izlociAmp,start:i];
            else
                ampP=[ampP;amp];
            end
            start=i+1;
        end
    end
    if H6(i)<0
        if H6(i+1)>0
           amp=min(H6(start:i));
            if amp>0.8*ampN(end)
                izlociAmp=[izlociAmp,start:i];
            else
                ampN=[ampN;amp];
            end
            start=i+1;
        end
    end
end
izlociAmp=[izlociAmp,koraki];
izlociAmp(1)=''; Time(izlociAmp)='';
H6(izlociAmp)=''; sila(izlociAmp)='';
ampP(1)=''; ampN(1)='';
koraki=length(H6);

% Exclusion of points where the force oscilates around 0
zanka=0; cikel=1;
start=1; izlociAmp=0;
SilaAmpP=5;
SilaAmpN=-5;
for i=1:koraki-1
    if sila(i)>0
        if sila(i+1)<0            
            amp=max(sila(start:i));
            if amp<0.6*SilaAmpP(end)
                izlociAmp=[izlociAmp,start:i];
            else
                SilaAmpP=[SilaAmpP;amp];
            end
            start=i+1;
        end
    end
    if sila(i)<0
        if sila(i+1)>0
           amp=min(sila(start:i));
            if amp>0.6*SilaAmpN(end)
                izlociAmp=[izlociAmp,start:i];
            else
                SilaAmpN=[SilaAmpN;amp];
            end
            start=i+1;
        end
    end
end
izlociAmp=[izlociAmp,koraki];
izlociAmp(1)=''; Time(izlociAmp)='';
H6(izlociAmp)=''; sila(izlociAmp)='';
SilaAmpP(1)=''; SilaAmpN(1)='';
koraki=length(H6);
