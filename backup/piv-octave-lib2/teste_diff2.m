%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Preambulo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pkg load image
close all;  clear;
page_screen_output(0);
page_output_immediately(1);
addpath(genpath(make_absolute_filename('mfiles')));
graphics_toolkit('qt')

debug_java (1); % Carregando java
javaaddpath (make_absolute_filename('lib/pdsplibj.jar'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

DIRECTORY_OF_IMAGES  = configure_directory_of_images('tests');
DIRECTORY_OF_RESULTS = fullfile(DIRECTORY_OF_IMAGES,'out');     %configure_directory_of_results(DIRECTORY_OF_IMAGES);
FORMATNAME           = '8 Bit-100%02d.bmp';

DATAFILE             = fullfile(DIRECTORY_OF_IMAGES,'datos.dat');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


mkdir(DIRECTORY_OF_RESULTS);

conf   =javaObject('net.trucomanx.pdsplibj.pdspiv.PdsPivConf');
piv    =javaObject('net.trucomanx.pdsplibj.pdspiv.PdsPiv');


%%% Testando dados do match 

%do
    close all
    test_parameters(DIRECTORY_OF_IMAGES,DIRECTORY_OF_RESULTS,FORMATNAME,DATAFILE);
    disp('parametros testados');
    %btn = questdlg ('Do you need select again the points?', 'Question', 'yes', 'no','no');
%until(strcmp(btn,'no')==1)
graphics_toolkit('qt')
for JJ=1:1

    DIRECTORY_OF_RESULTS2=fullfile(DIRECTORY_OF_RESULTS,['out' num2str(JJ)]);
    mkdir(DIRECTORY_OF_RESULTS2);
    close all

    %%% Configuração dos pontos iniciais
    [Pin Nl Nc]=get_initial_grid_points(DATAFILE);
    if (Nc==0)||(Nl==0)
        error('NO POINTS FOUND');
        %[Pin Nl Nc]=select_horizontal_initial_grid_points(DIRECTORY_OF_IMAGES,FORMATNAME,DATAFILE);
    end



    %%% Configuração de dados do match 
    [NUM_OF_FIRST NUM_OF_LAST FATOR_MM_PX]=configure_piv_values(conf,DATAFILE);

    FILENAME_OF_FIRST_IMAGE = fullfile(DIRECTORY_OF_IMAGES,sprintf(FORMATNAME,NUM_OF_FIRST));

    KK=1;
    Pout{KK}=Pin;
    %plot_rectangle_in_image(FILENAME_OF_FIRST_IMAGE,Pout{1},conf);
    %display_entropy_of_roi(FILENAME_OF_FIRST_IMAGE,Pout{1},conf);
    %print([DIRECTORY_OF_RESULTS2,filesep,num2str(1),'.png'],'-dpng');

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
    	%print([DIRECTORY_OF_RESULTS2,filesep,num2str(II-STEP),'.png'],'-dpng','-tight');
    	%Pout{JJ}.toString()
    
    	Pin=Pout{KK};
    end
disp('End.    Plot ...')
graphics_toolkit('gnuplot')

    %Poutmean=average_distance_traveled(Pout,Nl,Nc);
    plot_points_in_image(FILENAME2,Pout);
    print([DIRECTORY_OF_RESULTS2,filesep,'endroute.png'],'-dpng');


    save_data_groups_in_directory(DIRECTORY_OF_RESULTS2,Nc,Nl,FATOR_MM_PX,Pout);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Limpieza
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
javarmpath(make_absolute_filename('lib/pdsplibj.jar'));
rmpath(genpath(make_absolute_filename('mfiles')));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

