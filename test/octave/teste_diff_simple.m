%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Preambulo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear
addpath('mfiles')

debug_java (true)
% Carregando java
javaaddpath ("../../lib/pdsplibj.jar");

val = java_matrix_autoconversion ()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%java_matrix_autoconversion (true);
IMAGE_FORMAT="img%d.bmp";
DIRECTORY_OF_IMAGES  = configure_directory_of_images('../../images-data');
DIRECTORY_OF_RESULTS = configure_directory_of_results([DIRECTORY_OF_IMAGES,filesep,'out']);

conf   =javaObject("net.trucomanx.pdsplibj.pdspiv.PdsPivConf");
piv    =javaObject("net.trucomanx.pdsplibj.pdspiv.PdsPiv");


%%% Configuração de dados do match 
[NUM_OF_FIRST NUM_OF_LAST FATOR_MM_PX]=configure_piv_values(conf);

%%% Configuração dos pontos iniciais
[Pin Nl Nc FILENAME_OF_FIRST_IMAGE]=select_initial_grid_points(DIRECTORY_OF_IMAGES,IMAGE_FORMAT,NUM_OF_FIRST,conf);

KK=1;
Pout{KK}=Pin;
plot_rectangle_in_image(FILENAME_OF_FIRST_IMAGE,Pout{1},conf);
print([DIRECTORY_OF_RESULTS,filesep,num2str(1),'.png'],'-dpng');

STEP=1;
for II=(NUM_OF_FIRST+STEP):NUM_OF_LAST

	
	FILENAME1= [DIRECTORY_OF_IMAGES,filesep,sprintf(IMAGE_FORMAT,II-STEP)];
	FILENAME2= [DIRECTORY_OF_IMAGES,filesep,sprintf(IMAGE_FORMAT,II     )];

	piv.load(FILENAME1,FILENAME2);

	disp(['calculando tracking:',num2str(II-STEP),'-',num2str(II)]);
	KK=KK+1;
    Pin.toString()
	Pout{KK}=piv.tracking_points(Pin,conf);


	close all
	plot_rectangle_in_image(FILENAME2,Pout{KK},conf);
	print([DIRECTORY_OF_RESULTS,filesep,num2str(II),'.png'],'-dpng');
	%Pout{JJ}.toString()

	Pin=Pout{KK};
end

%Poutmean=average_distance_traveled(Pout,Nl,Nc);
plot_points_in_image(FILENAME2,Pout);
print([DIRECTORY_OF_RESULTS,filesep,'endroute.png'],'-dpng');

save_data_in_directory(DIRECTORY_OF_RESULTS,Pout);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Limpieza
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
javarmpath ("../../lib/pdsplibj.jar");
rmpath('mfiles')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

