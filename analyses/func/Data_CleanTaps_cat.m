%% function DATA_FILTERING_Doubletaps_SD_ITIs(Data)

function []=DATA_CleanTaps(Data, File_name, Title, Total_cycle_slow, Total_cycle_fast, Total_cycle, tapping_data, A)

% tapping_data={};
% tapping_dataITI_mean=[];
% tapping_dataITI_SD=[];
% tapping_1stTime=[];
% tapping_NumbTaps=[];   
% tapping_DoubleTaps150ms=[];
% tapping_OutlierITIs25SD=[];
% tapping_TAPS_without25SD={};
% tapping_allTAPS_withoutDoubleTaps={};
% Total_cycle_slow(1)=NaN ;
% Total_cycle_fast(1)=NaN;
% Total_cycle(1)=NaN;%typical spontaneous tapping

for p=1:size(Data,1)
    

%     tapping1_data=[];
%     tapping1_dataITI_mean=[];
%     tapping1_dataITI_SD=[];
%     tapping1_1stTime=[];
%     tapping1_NumbTaps=[];   
%     tapping1_DoubleTaps150ms=[];
%     tapping1_OutlierITIs25SD=[];
    
    
    figure('units','normalized','outerposition',[0 0 1 1])
    for tr=1:size(Data,2)
%         TAPS=str2num(Data(p, tr));
% %         if isempty(TAPS)==1 %SIGNALING no-taps with negative ITI
% %             TAPS=[0 -1];
% %         else
% %             TAPS([1])=[];
% %         end
%         TapDif=diff(TAPS);
%         
%         %clean doubletaps <150ms
%         if isempty(find(TapDif<150))==1
%             tapping1_DoubleTaps150ms=[tapping1_DoubleTaps150ms, 0];
%         elseif isempty(find(TapDif<150))==0 %&& mean(TapDif(find(TapDif<150)))>0 %%%%%%%%%%%%%%%%%%%That was to remove any induced "negative" ITI signanling no-taps (line 33)
%             doubletaps=find(TapDif<150);
%             tapping1_DoubleTaps150ms=[tapping1_DoubleTaps150ms,length(doubletaps)];%/length(TapDif)*100;%for pecrcentages
%             TAPS(doubletaps+1)=[];%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%HERE: 2nd taps of double-taps are removed 
% %             TapDif=diff(TAPS);
%         else
%             tapping1_DoubleTaps150ms=[tapping1_DoubleTaps150ms, 0];
%         end
%         tapping_allTAPS_withoutDoubleTaps{p,tr}=TAPS;
%         
%         %%%%2 excluding trials with less than 7 taps 
%         %%%%3 Removing first 2 taps (and filling dummy "0" for empty trials) 
%         if isempty(TAPS)==1 || length(TAPS)<7
%             TAPS=[0];%TAPS=[0 -1];
%             tapping1_1stTime=[tapping1_1stTime, TAPS(1)];
%             TapDif=diff(TAPS);
%         else
%             tapping1_1stTime=[tapping1_1stTime, TAPS(1)];
%             TAPS([1 2])=[];
%             TapDif=diff(TAPS);
%             
%         end
%         tapping_TAPS_without25SD{p,tr}=TAPS; %used info for CIRCULAR: it tells how many taps are before removing 2.5SD, and after removing the first 2 taps and the doubletaps
% 
%         
%         M=mean(TapDif); SD=std(TapDif); %%TO REMOVE OUTLIERS beyond 3SD% (<25% taps)
%         %clean ITIs > 2.5SD (or 3 or 3.5 or 4)
%         if isempty(find(TapDif>M+2*SD))==0 || isempty(find(TapDif<M-2*SD))==0
%             outlierITIs=[find(TapDif>M+2*SD) find(TapDif<M-2*SD)];
%             
% %             if length(outlierITIs)>0.075*length(TAPS) %more than 25% than taps: we do not exclude trials (03/07/2020) 
% %             TapDif=[];%%%%%%EMPTY TO MARK AS EXCLUDED
% %             tapping1_OutlierITIs25SD=[tapping1_OutlierITIs25SD, -1];
% %             tapping_TAPS_without25SD{p,tr}=NaN; %HERE THE DATA FOR CIRCULAR: when 25% taps fall beyond 2.5SD the trial is excluded
% %  
% %             else
%             TapDif(outlierITIs)=[];%TAPS(outlierTAPS+1)=[];%%%%%%%%%%%%%%%%%%%%%%%%%%%HERE it removes the ITIs that fall beyond 2SD
%             tapping1_OutlierITIs25SD=[tapping1_OutlierITIs25SD, length(outlierITIs)]; 
% %             end
%             
%         else
%             tapping1_OutlierITIs25SD=[tapping1_OutlierITIs25SD, 0];
%         end
%         
%         tapping1_dataITI_mean=[tapping1_dataITI_mean, mean(TapDif)]; %%%%%%%%%%%%%%%%%%%%%%%%%%%%the mean of the ITI does not include outliers
%         tapping1_dataITI_SD=[tapping1_dataITI_SD, std(TapDif)];
%         tapping1_data=[tapping1_data, TapDif];
%         TAPS=str2num(Data(p, tr));
%         tapping1_NumbTaps=[tapping1_NumbTaps, length(TAPS)];
%         
%         tapping_data{p,tr}={tapping1_data};
        
        
    %NEW
    TapDif= tapping_data{p,tr};
    
        %PLOTTING each Participant ITI mean and 2.5 SD (pink)
    
    if size(Data,2)<21 && size(Data,2)>16
        subplot(4,5,tr)
    elseif size(Data,2)<16
        subplot(3,5,tr)
    else
    subplot(4,6,tr)
    end   
    plot(TapDif); hold on;
    axis([ 0 1+length(TapDif) 0 2250]);%axis([ 0 length(TapDif) -500 5000]);
    plot(xlim, [mean(TapDif) mean(TapDif)], '-r')
    plot(xlim, [mean(TapDif)+1*std(TapDif) mean(TapDif)+1*std(TapDif)], ':m')%plot(xlim, [mean(TapDif)+2.5*std(TapDif) mean(TapDif)+2.5*std(TapDif)], ':m')
    plot(xlim, [mean(TapDif)-1*std(TapDif) mean(TapDif)-1*std(TapDif)], ':m')
    plot(xlim, [mean(TapDif)+2*std(TapDif) mean(TapDif)+2*std(TapDif)], ':b')%plot(xlim, [mean(TapDif)+2.5*std(TapDif) mean(TapDif)+2.5*std(TapDif)], ':m')
    plot(xlim, [mean(TapDif)-2*std(TapDif) mean(TapDif)-2*std(TapDif)], ':b')
    
    plot([length(TapDif)+0.5], [mean(Total_cycle_slow(tr)) mean(Total_cycle_slow(tr))], '>b')%bLue-sLow meter
    plot([length(TapDif)+0.5], [mean(Total_cycle_fast(tr)) mean(Total_cycle_fast(tr))], '>g')%green-fast meter
    plot([length(TapDif)+0.5], [mean(Total_cycle(tr)) mean(Total_cycle(tr))], '>y')%yellow-cycle meter
    title([Title(tr) [num2str(mean(TapDif),4) ' SD ' num2str(std(TapDif),4)] A(p,tr)])  
    end
    
    Filename=[File_name num2str(p) '_ITIs_mean_2-5SD_reCAT'];
    print(Filename,'-dpng')%close all%
%     
%     %tapping_data{p,1}={tapping1_data};
%     tapping_dataITI_mean=[tapping_dataITI_mean; tapping1_dataITI_mean];
%     tapping_dataITI_SD=[tapping_dataITI_SD; tapping1_dataITI_SD];
%     tapping_1stTime=[tapping_1stTime; tapping1_1stTime];
%     tapping_NumbTaps=[tapping_NumbTaps;tapping1_NumbTaps];   
%     tapping_DoubleTaps150ms=[tapping_DoubleTaps150ms; tapping1_DoubleTaps150ms];
%     tapping_OutlierITIs25SD=[tapping_OutlierITIs25SD; tapping1_OutlierITIs25SD];
    
    close all
end