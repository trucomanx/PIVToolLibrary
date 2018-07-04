%N numero de puntos analizados
%MINANGLE de 0 a 360
function [CORR]=get_rot_auto_corr(filename,P0,WSIZE,N,MINANGLE)

	img  = imread(filename);
    figure;
	imshow(img);

    hold on
    ac0=round(P0(2));	al0=round(P0(1));


    CORR=zeros(1,N);

    SEMI_W=round(WSIZE/2);
    SEMI_MW=round(sqrt(2)*WSIZE/2);

    ac0=ac0+SEMI_W;
    al0=al0+SEMI_W;

    scatter(ac0 , al0,"r");
    rectangle('Position',[ac0-SEMI_W+1 , al0-SEMI_W+1, 2*SEMI_W, 2*SEMI_W], 'LineWidth',1, 'EdgeColor','b');
    rectangle('Position',[ac0-SEMI_MW+1 , al0-SEMI_MW+1, 2*SEMI_MW, 2*SEMI_MW], 'LineWidth',1, 'EdgeColor','g');


    LINES   = (al0-SEMI_MW+1):(al0+SEMI_MW);
    COLUMNS = (ac0-SEMI_MW+1):(ac0+SEMI_MW);

    MA0=img(LINES,COLUMNS);
    A0 =MA0(SEMI_MW-SEMI_W+[1:WSIZE],SEMI_MW-SEMI_W+[1:WSIZE]);

    for KK=1:N
        MA = imrotate(MA0,(KK-1)*MINANGLE,'bilinear','crop');
        A  = MA(SEMI_MW-SEMI_W+[1:WSIZE],SEMI_MW-SEMI_W+[1:WSIZE]);

        CORR(KK)=corr2(A,A0);
    end
    hold off

end
