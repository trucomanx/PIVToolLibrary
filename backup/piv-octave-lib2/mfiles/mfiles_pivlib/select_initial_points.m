function Pin=select_initial_points(filename,conf)

	WSIZE=conf.get_roi_window_size();	

	prompt1 = {'Number of initial Points:'};
	defin1  = {'5'};

	dlg_title = 'Select points';
	num_lines = 1;
	
	answer = inputdlg(prompt1,dlg_title,num_lines,defin1);

	N=str2num(answer{1});

	Pin    =javaObject("net.trucomanx.pdsplibj.pdsra.PdsPoints",N);

	col=zeros(1,N);
	lin=zeros(1,N);

	img  = imread(filename);
	hf=figure;	imshow(img);

	hold on
	for II=1:N
		[col(II),lin(II)]=ginput(1);
		scatter(col(II) ,lin(II) ,"r");
		rectangle('Position',[col(II), lin(II), WSIZE, WSIZE], 'LineWidth',3, 'EdgeColor','b');
	end
	hold off

	msgbox ("Points selected");

	col=floor(col);
	lin=floor(lin);

	Pin.set_arrays(lin,col);
end
