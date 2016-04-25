%
clear
addpath('mfiles')

debug_java (1)
% Carregando java
javaaddpath ("../../lib/pdsplibj.jar");

%java_matrix_autoconversion (true);

DIRECTORY_OF_IMAGES  = configure_directory_of_images('');
DIRECTORY_OF_RESULTS = configure_directory_of_results(DIRECTORY_OF_IMAGES);

conf   =javaObject("net.trucomanx.pdsplibj.pdspiv.PdsPivConf");
piv    =javaObject("net.trucomanx.pdsplibj.pdspiv.PdsPiv");


%%% Configuração de dados do match %%%
[NUM_OF_FIRST NUM_OF_LAST FATOR_MM_PX]=configure_piv_values(conf);

FILENAME_OF_FIRST_IMAGE = [DIRECTORY_OF_IMAGES,filesep,num2str(NUM_OF_FIRST),'.bmp'];

[Pin Nl Nc]=select_initial_grid_points(FILENAME_OF_FIRST_IMAGE,conf);

Pout{1}=Pin;
plot_rectangle_in_image(FILENAME_OF_FIRST_IMAGE,Pout{1},conf);
print([DIRECTORY_OF_RESULTS,filesep,num2str(1),'.png'],'-dpng');

STEP=1;
for II=(NUM_OF_FIRST+STEP):NUM_OF_LAST

	
	FILENAME1= [DIRECTORY_OF_IMAGES,filesep,num2str(II-STEP),'.bmp'];
	FILENAME2= [DIRECTORY_OF_IMAGES,filesep,num2str(II  ),'.bmp'];

	piv.load(	FILENAME1,FILENAME2);

	disp(['calculando tracking:',num2str(II-STEP),'-',num2str(II)]);
	Pout{II}=piv.tracking_points(Pin,conf);

	plot_rectangle_in_image(FILENAME2,Pout{II},conf);
	print([DIRECTORY_OF_RESULTS,filesep,num2str(II),'.png'],'-dpng');
	%Pout{JJ}.toString()

	Pin=Pout{II};
end

%Poutmean=average_distance_traveled(Pout,Nl,Nc);
plot_points_in_image(FILENAME2,Pout);
print([DIRECTORY_OF_RESULTS,filesep,'endroute.png'],'-dpng');

save_data_in_directory(DIRECTORY_OF_RESULTS,Pout);

javarmpath ("../../lib/pdsplibj.jar");
rmpath('mfiles')

