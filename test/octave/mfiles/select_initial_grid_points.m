function [Pin Nl Nc]=select_initial_grid_points(filename,conf)

	WSIZE=conf.get_roi_window_size();	

	prompt1 = {'Number of points by line:'	,'Number of points by column:'	,'vertical displacement in pixels:'};
	defin1  = {'5'							,'1'							,'30'};

	dlg_title = 'Select points';
	num_lines = 1;
	
	answer = inputdlg(prompt1,dlg_title,num_lines,defin1);

	Nc=str2num(answer{1});
	Nl=str2num(answer{2});
	N=Nl*Nc;

	Pin    =javaObject("net.trucomanx.pdsplibj.pdsra.PdsPoints",N);

	col=zeros(1,N);
	lin=zeros(1,N);

	img  = imread(filename);
	hf=figure;	imshow(img);
	[ac,al]=ginput(1);
	ac=round(ac);
	al=round(al);
	NCOL=size(img,2);
	deltac=(NCOL-2*(ac-1))/Nc;
	deltal=str2num(answer{3});

	for c=0:(Nc-1)
	for l=0:(Nl-1)
		col(c*Nl+l+1)=ac+c*deltac;
		lin(c*Nl+l+1)=al+l*deltal;
	end
	end


	hold on
	for II=1:N
		scatter(col(II) ,lin(II) ,"r");
		rectangle('Position',[col(II), lin(II), WSIZE, WSIZE], 'LineWidth',3, 'EdgeColor','b');
	end
	hold off

	msgbox ("Points selected");

	col=floor(col);
	lin=floor(lin);

	Pin.set_arrays(lin,col);
end
