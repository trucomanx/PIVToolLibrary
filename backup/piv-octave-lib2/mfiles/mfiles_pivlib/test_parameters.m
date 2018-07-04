function  test_parameters(DIRECTORY_OF_IMAGES,DIRECTORY_OF_RESULTS,FORMATNAME,DATAFILE)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    [Pin Nl Nc]=select_horizontal_initial_grid_points(DIRECTORY_OF_IMAGES,FORMATNAME,DATAFILE);


	D=load(DATAFILE);
    if isfield (D, 'D')
        D=D.D;
    end
    D.pinput=[Pin.get_array_from_value0()';Pin.get_array_from_value1()'];
    save(DATAFILE,'D');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    FILENAME_OF_FIRST_IMAGE = fullfile(DIRECTORY_OF_IMAGES,sprintf(FORMATNAME,D.number_of_first_image));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for II=0:(Pin.get_length()-1)
        P0=Pin.get_array_from_id(II);
        X0=[0:(D.window_size-1)];

        disp('Calculando spatial corr....');
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %[CORRA1 SEA1 MEANA1 STDA1] = get_spatial_auto_corr(FILENAME_OF_FIRST_IMAGE,P0,D.window_size,96/D.window_size);
disp('OK');
        %figure;
        %plot(X0,CORRA1(1:length(X0)),'-o');
        %xlabel('Distance in pixels');
        %xlim([min(X0) max(X0)])
        %ylim([0.0 1.0])
        %ylabel('PCC');
        %grid
		%print([DIRECTORY_OF_RESULTS,filesep,'PCC-Point',num2str(II),'-des.png'],'-dpng');
		%save( [DIRECTORY_OF_RESULTS,filesep,'PCC-Point',num2str(II),'-des.dat'],'CORRA1','-ascii');


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        MINANGLE=0.5;
        N=20;
        X0=[0:(N-1)]*MINANGLE;
disp('Calculando angular corr....');
        %[CORRA2] = get_rot_auto_corr(FILENAME_OF_FIRST_IMAGE,P0,D.window_size,N,MINANGLE);
disp('OK');
        %figure;
        %plot(X0,CORRA2,'-o');
        %xlabel('Angle in degrees');
        %xlim([min(X0) max(X0)])
        %ylim([0.0 1.0])
        %ylabel('PCC');
        %grid
		%print([DIRECTORY_OF_RESULTS,filesep,'PCC-Point',num2str(II),'-rot.png'],'-dpng');
		%save( [DIRECTORY_OF_RESULTS,filesep,'PCC-Point',num2str(II),'-rot.dat'],'CORRA2','-ascii');

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% ANGLE=[0:(N-1)]*MINANGLE;
        %%% [CORR SE MEAN STD]=get_rot_spatial_auto_corr(FILENAME_OF_FIRST_IMAGE,P0,D.window_size,ANGLE,96/D.window_size);
        %%% figure;
        %%% [X,Y] = meshgrid([0:(size(CORR,2)-1)],ANGLE);
        %%% surf(X,Y,CORR)
        %%% ylabel('Angle (degrees)');
        %%% xlabel('Pixels');
        %%% zlim([-0.2 1.0])
        %%% zlabel('PCC');

		%%% print([DIRECTORY_OF_RESULTS,filesep,'PCC-Point',num2str(II),'-all.png'],'-dpng');
		%%% save( [DIRECTORY_OF_RESULTS,filesep,'PCC-Point',num2str(II),'-all.dat'],'CORR','-ascii');

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Calculando multi-spatial corr....');
        %[CORR C X] = get_multi_spatial_auto_corr(FILENAME_OF_FIRST_IMAGE,P0,D.window_size,D.search_max_legth);
disp('OK');
        %L=(size(CORR,2)+1)/2;
        %figure;
        %[XX,YY]=meshgrid([-(L-1):(L-1)]);
        %surf(XX,YY,CORR);
        %xlabel('Distance in pixels');
        %ylabel('Distance in pixels');
        %zlim([0.0 1.0])
        %zlabel('PCC');
        %grid
		%print([DIRECTORY_OF_RESULTS,filesep,'PCC-Point',num2str(II),'-multi_des.eps'],'-deps');
		%save( [DIRECTORY_OF_RESULTS,filesep,'PCC-Point',num2str(II),'-multi_des.dat'],'CORR','-ascii');

        %figure;
        %plot(X,C);
        %DAT=[X;C];
        %xlabel('Pixels');
        %ylabel('PCC');
        %ylim([0.0 1.0])
        %grid
		%print([DIRECTORY_OF_RESULTS,filesep,'PCC-Point',num2str(II),'-multi_des_max.png'],'-dpng');
		%save( [DIRECTORY_OF_RESULTS,filesep,'PCC-Point',num2str(II),'-multi_des_max.dat'],'DAT','-ascii');
    end
    

end 
