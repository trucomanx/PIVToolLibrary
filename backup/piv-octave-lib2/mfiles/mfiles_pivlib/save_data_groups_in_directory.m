function save_data_groups_in_directory(DIRECTORY,Nc,Nl,FATOR_MM_PX,Pout)
	%% Nc : Numero de sectores analizados.
	%% Nl : Numero de copias por sectores.

	N=length(Pout);					%% Numero d iteraciones
	Npoints=Pout{1}.get_length();	%% Numero de puntos en las iteraciones = Nc * Nl


	for KK=0:(Nc-1)

		lin=zeros(1,N);
		col=zeros(1,N);
		lin0=0;
		col0=0;
		for II=0:(Nl-1)
			[lint colt lint0 colt0]=normalize_in_relation_to_first(Pout,KK*Nl+II);
			lin=lin+lint;
			col=col+colt;
			lin0=lin0+lint0;
			col0=col0+colt0;
		end
		lin=lin/Nl;
		col=col/Nl;
		lin0=lin0/Nl;
		col0=col0/Nl;

        figure;
		print_and_save(DIRECTORY,KK,'lin',lin,FATOR_MM_PX);
        figure;
		print_and_save(DIRECTORY,KK,'col',col,FATOR_MM_PX);
	end

end

%% retona a linha e columna no tempo, do KK essimo ponto, 
%% referenciado ao primeiro de modo que o primeiro valor de lin e col é zeros
%% a função retorna o verdadero primeiro valor de lin e col
function [lin col lin0 col0]=normalize_in_relation_to_first(Pout,KK)
	% Ponto K-esimo no tempo 0
	lin0=Pout{1}.get_point_from_id(KK).getX();
	col0=Pout{1}.get_point_from_id(KK).getY();

	N=length(Pout);					%% Numero de iteraciones

	lin=zeros(1,N);
	col=zeros(1,N);

	for II=1:N
		if size(Pout{II}.get_point_from_id(KK),1)==1
			lin(II)=Pout{II}.get_point_from_id(KK).getX()-lin0;
			col(II)=Pout{II}.get_point_from_id(KK).getY()-col0;
		else
			lin(II)=NaN;
			col(II)=NaN;
		end
	end
end


%%
%%
function print_and_save(DIRECTORY,KK,TEXT,VAR,FATOR_MM_PX)
		FILEDATCOL=[DIRECTORY,filesep,'Point',num2str(KK),'-',TEXT,'.dat'];
		FILEPNGCOL=[DIRECTORY,filesep,'Point',num2str(KK),'-',TEXT,'.png'];
		N=length(VAR);
		VARIABLE=VAR*FATOR_MM_PX;
		plot([0:(N-1)],VARIABLE,'-s');
        xlim([0 (N-1)]);
		xlabel('Sample time');
		ylabel('Dislocation');
		print(FILEPNGCOL,'-dpng','-tight');
		save( FILEDATCOL,'VARIABLE','-ascii');
end
