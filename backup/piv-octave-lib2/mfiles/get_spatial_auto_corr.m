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
% SE   : Valor de la entrobia binaria de las amplitudes de Akpara todo k
% MEAN : Valor medio de las instensidades de Akpara todo k
% STD  : Valor std de las instensidades de Akpara todo k
function [CORR SE MEAN STD]=get_spatial_auto_corr(filename,P0,WSIZE,FACTOR=-1)

	img  = imread(filename);
    figure;
	imshow(img);


    hold on
    ac0=round(P0(2));	al0=round(P0(1));

    acf=ac0+WSIZE;	alf=al0;
    %[acf,alf]=ginput(1);
    %acf=round(acf);	alf=round(alf);

    VEC=round(acf-ac0);
    if VEC>0
        VEC=FACTOR*WSIZE;
    else
        VEC=-FACTOR*WSIZE;
    end


    N=round(abs(VEC));

	col=zeros(1,N);
	lin=zeros(1,N);

    CORR=zeros(1,N);
    SE  =zeros(1,N);
    MEAN=zeros(1,N);
    STD =zeros(1,N);

    for JJ=1:N
    	col(JJ)=ac0+(JJ-1)*VEC/N;
    	lin(JJ)=al0;
    end

    for KK=1:N
    	scatter(col(KK) ,lin(KK),'r' );
        if ( (KK==1)||(KK==N) )
    	    rectangle('Position',[col(KK), lin(KK), WSIZE, WSIZE], 'LineWidth',1, 'EdgeColor','b');
        end
    end
    hold off

    A0=img(lin(1)+[0:WSIZE-1], col(1)+[0:WSIZE-1]);
    for KK=1:N
        A=img(lin(KK)+[0:WSIZE-1],col(KK)+[0:WSIZE-1]);	
        % Correlación de A0 con Ak
        CORR(KK)=corr(reshape(A0,1,size(A0,1)*size(A0,2)),reshape(A,1,size(A,1)*size(A,2)));
        % Mean values de Ak
        MEAN(KK)=mean(reshape(A,1,size(A,1)*size(A,2)));
        % STD values de Ak
        STD(KK)=std(reshape(A,1,size(A,1)*size(A,2)));

        ha=hist(reshape(A,[1 WSIZE*WSIZE]),[0:255]);
        pa=ha/sum(ha);
        SE(KK)=sum(-pa.*log2(pa+eps));
    end

end
