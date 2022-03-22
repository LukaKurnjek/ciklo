% Ciklo - program for analysis of histeresic response of materials
% Author: Luka Kurnjek, Version: September 2012

% AmplitudeR is the vector of amplitudes calculated from graph displacement(time)
zanka=0;
cikel=0;
for j=1:length(ampP)-1
    zanka=zanka+1;
    if ampP(j+1)-ampP(j)>ampP(j)/14 % 1/14=0.0714 < (60-55)/55=0.091
        cikel=cikel+1; % 60-55 are amplitus which give the critical quotient
        AmplitudeR(cikel,2)=zanka;
        AmplitudeR(cikel,1)=ampP(j);
        zanka=0;
    end
end
AmplitudeR(cikel+1,2)=zanka+1;
AmplitudeR(cikel+1,1)=ampP(end);
zanka=0;
cikel=0;
for j=1:length(ampN)-1
    zanka=zanka+1;
    if ampN(j+1)-ampN(j)<ampN(j)/14
        cikel=cikel+1;
        AmplitudeR(cikel,4)=zanka;
        AmplitudeR(cikel,3)=ampN(j);
        zanka=0;
    end
end
AmplitudeR(cikel+1,4)=zanka+1;
AmplitudeR(cikel+1,3)=ampN(end);

% Control of calculated amplitudes
if length(AmplitudeR)~=length(Amplitude)
    disp('Stevilo racunskih amplitud ni enako st. podanih amplitud')
else
    razlike=0;
    for i=1:length(AmplitudeR)
        razlike=[razlike,abs(Amplitude(i,1)-AmplitudeR(i,1))/Amplitude(i,1)];
    end
    razlike(1)=[];
    for j=1:length(AmplitudeR)
        if razlike(j)>0.1
            disp('Podane Amplitude se ne ujemajo s AmplitudeR na 1/10 razlike.')
            break        
        end
    end
end
