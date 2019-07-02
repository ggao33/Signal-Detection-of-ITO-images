function visual_comparsion (mats,pos_list,i)
%% examine the peak locations visually with raw data

I = mats(:,:,i);
    if isempty(pos_list)
            fig  = figure;
            set(fig, 'Visible', 'off')
            imshow(I)
            saveas(fig,[date 'ito_fig' int2str(i)],'png');
    else
            RGB = insertMarker(I,pos_list,'o','color','green','size',3);
            fig  = figure;
            set(fig, 'Visible', 'off')
            imshow(RGB)
            saveas(fig,[date 'ito_fig' int2str(i)],'png');
    end

end