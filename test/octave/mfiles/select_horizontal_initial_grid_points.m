function [Pin Nl Nc]=select_horizontal_initial_grid_points(DIRECTORY_OF_IMAGES,FORMATNAME,DATAFILE)
    Nl=1;
    hdip=0;

	D=load(DATAFILE);
    if isfield (D, 'D')
        D=D.D;
    end


	prompt1 = {'Number of points by line:'          ,'Window size:'};
	defin1  = {num2str(D.number_of_points_by_line)	,num2str(D.window_size)};
	dlg_title = 'Select points';
	num_lines = 1;
	
	answer = inputdlg(prompt1,dlg_title,num_lines,defin1);

	Nc=str2num(answer{1});
	N=Nc;

	D.window_size=str2num(answer{2});	

	Pin    =javaObject("net.trucomanx.pdsplibj.pdsra.PdsPoints",N);

	col=zeros(1,N);
	lin=zeros(1,N);

    FILENAME_OF_FIRST_IMAGE = fullfile(DIRECTORY_OF_IMAGES,sprintf(FORMATNAME,D.number_of_first_image));

	img  = imread(FILENAME_OF_FIRST_IMAGE);
	hf=figure;	
	imshow(img);

	for II=1:Nc
		hold on

		[ac,al]=ginput(1);
		ac=round(ac);	al=round(al);

		col(II)=ac;
		lin(II)=al;
	
		scatter(col(II) ,lin(II) ,"r");
		rectangle('Position',[col(II), lin(II), D.window_size, D.window_size], 'LineWidth',3, 'EdgeColor','b');

		hold off

	end

	msgbox ("Points selected");

	col=floor(col);
	lin=floor(lin);

	Pin.set_arrays(lin,col);


	D.number_of_points_by_line=Nc;
	D.number_of_points_by_column=Nl;
	D.horizontal_displacement_in_pixels=hdip;

    save(DATAFILE,'D');

end
