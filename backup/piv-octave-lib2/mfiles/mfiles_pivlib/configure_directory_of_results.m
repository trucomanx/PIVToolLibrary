function DIRECTORY_OF_RESULTS=configure_directory_of_results(camino)

	DIRECTORY_OF_RESULTS= uigetdir (camino,'Seleciona a pasta das imagenes de salida');

	while(exist(DIRECTORY_OF_RESULTS,'dir')~=7)
		DIRECTORY_OF_RESULTS= uigetdir (camino,'Seleciona a pasta das imagenes de salida')
	end
	
	DIRECTORY_OF_RESULTS

end
