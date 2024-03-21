%Author: Lucas Simon Araújo
% Based on: https://www.sfu.ca/~ssurjano/rastr.html
% Last modified: 06/03/2024

% Plot modes
% Ackley test function, Rastrigin test function
% Input: 
%            dynamic field data
% Output:
%           modes plot
%           frequency plot

clear; close all; clc;
%-------------------------------------------------
% User entries
%choose function
opt = 'ackley';
%record charts? (yes/no)
rec = 'yes';
instants = [1,50,100];
%which charts?  (yes/no)
Mode = "no";    %mode by mode
Modes = "yes";  %collection of modes
Frequencies = "yes";   % frequency plot
%-------------------------------------------------

%load data
switch opt
    case 'ackley'
        load ack_dyn_field.mat x1 x2
        load ack_rec_field.mat r Phi_r lambda 
    case 'rastrigin'
        load ras_dyn_field.mat x1 x2
        load ras_rec_field.mat r Phi_r lambda 
end

% recover field dimensions 
% using reconstructed, once it's 1 snap smaller
m = size(Phi_r,1);
n = size(Phi_r,2);

% compute field limits
mag_Phi_r = mag_com(Phi_r);
min_Phi_r = min(mag_Phi_r,[],"all");
max_Phi_r = max(mag_Phi_r,[],"all");


%% Mode by Mode
%initiallizing figures
if Mode == "yes"
    a = figure;
    a.Position = [314    42   762   642];
    
    for mode = 1: r
        %Plot mode by mode
        figure(a)    
        colormap("turbo")
        contourf(x1,x2,mag_Phi_r(:,:,mode));
        colorbar;     %clim([min_Phi_r max_Phi_r]);    
        xlabel('x_1');    ylabel('x_2');
        box on;
        axis equal
        ax = gca;    ax.FontSize = 20;
        axis([x1(1) x1(end) x2(1) x2(end)])
        set(gcf, 'color', 'none');    
        set(gca, 'color', 'none');
    
    
        if (rec == "yes") 
            if opt == "ackley"
                saveas(a,['ack_mode_',num2str(mode),'.png'])
            elseif opt == "rastrigin"
                saveas(a,['ras_mode_',num2str(mode),'.png'])
            end
        end
    
    end
end

%% Plot all modes
if Modes == "yes"
    %initiallizing figures
    b = figure;
    b.Position = [144     42    1078   642];
    figure(b)
    t = tiledlayout(2, 3, 'Padding', 'none', 'TileSpacing', 'compact');
    
    % 1st mode
    plot_mode(x1,x2,mag_Phi_r,1,min_Phi_r,max_Phi_r)
    title('r = 1');
    % ylabel('x_2')
    ax = gca; 
    ax.XTick = [];  ax.YTick = [];
    set(gca, 'color', 'none');

    % 5th mode
    plot_mode(x1,x2,mag_Phi_r,5,min_Phi_r,max_Phi_r)
    title('r = 5');
    ax = gca; 
    ax.XTick = [];  ax.YTick = [];
    set(gca, 'color', 'none');

    % 7th mode
    plot_mode(x1,x2,mag_Phi_r,7,min_Phi_r,max_Phi_r)
    title('r = 7');
    ax = gca; 
    ax.XTick = [];   ax.YTick = [];
    % colorbar
    set(gca, 'color', 'none');

    % 9th mode
    plot_mode(x1,x2,mag_Phi_r,9,min_Phi_r,max_Phi_r)
    title('r = 9');
    % ylabel('x_2')
    ax = gca; 
    ax.XTick = [];   ax.YTick = [];
    set(gca, 'color', 'none');

    % 11th mode
    plot_mode(x1,x2,mag_Phi_r,11,min_Phi_r,max_Phi_r)
    title('r = 11');
    ax = gca; 
    ax.XTick = [];   ax.YTick = [];
    % xlabel('x_1');
    set(gca, 'color', 'none');

    % 14th mode
    plot_mode(x1,x2,mag_Phi_r,14,min_Phi_r,max_Phi_r)
    title('r = 14');
    ax = gca;
    ax.XTick = [];   ax.YTick = [];
    set(gca, 'color', 'none');
    % colorbar
    
    set(gcf, 'color', 'none');    

    if (rec == "yes") 
        if opt == "ackley"
            saveas(b,'ack_modes','png')
        elseif opt == "rastrigin"
            saveas(b,'ras_modes','epsc')
        end
    end
end

%% Plot frequencies
if Frequencies == "yes"
    c = figure;
    figure(c);
    plot(real(lambda),imag(lambda),'ok','MarkerSize',10,'LineWidth',2)
    %plot unit circle
    hold on
    fplot(@(t) sin(t), @(t) cos(t), 'r','LineWidth',2);
    grid on;
    axis equal;
    box on;
    ax = gca;    ax.FontSize = 20;
    set(gcf, 'color', 'none');    
    set(gca, 'color', 'none');

    if (rec == "yes") 
        if opt == "ackley"
            saveas(c,'ack_freqs','png')
        elseif opt == "rastrigin"
            saveas(c,'ras_freqs','epsc')
        end
    end
end

%% Acessory function
function plot_mode(x1,x2,Phi,r,min_Phi_r,max_Phi_r)
    nexttile
    colormap("turbo")
    contourf(x1,x2,Phi(:,:,r));
    %colorbar;     
    clim([min_Phi_r max_Phi_r]);    
    %xlabel('x_1');    ylabel('x_2');
    box on;
    axis equal
    ax = gca;    ax.FontSize = 20;
    axis([x1(1) x1(end) x2(1) x2(end)])
end

function magnitude = mag_com(field)
    magnitude = sqrt(real(field).^2 + imag(field).^2);
end