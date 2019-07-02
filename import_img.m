% function mats = import_img (workingDir,proj_name)

workingDir = '/Volumes/MyPassport/Fe Corrosion for Kacher - In situ EXP12/Fe_12_part1';
% Define the working directory where the images store.

imageNames = dir(fullfile(workingDir, '*.tif'));
imageNames = {imageNames.name}';
imageNames = sort_nat(imageNames);
mats = [];
%%
for i = 1:length(imageNames)
    img = imread(fullfile(workingDir , imageNames{i}));
    s = sprintf('reading image %d',i);
    disp(s);
%     imshow(fullfile(workingDir, imageNames{i}));
    mats = cat(3, mats, img);
end

saved_file_name = sprintf('%s_raw_data.mat', proj_name);
save(saved_file_name, 'mats','-v7.3');

% end