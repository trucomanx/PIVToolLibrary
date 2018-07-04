function [Pin Nl Nc]=get_initial_grid_points(DATAFILE)
    D=load(DATAFILE);
    if isfield (D, 'D')
        D=D.D;
    end

    Pin=0;
    Nc=D.number_of_points_by_line;
    Nl=D.number_of_points_by_column;

    if isfield (D, 'pinput')
        Pin=javaObject('net.trucomanx.pdsplibj.pdsra.PdsPoints',max(size(D.pinput)));
        Pin.set_arrays(D.pinput(1,:) ,D.pinput(2,:));
    end

end
