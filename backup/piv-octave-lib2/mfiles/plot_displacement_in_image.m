function plot_displacement_in_image(filename,P)

	N=length(P);

	

	img  = imread(filename);
	figure;	imshow(img);
	
	hold on;


		lins =P{1}.get_array_from_value0();	
		cols =P{1}.get_array_from_value1();
		scatter(cols ,lins ,"r");

		lins2=P{N}.get_array_from_value0();	
		cols2=P{N}.get_array_from_value1();
		scatter(cols2,lins2,"r");

		deltacol=cols2-cols;
		deltalin=lins2-lins;
		quiver(cols,lins,deltacol,deltalin,'AutoScale','off');

	hold off;

end

