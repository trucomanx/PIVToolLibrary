function [NUM_OF_FIRST NUM_OF_LAST FATOR_MM_PX]=configure_piv_values(conf)

	prompt1 = {'Window size:'	,'number of first image:'	,'Number of last image:'};
	defin1  = {'100'			,'1'						,'15'					};

	prompt2 = {'Millimeters/Pixels:'	,'Search step size:'	,'Search max legth:'};
	defin2  = {'1.0'					,'3'					,'50'				};

	prompt3 = {'Search threshold:'	,'Verbose flag'};
	defin3  = {'0.75'				,'1'};

	dlg_title = 'Configure piv';
	num_lines = 1;
	
	answer = inputdlg([prompt1,prompt2,prompt3],dlg_title,num_lines,[defin1,defin2,defin3]);

	conf.set_roi_window_size(str2num(answer{1}));	
	NUM_OF_FIRST = str2num(answer{2});
	NUM_OF_LAST  = str2num(answer{3});

	FATOR_MM_PX  = str2num(answer{4});
	conf.set_search_step_size(str2num(answer{5}));
	conf.set_search_max_length(str2num(answer{6}));


	conf.set_search_threshold(str2num(answer{7}));
	conf.set_verbose_flag(str2num(answer{8}));
end
