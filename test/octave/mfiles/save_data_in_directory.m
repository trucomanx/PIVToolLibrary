function save_data_in_directory(DIRECTORY,Pout)

	N=length(Pout);
	Npoints=Pout{1}.get_length();



	for KK=0:(Npoints-1)
		lin0=Pout{1}.get_point_from_id(KK).getX();
		col0=Pout{1}.get_point_from_id(KK).getY();

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

		save( [DIRECTORY,filesep,'Point',num2str(KK),'-pos','.dat'],'lin0','col0','-ascii');

		plot([0:(N-1)],lin,'-s');
		xlabel('Sample time');
		ylabel('Dislocation');
		print([DIRECTORY,filesep,'Point',num2str(KK),'-lin','.png'],'-dpng');
		save( [DIRECTORY,filesep,'Point',num2str(KK),'-lin','.dat'],'lin','-ascii');

		plot([0:(N-1)],col,'-s');
		xlabel('Sample time');
		ylabel('Dislocation');
		print([DIRECTORY,filesep,'Point',num2str(KK),'-col','.png'],'-dpng');
		save( [DIRECTORY,filesep,'Point',num2str(KK),'-col','.dat'],'col','-ascii');
	end

end
