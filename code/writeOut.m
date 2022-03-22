% Ciklo - program for analysis of histeresic response of materials
% Author: Luka Kurnjek, Version: September 2012

% Writes out the calculated amplitudes
AmplitudeR
% We get a table in which there are in the 1st column written the calculated amplitudes
% for positive direction and in the 3rd column for negative direction. In 2nd and 4th 
% column there are the numbers of single snares for one cycling for a single amplitude

% Writes out the limit points of the envelope and mechanical characteristic of walls
performance
% We get a table that has in the 1st column Fmax, Uprip, Fmin, Uprip and in the 2nd
% column there are values from the idealization (Fy, d-elast, ductility, Keff stiffness)
% First two columns are for criteria 2/3Fmax for positive and negative direction and
% the second two are for the criteria of first shear crack for positive and negative direction

% Writes out the matrix for area of every histeresic snare for positive and negative direction
EdPoz
EdNeg
% In EdPoz and EdNeg we write in rows the energies for different amplitude displacements
% in columns we write energies for repetition at one amplitude displacement.

% Writes our the equivalent coefficient of viscosity damping 
ksiP
ksiN
% For all amplitude displacements in rows and all repetition in columns we write
% the matrix of ksi-s
