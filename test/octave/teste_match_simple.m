%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Preambulo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear
addpath('mfiles')

debug_java (1)
% Carregando java
javaaddpath ("../../lib/pdsplibj.jar");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%java_matrix_autoconversion (true);

conf   =javaObject("net.trucomanx.pdsplibj.pdspiv.PdsPivConf");
piv    =javaObject("net.trucomanx.pdsplibj.pdspiv.PdsPiv");


	
conf.set_roi_window_size(64);
conf.set_search_step_size(2);			
conf.set_search_max_length(128);		
conf.set_points_by_columns(10);			
conf.set_points_by_lines(10);
conf.set_verbose_flag(1);			


piv.load("../../images-data/img1.bmp","../../images-data/img2.bmp");

data=piv.match(conf);

data.initial_points.toString();
data.final_points.toString();
data.vectors.toString();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Limpieza
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
javarmpath ("../../lib/pdsplibj.jar");
rmpath('mfiles')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

