% Retorna la correlação entre duas regiones WIZE, analiza esta correlacíon hasta
% WSIZE*FACTOR de distacia. Por defeito FACTOR=1.0.
%
% Se escoje una region inicial A0 y se compara con otras imagenes A.
%
% inputs:
% =======
% filename: Imagem a analizar
% Pi0: Ponto a estudar
% WSIZE: Tamanho da região
% FACTOR: Factor de distancia con respecto a WSIZE
%
% outputs:
% ========
% CORR : Correlación de A0 y Ak para todo k
% PX  : Distancia en pixels 
function [CORR C X]=get_multi_spatial_auto_corr(filename,P0,WSIZE,L)

	img  = imread(filename);
    figure;
	imshow(img);

    N=2*L-1;

    hold on
    ac0=round(P0(2));	al0=round(P0(1));

	col=zeros(1,N);
	lin=zeros(1,N);

    CORR=zeros(N,N);
    CX=zeros(1,N*N);
    PX=zeros(1,N*N);


    for JJ=(-(L-1)):(L-1)
    	col(JJ+L)=ac0+JJ;
    	lin(JJ+L)=al0+JJ;
    end

    for KK=1:N
    for JJ=1:N
        if ( (KK==1)||(KK==N) )
        if ( (JJ==1)||(JJ==N) )
    	    scatter(col(KK) ,lin(JJ),'r' );
        end
        end

        if ( (KK==L)&&(JJ==L) )
    	    scatter(col(KK) ,lin(JJ),'r' );
    	    rectangle('Position',[col(KK), lin(JJ), WSIZE, WSIZE], 'LineWidth',1, 'EdgeColor','b');
        end
    end
    refresh();
    end
    hold off

    A0=img(lin(L)+[0:WSIZE-1], col(L)+[0:WSIZE-1]);

    KK=1;
    for JJ=1:N
    for II=1:N
        A=img(lin(II)+[0:WSIZE-1],col(JJ)+[0:WSIZE-1]);	
        % Correlación de A0 con Ak
        CORR(II,JJ)=corr2(A0,A);
        CX(KK)=CORR(II,JJ);
        PX(KK)=sqrt((II-L)^2+(JJ-L)^2);
        KK=KK+1;
    end
    end

    [PX ID]=sort(PX);
    CX=CX(ID);


    X=PX(1);
    C=CX(1);
    XLAST=X;
    for II=2:(N*N)
        if(PX(II)~=XLAST)
            X=[X PX(II)];
            C=[C CX(II)];
            XLAST=PX(II);
        end
    end

end

