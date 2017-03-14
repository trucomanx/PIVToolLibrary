function display_entropy_of_roi(filename,P,conf)

	WSIZE=conf.get_roi_window_size();	

	img  = imread(filename);

	lin=P.get_array_from_value0();	
	col=P.get_array_from_value1();

	N=length(lin);

	for II=1:N
		Eb=entropy(img( round(lin(II)):round(lin(II))+WSIZE-1,round(col(II)): round(col(II))+WSIZE-1));
        printf("point(%d):%f\n",II,Eb);
	end

end
