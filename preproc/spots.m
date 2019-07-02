function bin_rearr_mats = spots(rearr_mats, rad_ind_range, rad_start, rad_step, ang_step)
%SPOTS Summary of this function goes here
%   Detailed explanation goes here

    %% Extract the bright spots
    bright_spots = [];
    [r,c,l] = size(rearr_mats);
    bin_rearr_mats = zeros(r,c,l);
    for i = 1:r
        % basic configuration
        % extract one row from data
        rows= squeeze(rearr_mats(i,:,:));
        % threshold
        uni_set    = rows(:);
        pd    = fitdist(uni_set,'Normal');
        mu    = pd.mu;
        sigma = pd.sigma;
        threshold = mu + 3.5 * sigma;
        
        for k = 1:l
            bin_rearr_mats(i,:,k) = rearr_mats(i,:,k)>threshold;
        end
        
    end
    


