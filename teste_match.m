% Programa de ejemplo

	%% Configuração de dados do match
	conf.set_roi_window_size(64);
	conf.set_search_step_size(8);
	conf.set_search_max_length(128);

	%% Trabalhando com PIV
	piv.load(img1,img2);
	
	data=piv.match(conf);

	%% Usando os resultados
	points1 = data.get_initial_points(); %% .get_final_points()
	vec1to2 = data.get_vectors();

	

