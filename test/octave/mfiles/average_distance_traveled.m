function [Pmean]=average_distance_traveled(P,Nl,Nc)

	N=length(P);

	lins =P{1}.get_array_from_value0();	
	cols =P{1}.get_array_from_value1();
	Pdelta{1}=javaObject("net.trucomanx.pdsplibj.pdsra.PdsPoints",Nc*Nl);	

	for II=2:N
		lins2=P{II}.get_array_from_value0();	
		cols2=P{II}.get_array_from_value1();
		Pdelta{II}=javaObject("net.trucomanx.pdsplibj.pdsra.PdsPoints",Nc*Nl);

		Pdelta{II}.set_arrays(lins2-lins,cols2-cols);
	end

	for II=1:N
		Pmean{II}=javaObject("net.trucomanx.pdsplibj.pdsra.PdsPoints",Nc);
		for JJ=1:Nc
			Sl=0;	
			Sc=0;
			for KK=1:Nl
				Sl=Sl+Pdelta{II}.get_point_from_id((JJ-1)*Nl+KK-1).getX();
				Sc=Sc+Pdelta{II}.get_point_from_id((JJ-1)*Nl+KK-1).getY();
			end
			Sl=Sl/Nl+lins((JJ-1)*Nl+1);
			Sc=Sc/Nl+cols((JJ-1)*Nl+1);
			Pmean{II}.set_point(JJ-1,Sl,Sc);
		end
	end


end

