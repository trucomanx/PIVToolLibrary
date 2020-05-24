%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Preambulo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pkg load image
close all;  clear;
page_screen_output(0);
page_output_immediately(1);
addpath(genpath(make_absolute_filename('mfiles')));
graphics_toolkit('qt')
%graphics_toolkit('gnuplot')

debug_java (true); % Carregando java
javaaddpath (make_absolute_filename('lib/pdsplibj.jar'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

DIRECTORY_OF_IMAGES  = configure_directory_of_images('tests');
DIRECTORY_OF_RESULTS = fullfile(DIRECTORY_OF_IMAGES,'out');     %configure_directory_of_results(DIRECTORY_OF_IMAGES);
FORMATNAME           = '8 Bit-100%02d.bmp';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


mkdir(DIRECTORY_OF_RESULTS);

conf   =javaObject('net.trucomanx.pdsplibj.pdspiv.PdsPivConf');
piv    =javaObject('net.trucomanx.pdsplibj.pdspiv.PdsPiv');


%%% Testando dados do match 

    DIRECTORY_OF_RESULTS_MATCH=fullfile(DIRECTORY_OF_RESULTS,'match');
    mkdir(DIRECTORY_OF_RESULTS_MATCH);
    close all

    %%% Configuração de dados do match 
    [NUM_OF_FIRST NUM_OF_LAST FATOR_MM_PX]=configure_piv_values(conf);

    FILENAME_OF_FIRST_IMAGE = fullfile(DIRECTORY_OF_IMAGES,sprintf(FORMATNAME,NUM_OF_FIRST));

    %%% Configuração dos pontos iniciais
    [Pin Nl Nc ]=get_initial_match_points(FILENAME_OF_FIRST_IMAGE,conf);
    if (Nc==0)||(Nl==0)
        error('NO POINTS FOUND');
    end

    KK=1;
    Pout{KK}=Pin;
    print(fullfile(DIRECTORY_OF_RESULTS_MATCH,'match_grid_rois.png'),'-dpng');

    STEP=1;
    for II=(NUM_OF_FIRST+STEP):NUM_OF_LAST

    	FILENAME1= fullfile(DIRECTORY_OF_IMAGES,sprintf(FORMATNAME,II-STEP));
    	FILENAME2= fullfile(DIRECTORY_OF_IMAGES,sprintf(FORMATNAME,II     ));
    
    	piv.load(FILENAME1,FILENAME2);
    	KK=KK+1;
        disp(['calculando tracking:',num2str(II-STEP),'-',num2str(II)]);

    	Pout{KK}=piv.tracking_points(Pout{KK-1},conf);
    	disp('OK');
    
    	close all
    	%plot_rectangle_in_image(FILENAME1,Pout{KK-1},conf);
    	%print([DIRECTORY_OF_RESULTS_MATCH,filesep,num2str(II-STEP),'.png'],'-dpng','-tight');
    	%Pout{JJ}.toString()
    
    	Pin=Pout{KK};
    end
    disp('End.    Plot ...')
    %graphics_toolkit('gnuplot')

    %Poutmean=average_distance_traveled(Pout,Nl,Nc);
    plot_displacement_in_image(FILENAME2,Pout);
    print([DIRECTORY_OF_RESULTS_MATCH,filesep,'endroute.png'],'-dpng');
    plot_displacement_color_in_image(FILENAME_OF_FIRST_IMAGE,Pout,conf);
    print([DIRECTORY_OF_RESULTS_MATCH,filesep,'endroute_color.png'],'-dpng');

    save_data_groups_in_directory(DIRECTORY_OF_RESULTS_MATCH,Nc,Nl,FATOR_MM_PX,Pout);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Limpieza
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
javarmpath(make_absolute_filename('lib/pdsplibj.jar'));
rmpath(genpath(make_absolute_filename('mfiles')));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

