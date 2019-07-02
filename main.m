%main function


% create path
addpath(genpath('reader/'));
addpath(genpath('preproc/'));
addpath(genpath('utils/'));
addpath(genpath('analysis/'));
%create new folder to save data

% Init parameter
%rad 50~100 angle_step = 3/2, ring_width = 2;
%rad 100~150 angle_step = 2/1.5, ring_width = 2;
%rad 150~200 angle_step = 1/0.5, ring_width = 2;


proj_name = 'ito';
shape  = [1024, 1024];
center = [530 520];
radius_range = [100 150];
ring_width   = 2;
angle_step   = 2;

%%
%extract data from images
% mats = import_img(img_dir,proj_name);

%%
%load raw data
load 'ito_raw_data_example.mat';
%% change MATLAB settting£» MAT -v7.3, don't limit RAM usage, change switch JAVA HEAP limit to max
rearranged_mat = data_extraction (proj_name,mats,shape,center,radius_range,ring_width,angle_step);
% rearranged_mat = data_extraction ('Fe_mask.sha512.ctr(530,520).rad79-81.rw2.as3.22-Jun-2017.mat',mats);
%% either generate mask or load the provided mask file for analysis
% load('ito_rearr.sha1024.ctr(530,520).rad100-150.rw2.as2.14-Jun-2017.mat');
spots_analysis (proj_name,mats,rearranged_mat,shape,center,radius_range,ring_width,angle_step);
%% intensity