%Linear assignment problem

%Cost weights
metrics1=["Accuracy","Change","Attention","Demand","Preference"];
w1=[0.21,0.14,0.29,0.14,0.21];
metrics2=["Accuracy","Change","Attention","Preference"];
w2=[0.25,0.17,0.34	,0.25];
metrics3=["Accuracy","Attention","Preference"];
w3=[0.30,0.41,0.30];
%Order: LL, Weight, Temp
%VD;Aud;Vib;Hap;Therm

% errmat=[0,0,0,0.148148148148148,inf;0,0,0.135802469125926,0.123456790114815,inf;0,0,0.092592592603704,inf,0.160493827166667;inf(1,5);inf(1,5)]';
% HRmat=[54.0720082391482,65.7279808677778,67.1806948192593,57.0758562430000,inf;58.6924344118519,76.9909230692593,65.2288920711111,61.8452223767778,inf;68.826615771851860,78.687002298888900,67.039246761851860,inf,64.637989854814800;inf(1,5);inf(1,5)]';
% HRmat=HRmat./100;
% prefmat=[0.777777777788889,0.481481481477778,0.592592592588889,0.148148148144444,inf;0.777777777788889,0.629629629633333,0.185185185177778,0.407407407400000,inf;0.851851851866667,0.703703703722222,0.259259259233333,inf,0.074074074066667;inf(1,5);inf(1,5)]';
% RTmat=[0.561746440869016,0.550279856851683,0.535026989700836,0.549923944369462, inf;0.334993797348898,0.281349929208954,0.314728646316692,0.355046487636041,inf;0.774296631481482,0.726633066296296,0.810833748518519,inf,0.850321937777778;inf(1,5);inf(1,5)]';
% Resmat=[1,0.944444444444444,0.944444444444444,0.888888888888889,inf;0.777777777777778,0.666666666666667,0.888888888888889,0.944444444444444,inf;0.944444444444444,0.777777777777778,0.944444444444444,inf,0.777777777777778;inf(1,5);inf(1,5)]';

errmat=[0,0,0,0.148148148148148,inf;0,0,0.135802469125926,0.123456790114815,inf;0,0,0.092592592603704,inf,0.160493827166667;inf(1,5);inf(1,5)]';
HRmat=[100,100,100,100,inf;58.6924344118519,76.9909230692593,65.2288920711111,61.8452223767778,inf;68.826615771851860,78.687002298888900,67.039246761851860,inf,64.637989854814800;inf(1,5);inf(1,5)]';
HRmat=HRmat./100;
prefmat=[0.777777777788889,0.481481481477778,0.592592592588889,0.148148148144444,inf;0.777777777788889,0.629629629633333,0.185185185177778,0.407407407400000,inf;0.851851851866667,0.703703703722222,0.259259259233333,inf,0.074074074066667;inf(1,5);inf(1,5)]';
RTmat=[0.561746440869016,0.550279856851683,0.535026989700836,0.549923944369462, inf;0.334993797348898,0.281349929208954,0.314728646316692,0.355046487636041,inf;0.774296631481482,0.726633066296296,0.810833748518519,inf,0.850321937777778;inf(1,5);inf(1,5)]';
Resmat=[1,1,1,1,inf;0.777777777777778,0.666666666666667,0.888888888888889,0.944444444444444,inf;1,1,1,inf,1;inf(1,5);inf(1,5)]';

%Construct cost matrix
%C=zeros(5,5);
%With all metrics
C=(w1(1).*errmat)+(w1(2).*(1-Resmat))+(w1(3).*(1-HRmat))+(w1(4).*RTmat)+(w1(5).*(1-prefmat));
nanc=isnan(C);
C(nanc)=inf;
[match,uR,uC]=matchpairs(C,10000,'min');

%Without RT
C2=(w2(1).*errmat)+(w2(2).*(1-Resmat))+(w2(3).*(1-HRmat))+(w2(4).*(1-prefmat));
nanc2=isnan(C2);
C2(nanc2)=inf;
[match2,uR2,uC2]=matchpairs(C2,10000,'min');

%Without Resolution
C3=(w3(1).*errmat)+(w3(2).*(1-HRmat))+(w3(3).*(1-prefmat));
nanc3=isnan(C3);
C3(nanc3)=inf;
[match3,uR3,uC3]=matchpairs(C3,10000,'min');

TC1 = array2table(C);
% Default heading for the columns will be A1, A2 and so on. 
% You can assign the specific headings to your table in the following manner
TC1.Properties.VariableNames(1:3) = {'Liquid Level','Weight','Temperature'};
TC1.Properties.RowNames(1:5) = {'Visual','Audio','Vibration','Haptic','Thermal'};

TC2 = array2table(C2);
% Default heading for the columns will be A1, A2 and so on. 
% You can assign the specific headings to your table in the following manner
TC2.Properties.VariableNames(1:3) = {'Liquid Level','Weight','Temperature'};
TC2.Properties.RowNames(1:5) = {'Visual','Audio','Vibration','Haptic','Thermal'};

TC3 = array2table(C3);
% Default heading for the columns will be A1, A2 and so on. 
% You can assign the specific headings to your table in the following manner
TC3.Properties.VariableNames(1:3) = {'Liquid Level','Weight','Temperature'};
TC3.Properties.RowNames(1:5) = {'Visual','Audio','Vibration','Haptic','Thermal'};
