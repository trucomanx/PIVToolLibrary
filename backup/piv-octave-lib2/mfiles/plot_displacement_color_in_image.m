function plot_displacement_color_in_image(filename,P,conf)

	N=length(P);

	WSIZE=conf.get_roi_window_size();

	img  = imread(filename);
	figure;	imshow(img);
	

		lins =P{1}.get_array_from_value0();	
		cols =P{1}.get_array_from_value1();

		lins2=P{N}.get_array_from_value0();	
		cols2=P{N}.get_array_from_value1();

		delta=sqrt((cols2-cols).^2+(lins2-lins).^2);
        deltanorm=delta/max(delta);

        cmdefault=colormap;

        cm=colormap(jet);
        colormap(cmdefault);

        L=size(cm,1);
        M=length(deltanorm);

	    hold on;
	    for II=1:M
            IDCOLOR=1+round(deltanorm(II)*(L-1));
            %%cm(IDCOLOR,:)
		    h=rectangle('Position',[cols(II), lins(II), WSIZE, WSIZE], 'LineWidth',1, 'EdgeColor',cm(IDCOLOR,:), 'FaceColor', cm(IDCOLOR,:) );
            %set (h, "FaceColor", cm(IDCOLOR,:) );
	    end
	    hold off;



end

