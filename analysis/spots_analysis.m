function spots_analysis (proj_name,mats,rearranged_mat,shape,center,radius_range,ring_width,angle_step)
%% Add lib path
% cd (wor_dir);
% create path
addpath(genpath('reader/'));
addpath(genpath('preproc/'));
addpath(genpath('utils/'));
addpath(genpath('analysis/'));

%% basic configuration
rad_ind_range = 1:(radius_range(2) - radius_range(1))/2;
rad_start = radius_range(1);
X = center(1);
Y = center(2);


%% generage a binary matrix for rearranged matrix that exceeds thresholds
bin_rearr_mats = spots(rearranged_mat, rad_ind_range, rad_start, ring_width, angle_step);
save('bin_rearr_mats.mat','bin_rearr_mats');
%% save the polar coord and cartisan coord

       
fileID_pos = fopen([sprintf('%s_pos.sha%d.ctr(%d,%d).rad%d-%d.rw%d.as%d.%s', ...
                          proj_name,shape(1),center(1),center(2),radius_range(1), radius_range(2), ...
                          ring_width, angle_step,date) '.txt'],'w');
fprintf(fileID_pos,'%6s %12s\r\n','x','y');
 
fileID_polar = fopen([sprintf('%s_polar.sha%d.ctr(%d,%d).rad%d-%d.rw%d.as%d.%s', ...
                          proj_name,shape(1),center(1),center(2),radius_range(1), radius_range(2), ...
                          ring_width, angle_step,date) '.txt'],'w');
fprintf(fileID_polar,'%6s %12s\r\n','Radius','Angle(degree)');

for i = 1:size(bin_rearr_mats,3)
    pos_list = [];
    polar_list = [];
    [rad ang] = find(bin_rearr_mats(:,:,i) == 1);
    r_list = rad_start + (rad - 1) .* ring_width;
    theta_list= ang .* angle_step - 180;

    fprintf(fileID_pos,'%s\n',['pattern ' int2str(i)]);
    fprintf(fileID_polar,'%s\n',['pattern ' int2str(i)]);
    
    for j = 1: length(theta_list)
        theta = theta_list(j);
        r = r_list(j);
        fprintf(fileID_polar,'%f    %f\r\n',r,theta);
        if (-180 <= theta) && (theta <= -90)
            posX = X - r * abs(cos(theta/180*pi));
            posY = Y - r * abs(sin(theta/180*pi));
        else if (-90 <= theta) && (theta <= 0)
                posX = X + r * abs(cos(theta/180*pi));
                posY = Y - r * abs(sin(theta/180*pi));
            else if (0 <= theta)&& (theta <= 90)
                    posX = X + r * abs(cos(theta/180*pi));
                    posY = Y + r * abs(sin(theta/180*pi));
                else
                    posX = X - r * abs(cos(theta/180*pi));
                    posY = Y + r * abs(sin(theta/180*pi));
                end
            end
        end
       fprintf(fileID_pos,'%f %f\r\n',posX,posY);
       pos_list = [pos_list; horzcat(posX, posY)];
    end
    
%% uncomment this section if visual detection is needed
visual_comparsion (mats,pos_list,i);

end
fclose(fileID_pos);
fclose(fileID_polar);

disp('peak detection is completed!');
end