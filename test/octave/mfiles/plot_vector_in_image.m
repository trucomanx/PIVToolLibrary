function plot_vector_in_image(filename,P,VEC,conf)

	

	WSIZE=conf.get_roi_window_size();	

	img  = imread(filename);

	
	figure;	
	imshow(img);

	lin=P.get_array_from_value0();	
	col=P.get_array_from_value1();

	deltalin=VEC.get_array_from_value0();	
	deltacol=VEC.get_array_from_value1();

	N=length(lin);

	hold on;
    scatter(col,lin ,"r");
	quiver(col,lin,deltacol,deltalin,'AutoScale','off');
	hold off;

end

