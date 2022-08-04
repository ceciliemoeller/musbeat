%%%%%%%%%%%%%%% MAY-JUNE 2020 - Celma-Miralles, A. - POLYRHYTHM SUBDIVISION PROJECT: PITCH (w STUPACHER, J & MøLLER, C)

clear all

% cd 'C:\Users\au631438\Documents\WriteEEGtap_infoFiles\EEG_trials_taps'
addpath 'C:\Users\au631438\Documents\WriteEEGtap_infoFiles\EEG_trials_taps\CircStat2012a'
addpath 'C:\Users\au631438\Documents\PolyRhythm\DATA\FINAL'
cd 'C:\Users\au631438\Documents\PolyRhythm\DATA\Expe2020\PITCH'


%% Setup the Import Options and import the data
%opts = delimitedTextImportOptions("NumVariables", 79);
opts = delimitedTextImportOptions("NumVariables", 41);

% Specify range and delimiter
opts.DataLines = [2, 81];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["VarName1", "part", "id", "complete", "currentTime", "startTime", "device", "browser", "headphones", "age", "gender", "residence", "youth_country", "language", "ollen", "MT_06", "instrument", "years_instr", "duplets", "comments", "experiment", "spontaneous_taps", "soundspitchp06_2C501_3C313mp3", "soundspitchp16_3C407_4C407mp3", "soundspitchp05_2C504_3C310mp3", "soundspitchp18_3C413_4C401mp3", "soundspitchp17_3C410_4C404mp3", "soundspitchp09_3C313_4C501mp3", "soundspitchp07_3C307_4C507mp3", "soundspitchp13_2C407_3C407mp3", "soundspitchp02_2C304_3C510mp3", "soundspitchp14_2C404_3C410mp3", "soundspitchp04_2C507_3C307mp3", "soundspitchp11_3C510_4C304mp3", "soundspitchp10_3C507_4C307mp3", "soundspitchp12_3C513_4C301mp3", "soundspitchp08_3C310_4C504mp3", "soundspitchp15_2C401_3C413mp3", "soundspitchp03_2C301_3C513mp3", "soundspitchp01_2C307_3C507mp3", "musicianship"];
opts.VariableTypes = ["double", "double", "string", "categorical", "datetime", "datetime", "categorical", "categorical", "categorical", "double", "categorical", "categorical", "categorical", "categorical", "categorical", "categorical", "categorical", "double", "categorical", "string", "categorical", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "categorical"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["id", "comments", "spontaneous_taps", "soundspitchp06_2C501_3C313mp3", "soundspitchp16_3C407_4C407mp3", "soundspitchp05_2C504_3C310mp3", "soundspitchp18_3C413_4C401mp3", "soundspitchp17_3C410_4C404mp3", "soundspitchp09_3C313_4C501mp3", "soundspitchp07_3C307_4C507mp3", "soundspitchp13_2C407_3C407mp3", "soundspitchp02_2C304_3C510mp3", "soundspitchp14_2C404_3C410mp3", "soundspitchp04_2C507_3C307mp3", "soundspitchp11_3C510_4C304mp3", "soundspitchp10_3C507_4C307mp3", "soundspitchp12_3C513_4C301mp3", "soundspitchp08_3C310_4C504mp3", "soundspitchp15_2C401_3C413mp3", "soundspitchp03_2C301_3C513mp3", "soundspitchp01_2C307_3C507mp3"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["id", "complete", "device", "browser", "headphones", "gender", "residence", "youth_country", "language", "ollen", "MT_06", "instrument", "duplets", "comments", "experiment", "spontaneous_taps", "soundspitchp06_2C501_3C313mp3", "soundspitchp16_3C407_4C407mp3", "soundspitchp05_2C504_3C310mp3", "soundspitchp18_3C413_4C401mp3", "soundspitchp17_3C410_4C404mp3", "soundspitchp09_3C313_4C501mp3", "soundspitchp07_3C307_4C507mp3", "soundspitchp13_2C407_3C407mp3", "soundspitchp02_2C304_3C510mp3", "soundspitchp14_2C404_3C410mp3", "soundspitchp04_2C507_3C307mp3", "soundspitchp11_3C510_4C304mp3", "soundspitchp10_3C507_4C307mp3", "soundspitchp12_3C513_4C301mp3", "soundspitchp08_3C310_4C504mp3", "soundspitchp15_2C401_3C413mp3", "soundspitchp03_2C301_3C513mp3", "soundspitchp01_2C307_3C507mp3", "musicianship"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, "currentTime", "InputFormat", "yyyy-MM-dd HH:mm:ss");
opts = setvaropts(opts, "startTime", "InputFormat", "yyyy-MM-dd HH:mm:ss");
opts = setvaropts(opts, "age", "TrimNonNumeric", true);
opts = setvaropts(opts, "age", "ThousandsSeparator", ",");

% Import the data
pitchtapsfinal = readtable("C:\Users\au631438\Documents\PolyRhythm\DATA\FINAL\pitchtaps_final.csv", opts);

% the data
pitchtaps1 = pitchtapsfinal;% readtable("C:\Users\au631438\Documents\PolyRhythm\DATA\FINAL\pitchtaps_final.csv", opts);

pitchtaps1_id=pitchtapsfinal.id;

% Clear temporary variables
clear opts

pitchtaps1_part=pitchtapsfinal.part;

%% PARAMETERS info
% T = readtable('pitchtaps.csv','TreatAsEmpty',{'.','NA'}); %opening for NA
% disp(T)

%REORDER THE TRIALS IN TABLE :
%VariableNames = ["spontaneous_taps", "soundspitch3C37_4C57mp3", "soundspitch2C54_3C310mp3", "soundspitch2C34_3C510mp3", "soundspitch3C513_4C31mp3", "soundspitch3C57_4C37mp3", "soundspitch3C510_4C34mp3", "soundspitch3C310_4C54mp3", "soundspitch2C37_3C57mp3", "soundspitch2C51_3C313mp3", "soundspitch3C313_4C51mp3", "soundspitch2C57_3C37mp3"];
% x={'pitchtaps1.soundspitchp06_2C501_3C313mp3', 'pitchtaps1.soundspitchp01_2C307_3C507mp3', 'pitchtaps1.soundspitchp11_3C510_4C304mp3', 'pitchtaps1.soundspitchp12_3C513_4C301mp3', 'pitchtaps1.soundspitchp07_3C307_4C507mp3', 'pitchtaps1.soundspitchp10_3C507_4C307mp3', 'pitchtaps1.soundspitchp09_3C313_4C501mp3', 'pitchtaps1.soundspitchp05_2C504_3C310mp3', 'pitchtaps1.soundspitchp03_2C301_3C513mp3', 'pitchtaps1.soundspitchp04_2C507_3C307mp3', 'pitchtaps1.soundspitchp08_3C310_4C504mp3', 'pitchtaps1.soundspitchp02_2C304_3C510mp3', 'pitchtaps1.soundspitchp15_2C401_3C413mp3', 'pitchtaps1.soundspitchp17_3C410_4C404mp3', 'pitchtaps1.soundspitchp16_3C407_4C407mp3', 'pitchtaps1.soundspitchp13_2C407_3C407mp3', 'pitchtaps1.soundspitchp18_3C413_4C401mp3', 'pitchtaps1.soundspitchp14_2C404_3C410mp3'}
% x=sort(x); 

%DataPilot=[pitchtaps1.spontaneous_taps, pitchtaps1.soundspitch3C510_4C34mp3, pitchtaps1.soundspitch2C37_3C57mp3, pitchtaps1.soundspitch3C310_4C54mp3, pitchtaps1.soundspitch2C31_3C513mp3, pitchtaps1.soundspitch2C51_3C313mp3, pitchtaps1.soundspitch2C54_3C310mp3, pitchtaps1.soundspitch3C37_4C57mp3, pitchtaps1.soundspitch3C57_4C37mp3, pitchtaps1.soundspitch2C34_3C510mp3, pitchtaps1.soundspitch3C513_4C31mp3, pitchtaps1.soundspitch3C313_4C51mp3, pitchtaps1.soundspitch2C57_3C37mp3];
DataPilot=[pitchtaps1.spontaneous_taps,pitchtaps1.soundspitchp01_2C307_3C507mp3,pitchtaps1.soundspitchp02_2C304_3C510mp3,pitchtaps1.soundspitchp03_2C301_3C513mp3,pitchtaps1.soundspitchp04_2C507_3C307mp3,pitchtaps1.soundspitchp05_2C504_3C310mp3,pitchtaps1.soundspitchp06_2C501_3C313mp3,pitchtaps1.soundspitchp07_3C307_4C507mp3,pitchtaps1.soundspitchp08_3C310_4C504mp3,pitchtaps1.soundspitchp09_3C313_4C501mp3,pitchtaps1.soundspitchp10_3C507_4C307mp3,pitchtaps1.soundspitchp11_3C510_4C304mp3,pitchtaps1.soundspitchp12_3C513_4C301mp3,pitchtaps1.soundspitchp13_2C407_3C407mp3,pitchtaps1.soundspitchp14_2C404_3C410mp3,pitchtaps1.soundspitchp15_2C401_3C413mp3,pitchtaps1.soundspitchp16_3C407_4C407mp3,pitchtaps1.soundspitchp17_3C410_4C404mp3,pitchtaps1.soundspitchp18_3C413_4C401mp3];
% DataPilot=table2array(pitchtaps);

TrialsName={'spontaneous-taps', 'p01-2C307-3C507','p02-2C304-3C510','p03-2C301-3C513','p04-2C507-3C307','p05-2C504-3C310','p06-2C501-3C313','p07-3C307-4C507','p08-3C310-4C504','p09-3C313-4C501','p10-3C507-4C307','p11-3C510-4C304','p12-3C513-4C301','p13-2C407-3C407','p14-2C404-3C410','p15-2C401-3C413','p16-3C407-4C407','p17-3C410-4C404','p18-3C413-4C401'}
Title=TrialsName;
%TrialsName={'spontaneous_taps', 'soundspitch3C510_4C34mp3', 'soundspitch2C37_3C57mp3', 'soundspitch3C310_4C54mp3', 'soundspitch2C31_3C513mp3', 'soundspitch2C51_3C313mp3', 'soundspitch2C54_3C310mp3', 'soundspitch3C37_4C57mp3', 'soundspitch3C57_4C37mp3', 'soundspitch2C34_3C510mp3', 'soundspitch3C513_4C31mp3', 'soundspitch3C313_4C51mp3', 'soundspitch2C57_3C37mp3'};
%Title={'spontaneous', 'R-125ms-4-5', 'ratioratio_subdiv_250ms_2_3mp3', 'ratioratio_subdiv_125ms_3_4mp3', 'ratioratio_subdiv_84ms_5_6mp3', 'ratioratio_subdiv_63ms_3_5mp3', 'ratioratio_subdiv_63ms_5_6mp3', 'ratioratio_subdiv_167ms_5_6mp3', 'ratioratio_subdiv_125ms_5_6mp3', 'ratioratio_subdiv_333ms_2_5mp3', 'ratioratio_subdiv_125ms_2_3mp3', 'ratioratio_subdiv_333ms_2_3mp3', 'ratioratio_subdiv_167ms_3_4mp3', 'ratioratio_subdiv_167ms_2_5mp3', 'ratioratio_subdiv_167ms_4_5mp3', 'ratioratio_subdiv_84ms_3_5mp3', 'ratioratio_subdiv_167ms_2_3mp3', 'ratioratio_subdiv_63ms_4_5mp3', 'ratioratio_subdiv_250ms_2_5mp3', 'ratioratio_subdiv_125ms_2_5mp3', 'ratioratio_subdiv_167ms_3_5mp3', 'ratioratio_subdiv_84ms_4_5mp3', 'ratioratio_subdiv_125ms_3_5mp3'};
%Title={'spontaneous','P-2:3-c7-C7','P-2:3-c4-C10','P-2:3-c1-C13','P-2:3-C7-c7','P-2:3-C4-c10','P-2:3-C1-c13','P-3:4-c7-C7','P-3:4-c10-C4','P-3:4-c13-C1','P-3:4-C7-c7','P-3:4-C10-c4','P-3:4-C13-c1','p13-2C407-3C407','p14-2C404-3C410','p15-2C401-3C413','p16-3C407-4C407','p17-3C410-4C404','p18-3C413-4C401'};%{'spontaneous', 'P-3:4-C10-c4', 'P-2:3-c7-C7', 'P-3:4-c10-C4', 'P-2:3-c1-C13', 'P-2:3-C1-c13', 'P-2:3-C4-c10', 'P-3:4-c7-C7', 'P-3:4-C7-c7', 'P-2:3-c4-C10', 'P-3:4-C13-c1', 'P-3:4-c13-C1', 'P-2:3-C7-c7'};
File_names={'PITCH_'; 'TEMPO_'; 'RATIO_'}; File_name=File_names{1};


Total_cycleBPM=[1    45    45    45    45    45    45    30    30    30    30    30    30 45 45 45 30 30 30];%[1 30 45 30 45 45 45 30 30 45 30 30 45]; %watch out the timing of spontaneous tapping (1st datapoint)
Total_cycle=60000./Total_cycleBPM; 
Total_cycle_slowBPM=[ 1    90    90    90    90    90    90    90    90    90    90    90    90 90 90 90 90 90 90];%[1 90 90 90 90 90 90 90 90 90 90 90 90];
Total_cycle_slow=60000./Total_cycle_slowBPM;
Total_cycle_fastBPM= [1   135   135   135   135   135   135   120   120   120   120   120   120 135 135 135 120 120 120];%[1 120 135 120 135 135 135 120 120 135 120 120 135];
Total_cycle_fast=60000./Total_cycle_fastBPM;
Total_cycle_allSub=[ 1   270   270   270   270   270   270   360   360   360   360   360   360 270 270 270 360 360 360];%[1 360 270 360 270 270 270 360 360 270 360 360 270];% 
Total_cycle_allSub=60000./Total_cycle_allSub;

%FINAL_order= [1 3 10 5 13 7 6 8 4 12 9 2 11];%for subplot should be [1 12 2 9 4 7 6 8 11 3 13 10 5];

%% DATA FILTERING: Doubletap, SD, ITIs...

[tapping_data tapping_dataITI_mean tapping_dataITI_SD tapping_1stTime tapping_NumbTaps tapping_DoubleTaps150ms tapping_OutlierITIs25SD tapping_TAPS_without25SD tapping_allTAPS_withoutDoubleTaps] = Data_CleanTaps(DataPilot, File_name, Title, Total_cycle_slow, Total_cycle_fast, Total_cycle)

NUMBERofEXCLUSIONS=length(find(tapping_OutlierITIs25SD==-1)) %%to count exclusions by SD and %
%% COMPUTE AND PLOT: CYCLES BEFORE TAPPING

%{ 'spontaneous_tap_15smp3', 'ratio_subdiv_63ms4_5mp3', 'ratio_subdiv_250ms2_5mp3', 'ratio_subdiv_250ms2_5mp31', 'ratio_subdiv_84ms4_5mp3', 'ratio_subdiv_167ms3_4mp3', 'ratio_subdiv_167ms5_6mp3', 'ratio_subdiv_167ms4_5mp3', 'ratio_subdiv_63ms3_5mp3', 'ratio_subdiv_63ms5_6mp3', 'ratio_subdiv_250ms2_3mp3', 'ratio_subdiv_84ms5_6mp3', 'ratio_subdiv_125ms3_5mp3', 'ratio_subdiv_125ms5_6mp3',
%'ratio_subdiv_125ms3_4mp3', 'ratio_subdiv_167ms2_5mp3', 'ratio_subdiv_167ms2_3mp3', 'ratio_subdiv_125ms4_5mp3', 'ratio_subdiv_167ms3_5mp3', 'ratio_subdiv_125ms2_5mp3', 'ratio_subdiv_125ms2_3mp3', 'ratio_subdiv_84ms3_5mp3', 'ratio_subdiv_250ms2_3mp31'};


[CyclesTime]=PlotCircPreTapCycles(tapping_1stTime,Total_cycle, Title,File_name);

% Table_CyclesTime=ratiotaps;
% Table_CyclesTime(:,11:18) = array2table(CyclesTime);
% writetable(Table_CyclesTime,'Table_CyclesTime.csv')

%% PLOT CIRCULAR STATISTICS: all cycle or dividing meters

%1 Taps around the full cycle %2 Are taps randomly-distributed?
[alpha_rad_wt25SD, Tapping_SD_RAOspacingTest] = PlotCircTapsCycles(tapping_TAPS_without25SD, Total_cycle, tapping_dataITI_mean, Title, File_name);



%% Plot fitting the meters

%{ 'spontaneous_tap_15smp3', 'ratio_subdiv_63ms4_5mp3', 'ratio_subdiv_250ms2_5mp3', 'ratio_subdiv_250ms2_5mp31', 'ratio_subdiv_84ms4_5mp3', 'ratio_subdiv_167ms3_4mp3', 'ratio_subdiv_167ms5_6mp3', 'ratio_subdiv_167ms4_5mp3', 'ratio_subdiv_63ms3_5mp3', 'ratio_subdiv_63ms5_6mp3', 'ratio_subdiv_250ms2_3mp3', 'ratio_subdiv_84ms5_6mp3', 'ratio_subdiv_125ms3_5mp3', 'ratio_subdiv_125ms5_6mp3',
%'ratio_subdiv_125ms3_4mp3', 'ratio_subdiv_167ms2_5mp3', 'ratio_subdiv_167ms2_3mp3', 'ratio_subdiv_125ms4_5mp3', 'ratio_subdiv_167ms3_5mp3', 'ratio_subdiv_125ms2_5mp3', 'ratio_subdiv_125ms2_3mp3', 'ratio_subdiv_84ms3_5mp3', 'ratio_subdiv_250ms2_3mp31'};



[R_alpha_slow, p_alpha_slow, R_alpha_fast, p_alpha_fast, R_alpha_cycle, p_alpha_cycle, R_alpha_slow_half, p_alpha_slow_half, R_alpha_fast_half, p_alpha_fast_half, R_alpha_slow_double, p_alpha_slow_double, R_alpha_fast_double, p_alpha_fast_double, R_alpha_allSub, p_alpha_allSub, ChosenMeter, weirdness] = PlotCircTapsMeters(tapping_TAPS_without25SD, Total_cycle, Total_cycle_slow, Total_cycle_fast, tapping_dataITI_mean, Title, File_name, Total_cycle_allSub);


%table about chosen meter %0 no-one, 1 slow, 2 fast, 3 cycle, 4 both, 5 weird-mix

%% PUTTING ALL DATA together

DataID=pitchtaps1_id;
%Number=pitchtaps1_part;%1:size(pitchtaps1_id,1); %DataID=table2array(pitchtaps_id);
Part=pitchtaps1_part;
AllCircDATA=[Part DataID, tapping_dataITI_mean, tapping_dataITI_SD, tapping_NumbTaps,tapping_DoubleTaps150ms,tapping_OutlierITIs25SD, CyclesTime, R_alpha_slow, p_alpha_slow, R_alpha_fast, p_alpha_fast, R_alpha_cycle, p_alpha_cycle, R_alpha_slow_half, p_alpha_slow_half, R_alpha_fast_half, p_alpha_fast_half,R_alpha_slow_double, p_alpha_slow_double, R_alpha_fast_double, p_alpha_fast_double, R_alpha_allSub, p_alpha_allSub, ChosenMeter,  Tapping_SD_RAOspacingTest, weirdness,  sum(weirdness,2)];

INFO={'ITI_','sdITI_','TOTALTapNumb_','DoubleTaps150ms_', 'OutlierITIs25SD_', 'CyclesPreTap_','SlowConsistency_','pSCons_','FastConsistency_','pFCons_','CycleConsistency_','pCCons','SlowHalfConsistency_','pSHalfCons_','FastHalfConsistency_','pFHalfCons_','SlowDoubConsistency_','pSDoubCons_','FastDoubConsistency_','pFDoubCons_', 'AllSub_', 'pAllSub_','old_ChosenMeter_', 'RAOtest_','weird_'};
ColumnNames={};
for i=1:length(INFO)
    for ii=1:length(TrialsName)
    ColumnNames{(((i-1)*length(TrialsName)+ii))}=[INFO{i} TrialsName{ii}];
    end
end

ColumnNames=['Part' 'iD' ColumnNames, 'weirdNumb'];
T_PITCH = array2table(AllCircDATA,'VariableNames',ColumnNames);

save('T_PITCH.mat', 'T_PITCH'); save('AllCircDATA.mat','AllCircDATA');
writetable(T_PITCH,'myData_PITCH.csv','Delimiter',',','QuoteStrings',true) %type 'myData.csv'
writetable(T_PITCH,'myData_PITCH.xlsx') %type 'myData.csv'

%% PLOT ALL PARTICIPANTS IN PIE
% x=categorical(ChosenMeter);
Title2=Title;%{'spontaneous','P-2:3-c7-C7','P-2:3-c4-C10','P-2:3-c1-C13','P-2:3-C7-c7','P-2:3-C4-c10','P-2:3-C1-c13','P-3:4-c7-C7','P-3:4-c10-C4','P-3:4-c13-C1','P-3:4-C7-c7','P-3:4-C10-c4','P-3:4-C13-c1'}
x = categorical(table2array(readtable('myData_PITCH.xlsx','Range','PE2:PW81', 'ReadVariableNames',false)))%x(isnan(x)==1)=7;
valueset = categorical([99 88 50 30 13 12 11 23 22 21 40]); catnames = {'NaN','NoMeter','weird', 'Cycle','SlowHalf', 'Slow','SlowDouble',  'FastHalf','Fast' ,'FastDouble', 'allSub'};%{'NoMeter','Cycle','Slow', 'Fast', 'slowSub','weird', 'FastSub','NaN'};
A = categorical(x,valueset,catnames);
labels = {'.','.', '.','c', '.', 'Slow', '.','.','Fast','.','.'};%{'No','C','Slow', 'Fast', 'S2','w', 'F2','NaN'};
explode = {'Slow','Fast'};
figure('units','normalized','outerposition',[0 0 1 1])
for tr=1:size(x,2)
    if size(x,2)<21 && size(x,2)>16
        subplot(4,5,tr)
    elseif size(x,2)<16
        subplot(3,5,tr)
    else
    subplot(4,6,tr)
    end
p = pie(A(:,tr),explode, labels)

t=title(Title2(tr))
titlePos = get( t , 'position'); titlePos(2) = 1.4;
set( t , 'position' , titlePos);
end
l=legend(catnames); legPos = get( l, 'position'); legPos = [0.85 0.19 0 0]; set( l , 'position' , legPos);

Filename=['Pitch_PieN']%[File_name num2str(p)];
print(Filename,'-dpng')%close all%