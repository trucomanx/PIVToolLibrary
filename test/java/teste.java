//javac  -classpath .:pdsplibj.jar teste.java
//java  -classpath .:pdsplibj.jar teste
import net.trucomanx.pdsplibj.pdspiv.*;
import java.awt.Point;

public class teste {
	
	public static void main (String args[]) {
		// Configuração de dados do match %%%
		PdsPivConf conf=new PdsPivConf();
		PdsPiv     piv =new PdsPiv();
		PdsPivData data;
		PdsPoints points1;
		PdsPoints points2;
		PdsPoints vec1to2;

		double[] lins;
		double[] dlins;
		double[] cols;
		double[] dcols;

		conf.set_roi_window_size(64);
		conf.set_search_step_size(8);			
		conf.set_search_max_length(128);		
		conf.set_points_by_columns(10);			
		conf.set_points_by_lines(10);
		conf.set_verbose_flag(1);			

		// Trabalhando com PIV %%%
		piv.load("images/img1.bmp","images/img2.bmp");
	
		data=piv.match(conf);

		points1 = data.get_initial_points();
		points2 = data.get_final_points();
		vec1to2 = data.get_vectors();

		lins=points1.get_array_from_value0();
		cols=points1.get_array_from_value1();

		dlins=vec1to2.get_array_from_value0();
		dcols=vec1to2.get_array_from_value1();
		
	}
}
