function DIRECTORY_OF_IMAGES=configure_directory_of_images(camino)
	if(exist(camino,'dir')~=7)
	if(exist('.trash_conf_file','file'))
		camino=load('.trash_conf_file');
		camino=camino.DIRECTORY_OF_IMAGES;
	end
	end

	
	DIRECTORY_OF_IMAGES= uigetdir (camino,'Seleciona a pasta das imagenes de entrada');		

	while(exist(DIRECTORY_OF_IMAGES,'dir')~=7)
		DIRECTORY_OF_IMAGES= uigetdir (camino,'Seleciona a pasta das imagenes de entrada');
	end

	DIRECTORY_OF_IMAGES

	save('.trash_conf_file','DIRECTORY_OF_IMAGES');
end
