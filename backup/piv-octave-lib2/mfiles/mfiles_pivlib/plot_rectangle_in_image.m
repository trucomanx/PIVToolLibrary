function plot_rectangle_in_image(filename,P,conf)

	

	WSIZE=conf.get_roi_window_size();	

	img  = imread(filename);

	
	figure;	
	imshow(img);

	lin=P.get_array_from_value0();	
	col=P.get_array_from_value1();

	N=length(lin);

	hold on;
	for II=1:N
		scatter(col(II) ,lin(II) ,"r");
		rectangle('Position',[col(II), lin(II), WSIZE, WSIZE], 'LineWidth',3, 'EdgeColor','b');
	end
	hold off;

end

