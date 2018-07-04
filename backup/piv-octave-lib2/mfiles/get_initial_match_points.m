function [Pin Nl Nc WSIZE]=get_initial_match_points(FILENAME_OF_FIRST_IMAGE,conf)

    Nl=3;
    Nc=20;
    WSIZE=conf.get_roi_window_size();
    hdip=0;



	prompt1 = {'Number of points by line:','Number of points by column:', 'Window size:'};
	defin1  = {num2str(Nl)	,num2str(Nc),num2str(WSIZE)};
	dlg_title = 'Select points';
	num_lines = 1;
	
	answer = inputdlg(prompt1,dlg_title,num_lines,defin1);

	Nl=str2num(answer{1});
	Nc=str2num(answer{2});
	WSIZE=str2num(answer{3});
    conf.set_roi_window_size(WSIZE);

	N=Nc*Nl

	Pin    =javaObject("net.trucomanx.pdsplibj.pdsra.PdsPoints",N);

	img  = imread(FILENAME_OF_FIRST_IMAGE);
	hf=figure;	
	imshow(img);

    NLIN=size(img,1);
    NCOL=size(img,2);

	col=zeros(1,2);
	lin=zeros(1,2);
	for II=1:2
		hold on

		[ac,al]=ginput(1);
		ac=round(ac);	al=round(al);

		col(II)=ac;
		lin(II)=al;

        if(col(II)<1)
            col(II)=1;
        end
        if(col(II)>NCOL)
            col(II)=NCOL;
        end
        if(lin(II)<1)
            lin(II)=1;
        end
        if(lin(II)>NLIN)
            lin(II)=NLIN;
        end
	
		scatter(col(II) ,lin(II) ,"r");

		hold off

	end

	col=floor(sort(col));
	lin=floor(sort(lin));

    hold on
    rectangle('Position',[col(1), lin(1), col(2)-col(1), lin(2)-lin(1)], 'LineWidth',3, 'EdgeColor','b');
    hold off

	msgbox ("Points selected");

    DELTAL=floor((lin(2)-lin(1)-WSIZE)/(Nl-1));
    DELTAC=floor((col(2)-col(1)-WSIZE)/(Nc-1));
    
	pcol=zeros(1,N);
	plin=zeros(1,N);
    II=1;
    for LL=1:Nl
    for CC=1:Nc
        plin(II)=floor(lin(1)+(LL-1)*DELTAL);
        pcol(II)=floor(col(1)+(CC-1)*DELTAC);
        II=II+1;
    end
    end

	Pin.set_arrays(plin,pcol);

	for II=1:N
		%hold on
		%scatter(pcol(II) ,plin(II) ,"g");
		%hold off
        hold on
        rectangle('Position',[pcol(II), plin(II), WSIZE, WSIZE], 'LineWidth',3, 'EdgeColor','g');
        hold off
	end

end
