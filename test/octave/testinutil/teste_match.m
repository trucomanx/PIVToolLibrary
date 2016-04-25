% Carregando java
javarmpath ("../../lib/pdsplibj.jar");
javaaddpath ("../../lib/pdsplibj.jar");
%java_matrix_autoconversion (true);

conf   =javaObject("net.trucomanx.pdsplibj.pdspiv.PdsPivConf");
piv    =javaObject("net.trucomanx.pdsplibj.pdspiv.PdsPiv");

%%% Configuração de dados do match %%%
conf.set_roi_window_size(50);			
conf.set_search_step_size(4);
conf.set_search_max_length(100);

conf.set_search_threshold(0.8);
		
conf.set_points_by_columns(8);			
conf.set_points_by_lines(6);
			
conf.set_verbose_flag(1);


%%% Trabalhando com PIV %%%
piv.load("images/img1.bmp","images/img2.bmp");
	
data=piv.match(conf);

%%% separando os resultados %%%
points1 = data.get_initial_points();	
points2 = data.get_final_points();		
vec1to2 = data.get_vectors();			

im2  = imread("images/img2.bmp");
figure(2);
imshow(im2);

lins =points1.get_array_from_value0();	cols =points1.get_array_from_value1();
lins2=points2.get_array_from_value0();	cols2=points2.get_array_from_value1();
dlins=vec1to2.get_array_from_value0();	dcols=vec1to2.get_array_from_value1();

valid_ids=find(isnan(dlins)==0);

lins = lins(valid_ids);		cols = cols(valid_ids);
lins2= lins2(valid_ids);	cols2= cols2(valid_ids);
dlins= dlins(valid_ids);	dcols= dcols(valid_ids);


hold on;
quiver(cols,lins,dcols,dlins,'AutoScale','off');
scatter(cols,lins,"g");
scatter(cols2,lins2,"r");
hold off;


