%Author: Lucas Simon Araújo
% Based on: https://www.sfu.ca/~ssurjano/rastr.html
% Last modified: 20/02/2024

% Plot the comparison: dynamic fields and reconstructed ones
% Ackley test function, Rastrigin test function
% Input: 
%            dynamic field data
% Output:
%           contour_plot comparison
%           surface plot comparison
%           instants plot comparison

clear; close all; clc;
%-------------------------------------------------
% User entries
%choose function
opt = 'griewank';
%record charts? (yes/no)
rec = 'yes';
%which charts to plot?
Cont = 'no';   %contour
Surf = 'no';   %surface
Insts = 'yes';  %instants
instants = [1,50,100];
%-------------------------------------------------

%load data
switch opt
    case 'ackley'
        load ack_dyn_field.mat field x1 x2
        load ack_rec_field.mat r S1 field_r
    case 'rastrigin'
        load ras_dyn_field.mat field x1 x2
        load ras_rec_field.mat r S1 field_r
    case 'schaffer'
        load sch_dyn_field.mat field x1 x2
        load sch_rec_field.mat r S1 field_r
    case 'griewank'
        load grie_dyn_field.mat field x1 x2
        load grie_rec_field.mat r S1 field_r
end

% recover field dimensions 
% using reconstructed, once it's 1 snap smaller
m = size(field_r,1);
n = size(field_r,2);
snaps = size(field_r,3);

%eliminating last collumn from original data 
%to match reconstructed size
field = field(:,:,1:snaps);

% compute field limits
mag_field = mag_com(field);
min_field = min(mag_field,[],"all");
max_field = max(mag_field,[],"all");

mag_field_r = mag_com(field_r);
min_field_r = min(mag_field_r,[],"all");
max_field_r = max(mag_field_r,[],"all");

%% Plotting

%initiallizing figures
if Cont == "yes"
    a = figure;
    a.Position = [160 123 1004 473];
end
if Surf == "yes"
    b = figure;
    b.Position = [160 123 1004 473];
end

for t = 1: snaps
    % CONTOUR
    if Cont == "yes"
        figure(a)
        t1 = tiledlayout(1,2, 'Padding', 'none', 'TileSpacing', 'compact');
        
        nexttile
        colormap("turbo")
        contourf(x1,x2,mag_field(:,:,t));
        clim([min_field max_field]);
        xlabel('x_1');    ylabel('x_2');
        box on;
        ax = gca;    ax.FontSize = 20;
        axis([x1(1) x1(end) x2(1) x2(end)])
    
        nexttile
        colormap("turbo")
        contourf(x1,x2,mag_field_r(:,:,t));
        colorbar;    clim([min_field_r max_field_r]);
        xlabel('x_1');   
        box on;
        ax = gca;    ax.FontSize = 20;
        axis([x1(1) x1(end) x2(1) x2(end)])
    end
    %----------------------------------------------
    % SURFACE
    if Surf =="yes"
        figure(b)
        t2 = tiledlayout(1,2, 'Padding', 'none', 'TileSpacing', 'compact');
        
        nexttile
        colormap("turbo");
        s = surf(x1,x2,mag_field(:,:,t));
        s.EdgeColor = 'none';    s.FaceColor = 'interp';
        clim([min_field max_field]);
        xlabel('x_1');    ylabel('x_2');
        ax = gca;    ax.FontSize = 20;
        axis([x1(1) x1(end) x2(1) x2(end)])
        
        nexttile
        colormap("turbo");
        s = surf(x1,x2,mag_field_r(:,:,t));
        s.EdgeColor = 'none';    s.FaceColor = 'interp';
        colorbar;    clim([min_field_r max_field_r]);
        xlabel('x_1');    ylabel('x_2');
        ax = gca;    ax.FontSize = 20;
        axis([x1(1) x1(end) x2(1) x2(end)])
    end

    if (rec == "yes") && ((Cont == "yes")||(Surf == "yes")) 
        if opt == "ackley"
            saveas(a,['ack_com_cont_',num2str(t),'.png'])
            saveas(b,['ack_com_surf_',num2str(t),'.png'])
        elseif opt == "rastrigin"
            saveas(a,['ras_com_cont_',num2str(t),'.png'])
            saveas(b,['ras_com_surf_',num2str(t),'.png'])
        elseif opt == "schaffer"
            saveas(a,['sch_com_cont_',num2str(t),'.png'])
            saveas(b,['sch_com_surf_',num2str(t),'.png'])
        elseif opt == "griewank"
            saveas(a,['grie_com_cont_',num2str(t),'.png'])
            saveas(b,['grie_com_surf_',num2str(t),'.png'])
        end
    end

end

%% INSTANTS
if Insts =="yes"
    %storing time steps
    y1 = mag_field(:,:,instants(1));
    y2 = mag_field(:,:,instants(2));
    y3 = mag_field(:,:,instants(3));
    
    y1_r = mag_field_r(:,:,instants(1));
    y2_r = mag_field_r(:,:,instants(2));
    y3_r = mag_field_r(:,:,instants(3));
    
    %initiallizing figure
    c = figure;
    c.Position = [219    42   907   642];
    figure(c)
    t3 = tiledlayout(2,3, 'Padding', 'none', 'TileSpacing', 'compact');
    colormap("turbo")
    
    nexttile
    contourf(x1,x2,y1); clim([min_field max_field]);
    title(['t_{' num2str(instants(1)) '}']);
    ylabel('x_2');  axis equal;
    ax = gca;   ax.FontSize = 20;   ax.XTick = [];
    axis([x1(1) x1(end) x2(1) x2(end)])
    
    nexttile
    contourf(x1,x2,y2); clim([min_field max_field])
    title(['t_{' num2str(instants(2)) '}'])
    axis equal; ax = gca;   ax.FontSize = 20;   ax.XTick = [];  ax.YTick = [];
    axis([x1(1) x1(end) x2(1) x2(end)])
    
    nexttile
    contourf(x1,x2,y3); colorbar;   clim([min_field max_field])
    title(['t_{' num2str(instants(3)) '}'])
    axis equal; ax = gca;   ax.FontSize = 20;   ax.XTick = [];  ax.YTick = [];
    axis([x1(1) x1(end) x2(1) x2(end)])
    %--------------------------------------
    nexttile
    contourf(x1,x2,y1_r); clim([min_field_r max_field_r]);
    ylabel('x_2');  axis equal;
    ax = gca;   ax.FontSize = 20;   
    axis([x1(1) x1(end) x2(1) x2(end)])
    
    nexttile
    contourf(x1,x2,y2_r); clim([min_field_r max_field_r])
    xlabel('x_1');  axis equal;
    ax = gca;   ax.FontSize = 20;   ax.YTick = [];
    axis([x1(1) x1(end) x2(1) x2(end)])
    
    nexttile
    contourf(x1,x2,y3_r); colorbar;   clim([min_field_r max_field_r])
    axis equal; ax = gca;   ax.FontSize = 20;   ax.YTick = [];
    axis([x1(1) x1(end) x2(1) x2(end)])

    if rec == "yes"        
        if opt == "ackley"
            saveas(c,'ack_com_inst','epsc')
        elseif opt == "rastrigin"
            saveas(c,'ras_com_inst','epsc')
        elseif opt == "schaffer"
            saveas(c,'sch_com_inst','epsc')
         elseif opt == "griewank"
            saveas(c,'grie_com_inst','epsc')
        end
    end
end

%% Acessory function

function magnitude = mag_com(field)
    magnitude = sqrt(real(field).^2 + imag(field).^2);
end