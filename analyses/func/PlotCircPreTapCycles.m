
function [CyclesTime] = PlotCircPreTapCycles(tapping_1stTime, Total_cycle,Title,File_name)

CyclesTime=[];
figure('units','normalized','outerposition',[0 0 1 1])
for i= 1:size(tapping_1stTime,2)

    CyclesTime(:,i) = (tapping_1stTime(:,i)./Total_cycle(i));%floor(tapping_1stTime(:,i)./Total_cycle(i));
 
    if size(tapping_1stTime,2)<21 && size(tapping_1stTime,2)>16
        subplot(4,5,i)
    elseif size(tapping_1stTime,2)<16
        subplot(3,5,i)
    else
    subplot(4,6,i)
    end
    
    plot(CyclesTime(:,i), 'bo'); hold on; xlim([0 (size(tapping_1stTime,1)+1)]); ylim([0 8]); grid on
    %line([0 0; 22 22], [60/0.150 60/0.090; 60/0.150 60/0.090  ],'Color','red','LineStyle','--')
    title(Title(i))
        
end
print([File_name 'NumberOfCycles_preTAP'],'-dpng')