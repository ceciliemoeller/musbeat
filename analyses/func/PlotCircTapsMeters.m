%%%%%%%%%%PLOT CIRCULAR TAPS CYCLE 

function [R_alpha_slow, p_alpha_slow, R_alpha_fast, p_alpha_fast, R_alpha_cycle, p_alpha_cycle, R_alpha_slow_half, p_alpha_slow_half, R_alpha_fast_half, p_alpha_fast_half,R_alpha_slow_double, p_alpha_slow_double, R_alpha_fast_double, p_alpha_fast_double, R_alpha_allSub, p_alpha_allSub, ChosenMeter, weirdness] = PlotCircTapsMeters(tapping_TAPS_without25SD, Total_cycle, Total_cycle_slow, Total_cycle_fast, tapping_dataITI_mean, Title, File_name, Total_cycle_allSub ) 
tempo_slow=[repmat(Total_cycle_slow,size(tapping_TAPS_without25SD,1),1)];
tempo_slow(:,1)=tapping_dataITI_mean(:,1);

tempo_fast=[repmat(Total_cycle_fast,size(tapping_TAPS_without25SD,1),1)];
tempo_fast(:,1)=tapping_dataITI_mean(:,1);

tempo_cycle=[repmat(Total_cycle,size(tapping_TAPS_without25SD,1),1)];
tempo_cycle(:,1)=tapping_dataITI_mean(:,1);

Total_cycle_slow_half=Total_cycle_slow*2;
tempo_slow_half=[repmat(Total_cycle_slow_half,size(tapping_TAPS_without25SD,1),1)];
tempo_slow_half(:,1)=tapping_dataITI_mean(:,1);

Total_cycle_fast_half=Total_cycle_fast*2;
tempo_fast_half=[repmat(Total_cycle_fast_half,size(tapping_TAPS_without25SD,1),1)];
tempo_fast_half(:,1)=tapping_dataITI_mean(:,1);

% Total_cycle_slow_third=Total_cycle_slow/3; %%TRIPLET SUBDIVISION
% tempo_slow_third=[repmat(Total_cycle_slow_third,size(tapping_TAPS_without25SD,1),1)];
% tempo_slow_third(:,1)=tapping_dataITI_mean(:,1);

Total_cycle_slow_double=Total_cycle_slow/2;
tempo_slow_double=[repmat(Total_cycle_slow_double,size(tapping_TAPS_without25SD,1),1)];
tempo_slow_double(:,1)=tapping_dataITI_mean(:,1);

Total_cycle_fast_double=Total_cycle_fast/2;
tempo_fast_double=[repmat(Total_cycle_fast_double,size(tapping_TAPS_without25SD,1),1)];
tempo_fast_double(:,1)=tapping_dataITI_mean(:,1);


tempo_allSub=[repmat(Total_cycle_allSub,size(tapping_TAPS_without25SD,1),1)];
tempo_allSub(:,1)=tapping_dataITI_mean(:,1);

R_alpha_slow=NaN(size(tapping_TAPS_without25SD));R_alpha_fast=NaN(size(tapping_TAPS_without25SD));R_alpha_cycle=NaN(size(tapping_TAPS_without25SD)); R_alpha_slow_half=NaN(size(tapping_TAPS_without25SD)); R_alpha_fast_half=NaN(size(tapping_TAPS_without25SD));R_alpha_slow_double=NaN(size(tapping_TAPS_without25SD)); R_alpha_fast_double=NaN(size(tapping_TAPS_without25SD));R_alpha_allSub=NaN(size(tapping_TAPS_without25SD));
p_alpha_slow=NaN(size(tapping_TAPS_without25SD));p_alpha_fast=NaN(size(tapping_TAPS_without25SD));p_alpha_cycle=NaN(size(tapping_TAPS_without25SD));p_alpha_slow_double=NaN(size(tapping_TAPS_without25SD));p_alpha_fast_double=NaN(size(tapping_TAPS_without25SD));p_alpha_slow_double=NaN(size(tapping_TAPS_without25SD));p_alpha_fast_double=NaN(size(tapping_TAPS_without25SD));p_alpha_allSub=NaN(size(tapping_TAPS_without25SD));

ChosenMeter=NaN(size(tapping_TAPS_without25SD)); %88 no-one, 1 slow, 2 fast, 3 cycle, 4 mix
weirdness=NaN(size(tapping_TAPS_without25SD));
% Asynchrony_Values_wt25SD={};

for p=1:size(tapping_TAPS_without25SD,1)
    
    figure('units','normalized','outerposition',[0 0 1 1])
    for tr=1:size(tapping_TAPS_without25SD,2)
    
        if tapping_TAPS_without25SD{p,tr}==0
           tapping_TAPS_without25SD{p,tr}=NaN; %to avoid modulus at 0 degrees
        elseif isempty(tapping_TAPS_without25SD{p,tr})==1
           tapping_TAPS_without25SD{p,tr}=NaN; %to avoid modulus at 0 degrees
        end
        
        Asynchrony_Values_wt25SD_slow=mod((tapping_TAPS_without25SD{p,tr}), tempo_slow(p,tr));
        Asynchrony_Values_wt25SD_fast=mod((tapping_TAPS_without25SD{p,tr}), tempo_fast(p,tr));
        Asynchrony_Values_wt25SD_cycle=mod((tapping_TAPS_without25SD{p,tr}), tempo_cycle(p,tr));    
        Asynchrony_Values_wt25SD_slow_half=mod((tapping_TAPS_without25SD{p,tr}), tempo_slow_half(p,tr));%%NEW subSubdivision
        Asynchrony_Values_wt25SD_fast_half=mod((tapping_TAPS_without25SD{p,tr}), tempo_fast_half(p,tr));%%NEW subSubdivision
        Asynchrony_Values_wt25SD_slow_double=mod((tapping_TAPS_without25SD{p,tr}), tempo_slow_double(p,tr));%%NEW subSubdivision
        Asynchrony_Values_wt25SD_fast_double=mod((tapping_TAPS_without25SD{p,tr}), tempo_fast_double(p,tr));%%NEW subSubdivision
        Asynchrony_Values_wt25SD_allSub=mod((tapping_TAPS_without25SD{p,tr}), tempo_allSub(p,tr));  
        
    Angles_Asynchrony_Values_wt25SD_slow=[];
    for val=1:length(Asynchrony_Values_wt25SD_slow)
        angle_wt25SD_slow=Asynchrony_Values_wt25SD_slow(val)/(tempo_slow(p,tr)/2)*180;
        Angles_Asynchrony_Values_wt25SD_slow(val)=angle_wt25SD_slow;
    end
    alpha_rad_wt25SD_slow{p,tr} = circ_ang2rad(Angles_Asynchrony_Values_wt25SD_slow');
    
    Angles_Asynchrony_Values_wt25SD_fast=[];
    for val=1:length(Asynchrony_Values_wt25SD_fast)
        angle_wt25SD_fast=Asynchrony_Values_wt25SD_fast(val)/(tempo_fast(p,tr)/2)*180;
        Angles_Asynchrony_Values_wt25SD_fast(val)=angle_wt25SD_fast;
    end
    alpha_rad_wt25SD_fast{p,tr} = circ_ang2rad(Angles_Asynchrony_Values_wt25SD_fast');
    
    Angles_Asynchrony_Values_wt25SD_cycle=[];
    for val=1:length(Asynchrony_Values_wt25SD_cycle)
        angle_wt25SD_cycle=Asynchrony_Values_wt25SD_cycle(val)/(tempo_cycle(p,tr)/2)*180;
        Angles_Asynchrony_Values_wt25SD_cycle(val)=angle_wt25SD_cycle;
    end
    alpha_rad_wt25SD_cycle{p,tr} = circ_ang2rad(Angles_Asynchrony_Values_wt25SD_cycle');
    
    
    Angles_Asynchrony_Values_wt25SD_slow_half=[];
    for val=1:length(Asynchrony_Values_wt25SD_slow_half)
        angle_wt25SD_slow_half=Asynchrony_Values_wt25SD_slow_half(val)/(tempo_slow_half(p,tr)/2)*180;
        Angles_Asynchrony_Values_wt25SD_slow_half(val)=angle_wt25SD_slow_half;
    end
    alpha_rad_wt25SD_slow_half{p,tr} = circ_ang2rad(Angles_Asynchrony_Values_wt25SD_slow_half');
    
    Angles_Asynchrony_Values_wt25SD_fast_half=[];
    for val=1:length(Asynchrony_Values_wt25SD_fast_half)
        angle_wt25SD_fast_half=Asynchrony_Values_wt25SD_fast_half(val)/(tempo_fast_half(p,tr)/2)*180;
        Angles_Asynchrony_Values_wt25SD_fast_half(val)=angle_wt25SD_fast_half;
    end
    alpha_rad_wt25SD_fast_half{p,tr} = circ_ang2rad(Angles_Asynchrony_Values_wt25SD_fast_half');
    
    
    Angles_Asynchrony_Values_wt25SD_slow_double=[];
    for val=1:length(Asynchrony_Values_wt25SD_slow_double)
        angle_wt25SD_slow_double=Asynchrony_Values_wt25SD_slow_double(val)/(tempo_slow_double(p,tr)/2)*180;
        Angles_Asynchrony_Values_wt25SD_slow_double(val)=angle_wt25SD_slow_double;
    end
    alpha_rad_wt25SD_slow_double{p,tr} = circ_ang2rad(Angles_Asynchrony_Values_wt25SD_slow_double');
    
    Angles_Asynchrony_Values_wt25SD_fast_double=[];
    for val=1:length(Asynchrony_Values_wt25SD_fast_double)
        angle_wt25SD_fast_double=Asynchrony_Values_wt25SD_fast_double(val)/(tempo_fast_double(p,tr)/2)*180;
        Angles_Asynchrony_Values_wt25SD_fast_double(val)=angle_wt25SD_fast_double;
    end
    alpha_rad_wt25SD_fast_double{p,tr} = circ_ang2rad(Angles_Asynchrony_Values_wt25SD_fast_double');
    
    Angles_Asynchrony_Values_wt25SD_allSub=[];
    for val=1:length(Asynchrony_Values_wt25SD_allSub)
        angle_wt25SD_allSub=Asynchrony_Values_wt25SD_allSub(val)/(tempo_allSub(p,tr)/2)*180;
        Angles_Asynchrony_Values_wt25SD_allSub(val)=angle_wt25SD_allSub;
    end
    alpha_rad_wt25SD_allSub{p,tr} = circ_ang2rad(Angles_Asynchrony_Values_wt25SD_allSub');
    
    
    
    
        
    %PLOTTING BOTH
    alpha_bar_slow = circ_mean(alpha_rad_wt25SD_slow{p,tr});        R_alpha_slow(p,tr) = circ_r(alpha_rad_wt25SD_slow{p,tr});
    alpha_bar_fast = circ_mean(alpha_rad_wt25SD_fast{p,tr});        R_alpha_fast(p,tr) = circ_r(alpha_rad_wt25SD_fast{p,tr});
    alpha_bar_cycle = circ_mean(alpha_rad_wt25SD_cycle{p,tr});      R_alpha_cycle(p,tr) = circ_r(alpha_rad_wt25SD_cycle{p,tr});
    alpha_bar_slow_half = circ_mean(alpha_rad_wt25SD_slow_half{p,tr});      R_alpha_slow_half(p,tr) = circ_r(alpha_rad_wt25SD_slow_half{p,tr});
    alpha_bar_fast_half = circ_mean(alpha_rad_wt25SD_fast_half{p,tr});      R_alpha_fast_half(p,tr) = circ_r(alpha_rad_wt25SD_fast_half{p,tr});
    alpha_bar_slow_double = circ_mean(alpha_rad_wt25SD_slow_double{p,tr});  R_alpha_slow_double(p,tr) = circ_r(alpha_rad_wt25SD_slow_double{p,tr});
    alpha_bar_fast_double = circ_mean(alpha_rad_wt25SD_fast_double{p,tr});  R_alpha_fast_double(p,tr) = circ_r(alpha_rad_wt25SD_fast_double{p,tr});
    alpha_bar_allSub = circ_mean(alpha_rad_wt25SD_allSub{p,tr});            R_alpha_allSub(p,tr) = circ_r(alpha_rad_wt25SD_allSub{p,tr});
    
    
    
    
    if size(tapping_TAPS_without25SD,2)<21 && size(tapping_TAPS_without25SD,2)>16
        subplot(4,5,tr)
    elseif size(tapping_TAPS_without25SD,2)<16
        subplot(3,5,tr)
    else
    subplot(4,6,tr)
    end
    
        if isempty(alpha_rad_wt25SD_slow{p,tr})==0
        p_alpha_slow(p,tr) = circ_rtest(alpha_rad_wt25SD_slow{p,tr}); %to test if tapping randomly (uniformly distributed) or unimodally
        p_alpha_fast(p,tr) = circ_rtest(alpha_rad_wt25SD_fast{p,tr}); %to test if tapping randomly (uniformly distributed) or unimodally
        p_alpha_cycle(p,tr) = circ_rtest(alpha_rad_wt25SD_cycle{p,tr}); %to test if tapping randomly (uniformly distributed) or unimodally
        p_alpha_slow_half(p,tr) = circ_rtest(alpha_rad_wt25SD_slow_half{p,tr}); %to test if tapping randomly (uniformly distributed) or unimodally
        p_alpha_fast_half(p,tr) = circ_rtest(alpha_rad_wt25SD_fast_half{p,tr}); %to test if tapping randomly (uniformly distributed) or unimodally
        p_alpha_slow_double(p,tr) = circ_rtest(alpha_rad_wt25SD_slow_double{p,tr}); %to test if tapping randomly (uniformly distributed) or unimodally
        p_alpha_fast_double(p,tr) = circ_rtest(alpha_rad_wt25SD_fast_double{p,tr}); %to test if tapping randomly (uniformly distributed) or unimodally
        p_alpha_allSub(p,tr) = circ_rtest(alpha_rad_wt25SD_allSub{p,tr}); %to test if tapping randomly (uniformly distributed) or unimodally
       
        
        if (p_alpha_slow_double(p,tr)<0.05 || p_alpha_slow(p,tr)<0.05 || p_alpha_slow_half(p,tr)<0.05)...
                && (p_alpha_fast_double(p,tr)<0.05 || p_alpha_fast(p,tr)<0.05 || p_alpha_fast_half(p,tr)<0.05)
            weirdness(p,tr)=1;
        else
            weirdness(p,tr)=0;
        end
        
            if  p_alpha_slow(p,tr)<0.05%R_alpha_slow>0.5
                circ_plot(alpha_rad_wt25SD_slow{p,tr},'pretty','bo',true,'linewidth',2,'color','r');hold on;
            else
                circ_plot(alpha_rad_wt25SD_slow{p,tr},'pretty','bo',true,'linewidth',2,'color','b');hold on; %slow meter
            end
            
            if p_alpha_fast(p,tr)<0.05%R_alpha_fast>0.5
                circ_plot(alpha_rad_wt25SD_fast{p,tr},'pretty','go',true,'linewidth',2,'color','m');hold on;
            else
                circ_plot(alpha_rad_wt25SD_fast{p,tr},'pretty','go',true,'linewidth',2,'color','g'); hold on;%fast meter
            end
            
            
            if p_alpha_slow_half(p,tr)<0.05 %&& R_alpha_slow(p,tr)< R_alpha_slow_half(p,tr) %R_alpha_fast>0.5
                circ_plot(alpha_rad_wt25SD_slow_half{p,tr},'pretty','r.',true,'linewidth',1,'color',[1 0.85 0.65]);hold on; %light orange
            else
                %circ_plot(alpha_rad_wt25SD_fast{p,tr},'pretty','c.',true,'linewidth',2,'color','g'); hold on; %half slow meter
            end
            
            if p_alpha_fast_half(p,tr)<0.05 %&& R_alpha_fast(p,tr)< R_alpha_fast_half(p,tr)%R_alpha_fast>0.5
                circ_plot(alpha_rad_wt25SD_fast_half{p,tr},'pretty','m.',true,'linewidth',1,'color',[0 0.85 0.65]);hold on; %light green
            else
                %circ_plot(alpha_rad_wt25SD_fast{p,tr},'pretty','c.',true,'linewidth',2,'color','g'); hold on;%half fast meter
            end
            
            if p_alpha_slow_double(p,tr)<0.05 %&& R_alpha_slow(p,tr)< R_alpha_slow_double(p,tr) %R_alpha_fast>0.5
                circ_plot(alpha_rad_wt25SD_slow_double{p,tr},'pretty','r.',true,'linewidth',1,'color',[1 0.65 0.65]);hold on; %dark orange
            else
                %circ_plot(alpha_rad_wt25SD_fast{p,tr},'pretty','c.',true,'linewidth',2,'color','g'); hold on;%fast meter
            end
            
            if p_alpha_fast_double(p,tr)<0.05 %&& R_alpha_fast(p,tr)< R_alpha_fast_double(p,tr)%R_alpha_fast>0.5
                circ_plot(alpha_rad_wt25SD_fast_double{p,tr},'pretty','m.',true,'linewidth',1,'color',[0 0.65 0.65]);hold on; %dark turquoise
            else
                %circ_plot(alpha_rad_wt25SD_fast{p,tr},'pretty','c.',true,'linewidth',2,'color','g'); hold on;%fast meter
            end
        
            if p_alpha_allSub(p,tr)<0.05 %&& R_alpha_allSub(p,tr)< R_alpha_slow_double(p,tr) && R_alpha_allSub(p,tr)< R_alpha_fast_double(p,tr) %R_alpha_fast>0.5
                circ_plot(alpha_rad_wt25SD_allSub{p,tr},'pretty','y.',true, 'linewidth',2,'color',[0.75, 0.75, 0.75]);hold on; %gray
            else
                %circ_plot(alpha_rad_wt25SD_fast{p,tr},'pretty','c.',true,'linewidth',2,'color','g'); hold on;%fast meter
            end
            
            if p_alpha_cycle(p,tr)<0.05%R_alpha_cycle>0.5
                circ_plot(alpha_rad_wt25SD_cycle{p,tr},'pretty','yx',true,'linewidth',2,'color','k');hold on;
            else
                circ_plot(alpha_rad_wt25SD_cycle{p,tr},'pretty','yx',true,'linewidth',2,'color','y');hold on; %cycle/bar meter
            end
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%title & METER choice
        if isnan(R_alpha_cycle(p,tr))==1 % || isnan(R_alpha_fast)==1 || isnan(R_alpha_slow)==1
            title(Title(tr))
            ChosenMeter(p,tr)= 99;%NAN   
        else
            TitleW={[Title{tr} '-'  num2str(weirdness(p,tr))]};
            
            
            
            if R_alpha_slow(p,tr)>=R_alpha_fast(p,tr) && R_alpha_slow(p,tr)>=R_alpha_cycle(p,tr)...
                    && R_alpha_slow(p,tr)>=R_alpha_slow_half(p,tr) && R_alpha_slow(p,tr)>=R_alpha_fast_half(p,tr)...
                    && R_alpha_slow(p,tr)>=R_alpha_slow_double(p,tr) && R_alpha_slow(p,tr)>=R_alpha_fast_double(p,tr)...
                    && R_alpha_slow(p,tr)>=R_alpha_allSub(p,tr)
                title([TitleW 'Slow, Ray. p= ' num2str(p_alpha_slow(p,tr)) ' '])%fprintf('Rayleigh Test, \t\t P = %.4f\n',[p_alpha])
                if p_alpha_slow(p,tr)<0.05
                ChosenMeter(p,tr)= 12;
                else
                ChosenMeter(p,tr)= 88;    
                end
            
            elseif R_alpha_fast(p,tr)>=R_alpha_slow(p,tr) && R_alpha_fast(p,tr)>=R_alpha_cycle(p,tr)...
                    && R_alpha_fast(p,tr)>=R_alpha_slow_half(p,tr) && R_alpha_fast(p,tr)>=R_alpha_fast_half(p,tr)...
                    && R_alpha_fast(p,tr)>=R_alpha_slow_double(p,tr) && R_alpha_fast(p,tr)>=R_alpha_fast_double(p,tr)...
                    && R_alpha_fast(p,tr)>=R_alpha_allSub(p,tr)
                title([TitleW 'Fast, Ray. p= ' num2str(p_alpha_fast(p,tr)) ' '])%fprintf('Rayleigh Test, \t\t P = %.4f\n',[p_alpha])
                if p_alpha_fast(p,tr)<0.05
                ChosenMeter(p,tr)= 22;
                else
                ChosenMeter(p,tr)= 88;    
                end
                
                
             elseif R_alpha_cycle(p,tr)>=R_alpha_slow(p,tr) && R_alpha_cycle(p,tr)>=R_alpha_fast(p,tr)...
                    && R_alpha_cycle(p,tr)>=R_alpha_fast_double(p,tr) && R_alpha_cycle(p,tr)>=R_alpha_slow_double(p,tr)...
                    && (R_alpha_cycle(p,tr)+0.000001)>=R_alpha_slow_half(p,tr) && R_alpha_cycle(p,tr)>=R_alpha_fast_half(p,tr)...
                    && R_alpha_cycle(p,tr)>=R_alpha_allSub(p,tr)
                title([TitleW 'Cycle, Ray. p= ' num2str(p_alpha_cycle(p,tr)) ' '])
                if p_alpha_cycle(p,tr)<0.05
                    ChosenMeter(p,tr)= 30;
                else
                    ChosenMeter(p,tr)= 88;
                end
            
      
            elseif R_alpha_allSub(p,tr)>=R_alpha_slow(p,tr) && R_alpha_allSub(p,tr)>=R_alpha_fast(p,tr)...
                    && R_alpha_allSub(p,tr)>=R_alpha_cycle(p,tr) && (R_alpha_allSub(p,tr)+0.000001)>=R_alpha_fast_double(p,tr)...
                    && R_alpha_allSub(p,tr)>=R_alpha_slow_double(p,tr) && R_alpha_allSub(p,tr)>=R_alpha_slow_half(p,tr)...
                    && R_alpha_allSub(p,tr)>=R_alpha_fast_half(p,tr)%%ALL SUBDIVISIONS
                title([TitleW 'All Subdiv, Ray. p= ' num2str(p_alpha_allSub(p,tr)) ' '])%fprintf('Rayleigh Test, \t\t P = %.4f\n',[p_alpha])
                if p_alpha_allSub(p,tr)<0.05
                    ChosenMeter(p,tr)= 40;
                else
                    ChosenMeter(p,tr)= 88;
                end
            
            elseif R_alpha_slow_half(p,tr)>=R_alpha_slow(p,tr) && R_alpha_slow_half(p,tr)>=R_alpha_fast(p,tr)...
                    && R_alpha_slow_half(p,tr)>=(R_alpha_cycle(p,tr)+0.000001) && R_alpha_slow_half(p,tr)>=R_alpha_fast_half(p,tr)...
                    && R_alpha_slow_half(p,tr)>=R_alpha_fast_double(p,tr) && R_alpha_slow_half(p,tr)>=R_alpha_slow_double(p,tr)...
                    && R_alpha_slow_half(p,tr)>=R_alpha_allSub(p,tr)
                title([TitleW 'Slow-half, Ray. p= ' num2str(p_alpha_slow_half(p,tr)) ' '])
                if p_alpha_slow_half(p,tr)<0.05
                ChosenMeter(p,tr)= 13;
                else
                ChosenMeter(p,tr)= 88;    
                end
            
            elseif R_alpha_fast_half(p,tr)>=R_alpha_slow(p,tr) && R_alpha_fast_half(p,tr)>=R_alpha_fast(p,tr)...
                    && R_alpha_fast_half(p,tr)>=R_alpha_cycle(p,tr) && R_alpha_fast_half(p,tr)>=R_alpha_slow_half(p,tr)...
                    && R_alpha_fast_half(p,tr)>=R_alpha_fast_double(p,tr) && R_alpha_fast_half(p,tr)>=R_alpha_slow_double(p,tr)...
                    && R_alpha_fast_half(p,tr)>=R_alpha_allSub(p,tr)
                title([TitleW 'Fast-half, Ray. p= ' num2str(p_alpha_fast_half(p,tr)) ' '])
                if p_alpha_fast_half(p,tr)<0.05
                ChosenMeter(p,tr)= 23;
                else
                ChosenMeter(p,tr)= 88;    
                end
                
            elseif R_alpha_slow_double(p,tr)>=R_alpha_slow(p,tr) && R_alpha_slow_double(p,tr)>=R_alpha_fast(p,tr)...
                    && R_alpha_slow_double(p,tr)>=R_alpha_cycle(p,tr) && R_alpha_slow_double(p,tr)>=R_alpha_fast_double(p,tr)...
                    && R_alpha_slow_double(p,tr)>=R_alpha_fast_half(p,tr) && R_alpha_slow_double(p,tr)>=R_alpha_slow_half(p,tr)...
                    && R_alpha_slow_double(p,tr)>=R_alpha_allSub(p,tr)
                title([TitleW 'Slow-double, Ray. p= ' num2str(p_alpha_slow_double(p,tr)) ' '])
                if p_alpha_slow_double(p,tr)<0.05
                ChosenMeter(p,tr)= 11;
                else
                ChosenMeter(p,tr)= 88;    
                end
            
            elseif R_alpha_fast_double(p,tr)>=R_alpha_slow(p,tr) && R_alpha_fast_double(p,tr)>=R_alpha_fast(p,tr)...
                    && R_alpha_fast_double(p,tr)>=R_alpha_cycle(p,tr) && R_alpha_fast_double(p,tr)>=R_alpha_slow_double(p,tr)...
                    && R_alpha_fast_double(p,tr)>=R_alpha_slow_half(p,tr) && R_alpha_fast_double(p,tr)>=R_alpha_fast_half(p,tr)...
                    && R_alpha_fast_double(p,tr)>=(R_alpha_allSub(p,tr)+0.000001)
                title([TitleW 'Fast-double, Ray. p= ' num2str(p_alpha_fast_double(p,tr)) ' '])
                if p_alpha_fast_double(p,tr)<0.05
                    ChosenMeter(p,tr)= 21;
                else
                    ChosenMeter(p,tr)= 88;
                end
                
                
            else
                title([TitleW 'Weird, Ray. p= ' ' ? '])
                ChosenMeter(p,tr)= 77;
            end
 
        end
            
            
    
    end

     
    
     
    end
     Filename=[File_name num2str(p) '_BothMeters_Asy25SD'];
     print(Filename,'-dpng')%close all%
 
     close all
     
end