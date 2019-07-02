clear all;
close all;
clc;
%% Add lib path

addpath(genpath('reader/'));
addpath(genpath('preproc/'));
addpath(genpath('utils/'));
addpath(genpath('analysis/'));

%create directory
wor_dir = '/Volumes/My Passport/Diffraction-Pattern-Analysis-master'; %mac
% wor_dir = 'E:\Diffraction-Pattern-Analysis-master'; %win
cd(wor_dir)
% 
% Init parameter
shape  = [1024, 1024];
center = [530 520];
radius_range = [0 200];
ring_width   = 2;
angle_step   = 360;
%% Create new masks
 
[ring_masks,sector_masks] = masks( shape, center, radius_range, ring_width, angle_step );

%% Get the radius-intensity matrix for each of the frame
load 'ito_raw_data.mat';
mats_size  = size(mats, 3);
masks_size = size(ring_masks, 3);
radius_intensity_mat_mean = ones(mats_size, masks_size);
radius_intensity_mat_max = ones(mats_size, masks_size);
Nor_radius_intensity_mat_mean = ones(mats_size, masks_size);

for i=1:mats_size
    for j=1:masks_size
        fprintf('Processing %d mat and %d ring\n', i, j);
        ring = int8(mats(:,:,i)) .* int8(ring_masks(:,:,j));
%         radius_intensity_mat_mean1(i,j) = mean(ring(:));
% %          this is the only thing I changed.
        radius_intensity_mat_mean(i,j) = sum(ring(:))./sum(sum(ring_masks(:,:,j)));
        radius_intensity_mat_max(i,j) = max(ring(:));
        Nor_radius_intensity_mat_mean = radius_intensity_mat_mean(i,j)./radius_intensity_mat_max(i,j);
    end
end
save('radius_intensity_mat_mean.mat','radius_intensity_mat_mean','-v7.3');
save('radius_intensity_mat_max.mat','radius_intensity_mat_max','-v7.3');
save('Nor_radius_intensity_mat_mean.mat','Nor_radius_intensity_mat_mean','-v7.3');
% tok
% [pks,locs,w,p] = findpeaks(mean_r_i);
% highest_pk = max(pks);
%use crystal maker sim to find desired radii of pkA,pkB,pkC,pkD
