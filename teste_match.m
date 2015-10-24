% Carregando java
javaaddpath ("pdsplibj.jar");

conf   =javaObject("net.trucomanx.pdsplibj.pdspiv.PdsPivConf");
piv    =javaObject("net.trucomanx.pdsplibj.pdspiv.PdsPiv");
data   =javaObject("net.trucomanx.pdsplibj.pdspiv.PdsPivData",10);


%%% Configuração de dados do match %%%
conf.set_roi_window_size(64);			%%[OK]
conf.set_search_step_size(8);			%%[OK]
conf.set_search_max_length(128);		%%[OK]


%%% Trabalhando com PIV %%%
%piv.load(img1,img2);
b=piv.load("images/img1.bmp","images/img2.bmp")
	
%data=piv.match(conf);

%%% separando os resultados %%%
points1 = data.get_initial_points();	%%[OK]
points2 = data.get_final_points();		%%[OK]
vec1to2 = data.get_vectors();			%%[OK]

%%% Usando os resultados %%%
N =points1.get_length();				%%[OK]

p1=points1.get_point_from_id(0);		%%[OK]
p2=points1.get_point_from_id(1);		%%[OK]
% ...
pN=points1.get_point_from_id(N-1);		%%[OK]

