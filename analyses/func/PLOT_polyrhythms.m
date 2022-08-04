addpath 'C:\Users\au631438\Documents\WriteEEGtap_infoFiles\EEG_trials_taps\CircStat2012a'

circ_plot([0; pi],'pretty','rx',true,'linewidth',2,'color','k');hold on;
circ_plot([0; (2/3)*pi; (4/3)*pi;],'pretty','bo',true,'linewidth',2,'color','k')

circ_plot([0; (2/5)*pi; (4/5)*pi; (6/5)*pi; (8/5)*pi],'pretty','r<',true,'linewidth',6,'color','k');hold on;
circ_plot([0; (2/4)*pi; (4/4)*pi; (6/4)*pi],'pretty','bp',true,'linewidth',6,'color','k', 'MarkerSize',100)
view([90 -90])

circ_plot([0; (2/12)*pi; (4/12)*pi; (6/12)*pi; (8/12)*pi; (10/12)*pi; (12/12)*pi; (14/12)*pi; (16/12)*pi; (18/12)*pi; (20/12)*pi; (22/12)*pi],'pretty','k.',true,'linewidth',6,'color','k');hold on
circ_plot([0; (2/3)*pi; (4/3)*pi;],'pretty','r<',true,'linewidth',2,'color','k'); hold on
circ_plot([0; (2/4)*pi; (4/4)*pi; (6/4)*pi],'pretty','mp',true,'linewidth',6,'color','k')
view([90 -90])

%%%
t = 0:(2*pi/3):2*pi;
p=polar(t,[1,1,1,1])
view([90 -90])
p.Color = 'magenta';
p.Marker = 'square';
p.MarkerSize = 8;
%view([180 90])
hold on
t = 0:(2*pi/4):2*pi;
p=polar(t,[1,1,1,1,1])  
view([90 -90])
p.Color = 'green';
p.Marker = 'pentagram';
p.MarkerSize = 8;
%view([180 90])
p.ax.RTick=[0 1]

% polarplot([0, 1.1*-i, 2-1.1*-i], '*')