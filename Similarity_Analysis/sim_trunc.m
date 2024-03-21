% Author: Lucas Simon Araujo
% Last Modified: 26/02/2024
%Avaliation of the truncation influence into the similarity between
%original and DMD reconnstruction
%Input:
%           *(ackley/rastrigin) dynamic field
%           *truncation
%Output:
%           *similarity vs truncation plot
clear; close all; clc;
%----------------------------------------------
%User's entries
opt = "ackley";
%----------------------------------------------
switch opt
    case "ackley"
        R = 1:25;
    case "rastrigin"
        R = 1:12;
end

%prealocating
cos_theta = zeros(1,length(R));

for r = 1:length(R)
    %compute DMD reconstruction
    [Phi, omega, S1, field_r, field, x1, x2] = dmd_rec(opt, R(r));
    %exclude last snap to match dimensions
    field = field(:,:,1:(end-1));
    % Recovering dimensions
    [m,n, snaps] = size(field);
    % Initializing augmented matrices
    Y=[];
    Y_r=[];
    for t = 1: snaps
        %transform each snapshot matrix (mxn) into a single vector(m.nx1)
        col = reshape(field(:,:,t),[m*n,1]);
        col_r = reshape(field_r(:,:,t),[m*n,1]);
        %attach all resulted snapshot vectors side by side
        Y = [Y, col];
        Y_r = [Y_r, col_r];        
    end
    %similarity check
    v1 = reshape(Y,[],1);
    v2 = reshape(Y_r,[],1);
    cos_theta(r) = dot(v1,v2)/(norm(v1)*norm(v2));    
end

%% Plotting results
figure
hold on
r=19;
xregion(0,r,'FaceColor',[0.65 0.65 0.65])
%yline(1,'k','LineWidth',3)
stem(R,real(cos_theta),'filled','--','Color','k','LineWidth',1,'MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'MarkerSize',10)
%stem(R,real(cos_theta),'filled',':r','MarkerSize',6,'LineWidth',3)
hold off
xlabel('r')
xticks(R)
xtickangle(0)
ylabel('cos(\theta)')
xlim([R(1)-1 R(end)+1])
% xlim([0 26])
% ylim([0.999*min(real(cos_theta)) 1.001*max(real(cos_theta))])
ylim([0.9 1])
%axis([R(1) R(end) 0.9*min(real(cos_theta)) 1.1*max(real(cos_theta))] )
% axis square
box on
% grid on
ax = gca;
ax.FontSize = 20;