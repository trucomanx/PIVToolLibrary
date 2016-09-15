function [Pin Nl Nc]=select_initial_grid_points(filename,conf,varargin)

	DATA=[3 5 10];

	if(nargin>=3)
		DirWithData=varargin{1};
		FileWithData=varargin{2};
		D=load([DirWithData,filesep,FileWithData]);
		DATA(1)=D.number_of_points_by_line;
		DATA(2)=D.number_of_points_by_column;
		DATA(3)=D.horizontal_displacement_in_pixels;
	end

	WSIZE=conf.get_roi_window_size();	

	prompt1 = {'Number of points by line:'	,'Number of points by column:'	,'Horizontal displacement in pixels:'};
	defin1  = {num2str(DATA(1))				,num2str(DATA(2))				,num2str(DATA(3))};
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
	hf=figure;	
	imshow(img);

	for II=1:Nc
		hold on

		[ac,al]=ginput(1);
		ac=round(ac);	al=round(al);

		L=str2num(answer{3});

		for JJ=1:Nl
			col((II-1)*Nl+JJ)=ac+round(L*randn(1));
			lin((II-1)*Nl+JJ)=al;%+round(L*randn(1));
		end

		for KK=((II-1)*Nl+[1:Nl])
			scatter(col(KK) ,lin(KK) ,"r");
			rectangle('Position',[col(KK), lin(KK), WSIZE, WSIZE], 'LineWidth',3, 'EdgeColor','b');
		end
		hold off

	end

	msgbox ("Points selected");

	col=floor(col);
	lin=floor(lin);

	Pin.set_arrays(lin,col);
end
