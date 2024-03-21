%Author: Lucas Simon Araújo
% Based on: https://www.sfu.ca/~ssurjano/rastr.html
% Last modified: 12/03/2024

% Plot singular values from the dynamic field
% Ackley, Rastrigin, Schaffer, Griewank test functions
% Input: 
%            dynamic field data
% Output:
%           singular values plot with truncation indication
clear; close all; clc;

%------------------------------------------------
%User's entries
%choose function
opt = 'griewank';
%record charts? (yes/no)
rec = 'yes';
%------------------------------------------------

%load data
switch opt
    case 'ackley'
        load ack_rec_field.mat r S1 field_r
    case 'rastrigin'
        load ras_rec_field.mat r S1 field_r
    case 'schaffer'
        load sch_rec_field.mat r S1 field_r
    case 'griewank'
        load grie_rec_field.mat r S1 field_r
end

% verifying how many modes to truncate trough the diagonal matrix S relevance
a = figure;     a.Position = [3 42 1362 642];
hold on
% xregion(0,r,'FaceColor','b')
% xregion(0,r,'FaceColor',[0.89453 0.89453 0.125])
%xregion(0,r,'FaceColor',[0.39062 0.50391 0.87109])
xregion(0,r,'FaceColor',[0.65 0.65 0.65])
S2 = diag(S1);
Smax = max(S2);
Smin = min(S2);
deltaS = Smax - Smin;
stem(1:25,S2(1:25),'filled','--','Color','k','LineWidth',1,'MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'MarkerSize',10)  %or
% stem(1:25,S2(1:25),'filled',':','Color','k','LineWidth',2,'MarkerFaceColor',[0.13672 0.26172 0.67187],'MarkerEdgeColor',[0.13672 0.26172 0.67187],'MarkerSize',8)  %b
% stem(1:25,S2(1:25),'filled',':','Color','k','LineWidth',2,'MarkerFaceColor',[0.65625 0.55859 0.29687],'MarkerEdgeColor',[0.65625 0.55859 0.29687],'MarkerSize',8)  %br
% stem(1:25,S2(1:25),'filled',':','Color','k','LineWidth',2,'MarkerFaceColor',[0.46484 0.41797 0.28906],'MarkerEdgeColor',[0.46484 0.41797 0.28906],'MarkerSize',8)  %grey
xlim([0 26]);   ylim([0 (Smax+0.75*deltaS)]);
xticks(1:25);   xtickangle(0);
hold off
ax = gca;   ax.FontSize = 20;
set(ax,'yscal','log')
box on
% axis square   %grid on;
ylabel('i');    xlabel('r');

if rec == "yes"        
    if opt == "ackley"
        saveas(a,'ack_sv','epsc')
    elseif opt == "rastrigin"
        saveas(a,'ras_sv','epsc')
    elseif opt == "schaffer"
        saveas(a,'sch_sv','epsc')
    elseif opt == "griewank"
        saveas(a,'grie_sv','epsc')
    end
end