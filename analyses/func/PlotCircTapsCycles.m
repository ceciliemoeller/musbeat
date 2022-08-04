%%%%%%%%%%PLOT CIRCULAR TAPS CYCLE 

function [alpha_rad_wt25SD, Tapping_SD_RAOspacingTest ] = PlotCircTapsCycles(tapping_TAPS_without25SD, Total_cycle, tapping_dataITI_mean, Title, File_name)
tempo=[repmat(Total_cycle,size(tapping_TAPS_without25SD,1),1)];%800;
tempo(:,1)=tapping_dataITI_mean(:,1);
Tapping_SD_RAOspacingTest=nan(size(tapping_TAPS_without25SD));

Asynchrony_Values_wt25SD={};
% Asynchrony_Values_DoubTap={};

for p=1:size(tapping_TAPS_without25SD,1)
    for tr=1:size(tapping_TAPS_without25SD,2)
    
        if tapping_TAPS_without25SD{p,tr}==0
            tapping_TAPS_without25SD{p,tr}=[]; %to avoid modulus at 0 degrees
        end
        
        Asynchrony_Values_wt25SD=mod((tapping_TAPS_without25SD{p,tr}), tempo(p,tr));
%         Asynchrony_Values_DoubTap=mod((tapping_allTAPS_withoutDoubleTaps{p,tr}), tempo(p,tr));
    
    

    Angles_Asynchrony_Values_wt25SD=[];
    for val=1:length(Asynchrony_Values_wt25SD)
        angle_wt25SD=Asynchrony_Values_wt25SD(val)/(tempo(p,tr)/2)*180;
        Angles_Asynchrony_Values_wt25SD(val)=angle_wt25SD;
    end
    alpha_rad_wt25SD{p,tr} = circ_ang2rad(Angles_Asynchrony_Values_wt25SD');
            if isempty(alpha_rad_wt25SD{p,tr})==0
            Tapping_SD_RAOspacingTest(p,tr)=circ_raotest(alpha_rad_wt25SD{p,tr});
            end
%     Angles_Asynchrony_Values_DoubTap=[];
%     for val=1:length(Asynchrony_Values_DoubTap)
%         angle_DoubTap=Asynchrony_Values_DoubTap(val)/(tempo(p,tr)/2)*180;
%         Angles_Asynchrony_Values_DoubTap(val)=angle_DoubTap;
%         
%     end
%     alpha_rad_DoubTap{p,tr} = circ_ang2rad(Angles_Asynchrony_Values_DoubTap');
%     
    
    end
    
    figure('units','normalized','outerposition',[0 0 1 1])
    for tr=1:size(tapping_TAPS_without25SD,2)
    
    if size(tapping_TAPS_without25SD,2)<21 && size(tapping_TAPS_without25SD,2)>16
        subplot(4,5,tr)
    elseif size(tapping_TAPS_without25SD,2)<16
        subplot(3,5,tr)
    else
    subplot(4,6,tr)
    end
    
    if isempty(alpha_rad_wt25SD{p,tr})==0
    circ_plot(alpha_rad_wt25SD{p,tr},'pretty','bo',true,'linewidth',2,'color','r');
    end
    title([Title(tr) 'Rao p= ' num2str(Tapping_SD_RAOspacingTest(p,tr)) ' '])    
    end
    
    Filename=[File_name num2str(p) '_CycleAsynch'];
    print(Filename,'-dpng') %% close all
    
%     figure('units','normalized','outerposition',[0 0 1 1])
%     for tr=1:8
%            subplot(2,4,tr)
%            if isempty(alpha_rad_wt25SD{p,tr})==0
%     circ_plot(alpha_rad_DoubTap{p,tr},'pretty','bo',true,'linewidth',2,'color','r');
%            end
%     title(PitchTitle(tr))  
%     end
%     Filename=['Pilot' num2str(p) '_Asynch_all_noDoubTap'];
     close all%print(Filename,'-dpng')%
    
end









