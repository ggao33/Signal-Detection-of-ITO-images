function [rearranged_mat] = data_extraction (proj_name,mats,shape,center,radius_range,ring_width,angle_step)

switch nargin
    case 7
        %% Add lib path
        % %Create new masks

        [ring_masks, sector_masks] = ...
            masks(shape, center, ...
                  radius_range, ring_width, ... % Ring masks paras
                  angle_step);                  % Sector masks para

        % % Save the masks
        saved_mask_name = sprintf('%s_mask.sha%d.ctr(%d,%d).rad%d-%d.rw%d.as%d.%s.mat', ...
                                  proj_name,shape(1),center(1),center(2),radius_range(1), radius_range(2), ...
                                  ring_width, angle_step,date);
        save(saved_mask_name, 'ring_masks', 'sector_masks','-v7.3');



        % Rearrange the matrix
        rearranged_mat = rearrange(mats, ...
                                   ring_masks, sector_masks);

        % Save the results

        saved_file_name = sprintf('%s_rearr.sha%d.ctr(%d,%d).rad%d-%d.rw%d.as%d.%s.mat', ...
                                  proj_name,shape(1),center(1),center(2),radius_range(1), radius_range(2), ...
                                  ring_width, angle_step, date);
        save(saved_file_name, 'rearranged_mat','-v7.3');
    case 2
        saved_mask_name = proj_name;
        vars = load(saved_mask_name);
        ring_masks   = vars.ring_masks;
        sector_masks = vars.sector_masks;

        % Rearrange the matrix
        rearranged_mat = rearrange(mats, ...
                                   ring_masks, sector_masks);

        % Save the results

        saved_file_name = sprintf('%s_rearr.sha%d.ctr(%d,%d).rad%d-%d.rw%d.as%d.%s.mat', ...
                                  proj_name,shape(1),center(1),center(2),radius_range(1), radius_range(2), ...
                                  ring_width, angle_step, date);
        save(saved_file_name, 'rearranged_mat','-v7.3');
end
end