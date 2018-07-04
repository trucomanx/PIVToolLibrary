function [NUM_OF_FIRST NUM_OF_LAST FATOR_MM_PX]=configure_piv_values(conf, varargin)

	DATA={32 1 4 100 100 1 96 0.82 1};

	if(nargin>=2)
		D=load(varargin{1});
        if isfield (D, 'D')
            D=D.D;
        end

		DATA{1}=D.window_size;
		DATA{2}=D.number_of_first_image;
		DATA{3}=D.number_of_last_image;
		DATA{4}=D.millimeters;
		DATA{5}=D.pixels;
		DATA{6}=D.search_step_size;
		DATA{7}=D.search_max_legth;
		DATA{8}=D.search_threshold;
		DATA{9}=D.verbose_flag;
	end

	prompt1 = {'Window size:'	,'number of first image:'	,'Number of last image:'};
	defin1  = {num2str(DATA{1})	,num2str(DATA{2})			,num2str(DATA{3})		};

	prompt2 = {'Millimeters/Pixels:'	,'Search step size:'	,'Search max legth:'};
	defin2  = {num2str(DATA{4}*1.0/DATA{5})	,num2str(DATA{6})		,num2str(DATA{7})	};

	prompt3 = {'Search threshold:'	,'Verbose flag'};
	defin3  = {num2str(DATA{8})		,num2str(DATA{9})};

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
