addpath(genpath('/Volumes/MyPassport/Fe Corrosion for Kacher - In situ EXP11/tiff_data'));

addpath(genpath('/Volumes/MyPassport/Yao Data/tif_data'))
% filename = 'In situ EXP11_Hour_00_Minute_00_Second_37_Frame_0089.tif';
filename = 'ITO_D10_patterns_Hour_00_Minute_00_Second_00_Frame_0046.tif';
mat = imread(filename);

%%
center_x = 530;
center_y = 520;

dist = 150; % The type of the distance   79-81 (detection range 75-150)
new_mat = mat(center_x - dist:center_x+dist, center_y - dist:center_y+dist);
figure; 
imshow(new_mat); 
imcontrast(gca);