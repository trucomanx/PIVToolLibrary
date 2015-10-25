% Carregando java
javaaddpath ("pdsplibj.jar");

conf   =javaObject("net.trucomanx.pdsplibj.pdspiv.PdsPivConf");
piv    =javaObject("net.trucomanx.pdsplibj.pdspiv.PdsPiv");

%%% Configuração de dados do match %%%
conf.set_roi_window_size(50);			%%[OK]
conf.set_search_step_size(2);			%%[OK]
conf.set_search_max_length(100);		%%[OK]
conf.set_points_by_columns(8);			%%[OK]
conf.set_points_by_lines(6);			%%[OK]
conf.set_verbose_flag(1);

%%% Trabalhando com PIV %%%
piv.load("images/img1.bmp","images/img2.bmp");
	
data=piv.match(conf);

%%% separando os resultados %%%
points1 = data.get_initial_points();	%%[OK]
points2 = data.get_final_points();		%%[OK]
vec1to2 = data.get_vectors();			%%[OK]

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


H=piv.get_image_height();
W=piv.get_image_width();
[lins';cols']
[lins2';cols2']

hold on;
%axis([0 W 0 H]); axis([0 W-1 0 H-1]); quiver(cols,lins,dcols,dlins);
axis([0 W 0 H]); scatter(cols,lins,"g");
axis([0 W 0 H]); scatter(cols2,lins2,"r");
%axis([0 W 0 H]); quiver(cols(1:4),lins(1:4),dcols(1:4),dlins(1:4),"y");
hold off;


