function [CORR SE MEAN STD]=get_rot_spatial_auto_corr(filename,P0,WSIZE,ANGLE,FACTOR=-1)

	img  = imread(filename);
    figure;
	imshow(img);

    M=length(ANGLE);

    hold on
    ac0=round(P0(2));	al0=round(P0(1));


    N=round(abs(FACTOR*WSIZE));

	col=zeros(1,N);
	lin=zeros(1,N);

    CORR=zeros(M,N);
    SE  =zeros(M,N);
    MEAN=zeros(M,N);
    STD =zeros(M,N);

    for JJ=1:N
    	col(JJ)=ac0+(JJ-1);
    	lin(JJ)=al0;
    end

    for KK=1:N
    	scatter(col(KK) ,lin(KK),'r' );
        if ( (KK==1)||(KK==N) )
    	    rectangle('Position',[col(KK), lin(KK), WSIZE, WSIZE], 'LineWidth',1, 'EdgeColor','b');
        end
    end
    hold off


    SEMI_W=round(WSIZE/2);
    SEMI_MW=round(sqrt(2)*WSIZE/2);



    A0=img(lin(1)+[0:(WSIZE-1)], col(1)+[0:(WSIZE-1)]);

    for JJ=1:M    
    for KK=1:N

        center_lin=lin(KK)+SEMI_W;
        center_col=col(KK)+SEMI_W;

        LINES   = (center_lin-SEMI_MW):(center_lin+SEMI_MW);
        COLUMNS = (center_col-SEMI_MW):(center_col+SEMI_MW);
        MA0     = img(LINES,COLUMNS);	

        MA      = imrotate(MA0,ANGLE(JJ),'bilinear','crop');
        A       = MA(SEMI_MW-SEMI_W+1+[0:(WSIZE-1)],SEMI_MW-SEMI_W+1+[0:(WSIZE-1)]);

        % Correlación de A0 con Ak
        CORR(JJ,KK)=corr2(A0,A);
        % Mean values de Ak
        MEAN(JJ,KK)=mean2(A);
        % STD values de Ak
        STD(JJ,KK)=std2(A);

        ha=hist(reshape(A,[1 WSIZE*WSIZE]),[0:255]);
        pa=ha/sum(ha);
        SE(JJ,KK)=sum(-pa.*log2(pa+eps));
    end

end
