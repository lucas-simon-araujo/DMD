%Author: Lucas Simon Araújo
% Last modified: 08/03/2024

% Generate the DMD reconstruction of the dynamic fields  
% Ackley test function, Rastrigin test function
% Input: 
%       dynamic fields
% Output:
%      reconstructed dynamic fields
clear; close all; clc;
%---------------------------------------------------
% User's entries
%choose function
opt = 'griewank';
%---------------------------------------------------

%load data
switch opt
    case 'ackley'
        load ack_dyn_field.mat field
    case 'rastrigin'
        load ras_dyn_field.mat field
    case 'schaffer'
        load sch_dyn_field.mat field
    case 'griewank'
        load grie_dyn_field.mat field
end

%recover field variables
m = size(field,1);
n = size(field,2);
snaps = size(field,3);

%% 1st step: Pre-processing
Y = pre_proc(field, m, n);

%% 2nd step: Compute DMD
%time step
dt = 0.001;
%number of modes truncation
switch opt
    case 'ackley'
        r = 19;
    case 'rastrigin'
        r = 7;
    case 'schaffer'
        r = 1;
    case 'griewank'
        r = 2;
end
[Phi, lambda, Y_r, S1] = dmd(Y, dt, r);

%% 3rd step: Post-processing
field_r = post_proc(Y_r, m, n);
Phi_r = post_proc(Phi, m, n);

%% Save the results
switch opt
    case 'ackley'
        save ack_rec_field.mat r Phi_r lambda S1 field_r
    case 'rastrigin'
        save ras_rec_field.mat r Phi_r lambda S1 field_r
    case 'schaffer'
        save sch_rec_field.mat r Phi_r lambda S1 field_r
    case 'griewank'
        save grie_rec_field.mat r Phi_r lambda S1 field_r
end