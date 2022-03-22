% Ciklo - program for analysis of histeresic response of materials
% Author: Luka Kurnjek, Version: September 2012

% Determination of envelopes
OvojnicaMax=[0,0]; % positive envelope
Umeja=0;
for i=1:VsiCikli
   obmocje=find(zanke{i}(1,:)>Umeja);
    inZac=obmocje(1);
    [umax,inMax]=max(zanke{i}(1,:));
    if i==VsiCikli
        [umax,inMax]=max(zanke{i}(1,:));
    end
    FovojMax=zanke{i}(1:2,inZac:inMax);
    OvojnicaMax=[OvojnicaMax;FovojMax']; 
    Umeja=umax;
end
OvojnicaMin=[0,0]; % negative envelope
Umeja=0;
for i=1:VsiCikli
   obmocje=find(zanke{i}(1,:)<Umeja);
    inZac=obmocje(1);
    [umin,inMin]=min(zanke{i}(1,:));
    if i==VsiCikli
        [umin,inMin]=min(zanke{i}(1,:));  
    end
    FovojMin=zanke{i}(1:2,inZac:inMin);
    OvojnicaMin=[OvojnicaMin;FovojMin'];
    Umeja=umin;
end

% Drawing of envelope
figure(3);
plot(OvojnicaMax(:,1),OvojnicaMax(:,2),'b'), % positive envelope
xlabel('d (mm)'), ylabel('F (kN)'), title('Pozitivna in negativna ovojnica')
xmax=max(OvojnicaMax(:,1));
ymax=max(OvojnicaMax(:,2));
hold on
plot(OvojnicaMin(:,1),OvojnicaMin(:,2),'r') % negative envelope
xmin=min(OvojnicaMin(:,1));
ymin=min(OvojnicaMin(:,2));
axis(1.2*[xmin xmax ymin ymax])
grid on
hold off
