%clear all
addpath 'C:\Users\au213911\Documents\musbeat'
% addpath 'C:\Users\au631438\Documents\PolyRhythm\DATA\Expe2020\PITCH'
% % addpath 'C:\Users\au631438\Documents\WriteEEGtap_infoFiles\EEG_trials_taps\CircStat2012a'
% addpath 'C:\Users\au631438\Documents\PolyRhythm\DATA\FINAL'
% cd 'C:\Users\au631438\Documents\PolyRhythm\DATA\Expe2020\PITCH\reCAT\'
cd 'C:\Users\au213911\Documents\musbeat'
%% 
% NEW re-CATEGORIZATION for all sub and rhythms

%reading myTEMPO table TEMPO
TChosenMeter=table2array(readtable('musbeat_pilot.csv','Range','PE2:PW81', 'ReadVariableNames',false));
Ttapping_dataITI_mean=table2array(readtable('musbeat_pilot.csv','Range','C2:U81', 'ReadVariableNames',false));
Ttapping_dataITI_SD=table2array(readtable('musbeat_pilot.csv','Range','V2:AN81', 'ReadVariableNames',false));

ChosenMeter=nan(size(TChosenMeter)); tapping_dataITI_mean=nan(size(TChosenMeter)); tapping_dataITI_SD=nan(size(TChosenMeter));
for iii=1:size(TChosenMeter,1)
   for iiii=1:size(TChosenMeter,2)
       ChosenMeter(iii,iiii)=str2double(cell2mat([TChosenMeter(iii,iiii)]));
       tapping_dataITI_mean(iii,iiii)=str2double(cell2mat([Ttapping_dataITI_mean(iii,iiii)]));
       tapping_dataITI_SD(iii,iiii)=str2double(cell2mat([Ttapping_dataITI_SD(iii,iiii)]));
   end
end



%for TEMPO fixing back numberCategory: 66->40 (allsub) !!!!!!!!!!!!!!!
ChosenMeter(find( ChosenMeter==66))=40;%

%% info BPM for PITCH (anchor in )

Title={'spontaneous-taps', 'p01-2C307-3C507','p02-2C304-3C510','p03-2C301-3C513','p04-2C507-3C307','p05-2C504-3C310','p06-2C501-3C313','p07-3C307-4C507','p08-3C310-4C504','p09-3C313-4C501','p10-3C507-4C307','p11-3C510-4C304','p12-3C513-4C301','p13-2C407-3C407','p14-2C404-3C410','p15-2C401-3C413','p16-3C407-4C407','p17-3C410-4C404','p18-3C413-4C401'};
%{'spontaneous-taps','t01-2-3-040-060','t02-2-3-060-090','t03-2-3-090-135','t04-2-3-120-180','t05-2-3-135-203','t06-2-3-169-253','t07-2-3-203-304','t08-2-3-304-456','t09-3-4-038-051','t10-3-4-051-068','t11-3-4-068-090','t12-3-4-090-120','t13-3-4-120-160','t14-3-4-160-213','t15-3-4-187-249','t16-3-4-213-284','t17-3-4-284-379','t18-3-4-379-506'}%{'spontaneous-taps', 'soundstempo2-3-135-2025mp3', 'soundstempo3-4-1867-2489mp3', 'soundstempo3-4-2133-2844mp3', 'soundstempo2-3-3037-4556mp3', 'soundstempo2-3-120-180mp3', 'soundstempo3-4-506-675mp3', 'soundstempo3-4-675-90mp3', 'soundstempo2-3-1687-2531mp3', 'soundstempo2-3-60-90mp3', 'soundstempo2-3-40-60mp3', 'soundstempo2-3-90-135mp3', 'soundstempo3-4-120-160mp3', 'soundstempo3-4-2844-3792mp3', 'soundstempo3-4-90-120mp3', 'soundstempo3-4-3792-5057mp3', 'soundstempo2-3-2025-3037mp3', 'soundstempo3-4-38-506mp3', 'soundstempo3-4-160-2133mp3'}


Total_cycleBPM=[1    45    45    45    45    45    45    30    30    30    30    30    30 45 45 45 30 30 30];%[1 30 45 30 45 45 45 30 30 45 30 30 45]; %watch out the timing of spontaneous tapping (1st datapoint)
Total_cycle=60000./Total_cycleBPM; 
Total_cycle_slowBPM=[ 1    90    90    90    90    90    90    90    90    90    90    90    90 90 90 90 90 90 90];%[1 90 90 90 90 90 90 90 90 90 90 90 90];
Total_cycle_slow=60000./Total_cycle_slowBPM;
Total_cycle_fastBPM= [1   135   135   135   135   135   135   120   120   120   120   120   120 135 135 135 120 120 120];%[1 120 135 120 135 135 135 120 120 135 120 120 135];
Total_cycle_fast=60000./Total_cycle_fastBPM;
Total_cycle_allSub=[ 1   270   270   270   270   270   270   360   360   360   360   360   360 270 270 270 360 360 360];%[1 360 270 360 270 270 270 360 360 270 360 360 270];% 
Total_cycle_allSub=60000./Total_cycle_allSub;


Total_cycle_slow_half=Total_cycle_slow*2;
Total_cycle_fast_half=Total_cycle_fast*2;
Total_cycle_slow_double=Total_cycle_slow/2;
Total_cycle_fast_double=Total_cycle_fast/2;
%% HERE TO CHECK AllSub (as EXAMPLE applicable to all other meters - copy-paste changing the "total_cycle_XXX" and its related number of categorization)

Total_cycles=[Total_cycle; Total_cycle_slow_half; Total_cycle_slow; Total_cycle_slow_double; Total_cycle_fast_half; Total_cycle_fast; Total_cycle_fast_double; Total_cycle_allSub];
cat_numbers=[ 30 13 12 11 23 22 21 40 ];%catnames = { 'Cycle','SlowHalf', 'Slow','SlowDouble', 'FastHalf','Fast' ,'FastDouble', 'allSub'};
newChosenMeter=ChosenMeter; %substituting the old choice, to compare changes with ChosenMeter
for MET=1:size(Total_cycles,1)
MeterTimings=[];%tapping_dataITI_mean, tapping_dataITI_SD, ChosenMeter, Total_cycle_allSub
for iii=1:size(ChosenMeter,1)
MeterTimings=[MeterTimings;Total_cycles(MET,:)]; %<--CHANGE HERE THE NAME (fast, slow) to put the "EXPECTED" ITI
end

[posX]=find( ChosenMeter==cat_numbers(MET)); %<--CHANGE HERE THE NUMBER OF CATEGORIZATION
seeChanges=zeros(size(ChosenMeter)); %easy to detect among zeros


for iii=1:length(posX) 
    X=posX(iii);
    
    %play below to modify ITI range or SD proportion to improve categorization
if tapping_dataITI_mean(X)<(MeterTimings(X)+(0.15*MeterTimings(X))) && tapping_dataITI_mean(X)>(MeterTimings(X)-(0.15*MeterTimings(X))) && tapping_dataITI_SD(X)<(0.66*MeterTimings(X))
    %seeChanges(X)=cat_numbers(MET); %define here the new category number if condition is "approved"
    newChosenMeter(X)=cat_numbers(MET);
    
else
     newChosenMeter(X)=77;  %<--define here the new category number if condition is "approved"
end  
end
end

%%  get the NEW re-categorized choice and plot the categories on the ITIs and make new PIES

%x=ChosenMeter;
x = categorical(newChosenMeter);%categorical(table2array(readtable('myData_TEMPO.xlsx','Range','PE2:PW104', 'ReadVariableNames',false)))%x(isnan(x)==1)=7;
valueset = categorical([99 77 88 30 13 12 11 23 22 21 40]); catnames = {'NaN','Rhythmicity', 'NoMeter','Cycle','SlowHalf', 'Slow','SlowDouble', 'FastHalf','Fast' ,'FastDouble', 'AllSub'};%{'NoMeter','Cycle','Slow', 'Fast', 'slowSub','weird', 'FastSub','NaN'};
A = categorical(x,valueset,catnames);

%% PLOT ALL PARTICIPANTS IN PIE
labels = {'.','.','.','c', '.', 'Slow', '.', '.','Fast','.','.'};%{'No','C','Slow', 'Fast', 'S2','w', 'F2','NaN'};
explode = {'Slow','Fast'};

%p13, p14, p15, p04,p 01, empty, p05, p06, p02, p03, p16, p17, p18, p10, p07, legends, p11, p12, p08, p09
NICEorder=[5 9 10 4 7 8 15 19 20 14 17 18 1 2 3 11 12 13];
A2=A; A2(:,1)=[]; Title2=Title(2:19);
figure('units','normalized','outerposition',[0 0 1 1])
for tr=1:(size(x,2)-1)
    if size(x,2)<21 && size(x,2)>16
        subplot(4,5,NICEorder(tr))
    elseif size(x,2)<16
        subplot(3,5,tr)
    else
    subplot(4,6,tr)
    end
p = pie(A2(:,tr),explode, labels)

t=title(Title2(tr))
titlePos = get( t , 'position'); titlePos(2) = 1.4;
set( t , 'position' , titlePos);
end
l=legend(catnames); legPos = get( l, 'position'); legPos = [0.2 0.15 0 0]; set( l , 'position' , legPos);

Filename=['PITCH_PieN_reCAT']%[File_name num2str(p)];
print(Filename,'-dpng')%close all%

%% NEW cat on ITIs plots for each subject
load('tapping_data.mat');
DataPilot=tapping_data; File_names={'PITCH_'; 'TEMPO_'; 'RATIO_'}; File_name=File_names{1};
Data_CleanTaps_cat(DataPilot, File_name, Title, Total_cycle_slow, Total_cycle_fast, Total_cycle, tapping_data, A)

%% SAVE

% NEWtable=readtable('myData_TEMPO.xlsx', 'ReadVariableNames',true, 'PreserveVariableNames', true);
% NEWtable(:,[421:439])=array2table(newChosenMeter);

clear('ColumnNames')
for i=1
for ii=1:length(Title)
    ColumnNames{(((i-1)*length(Title)+ii))}=['reCAT_ChosenMeter' Title{ii}];
end
end
T_musbeat_pilot_reCAT = array2table(newChosenMeter,'VariableNames',ColumnNames);
writetable(T_musbeat_pilot_reCAT,'musbeat_pilot_reCAT.csv','Delimiter',',','QuoteStrings',true) %type 'myData.csv'
writetable(T_musbeat_pilot_reCAT,'musbeat_pilot_reCAT.csv') %type 'myData.csv'


%% load('T_musbeat_pilot.mat')
T_musbeat_pilot_final=[T_musbeat_pilot T_musbeat_pilot_reCAT];
writetable(T_musbeat_pilot_final,'musbeat_pilot_final.csv','Delimiter',',','QuoteStrings',true) %type 'myData.csv'
writetable(T_musbeat_pilot_final,'musbeat_pilot_final.csv') %type 'myData.csv'