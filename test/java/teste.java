//javac  -classpath .:../../lib/pdsplibj.jar teste.java
//java  -classpath .:../../lib/pdsplibj.jar teste
import net.trucomanx.pdsplibj.pdspiv.*;
import net.trucomanx.pdsplibj.pdsra.*;

public class teste {
	
	public static void main (String args[]) {
		// Configuração de dados do match %%%
		PdsPivConf conf=new PdsPivConf();
		PdsPiv     piv =new PdsPiv();
		PdsPivData data;


		conf.set_roi_window_size(64);
		conf.set_search_step_size(2);			
		conf.set_search_max_length(128);		
		conf.set_points_by_columns(10);			
		conf.set_points_by_lines(10);
		conf.set_verbose_flag(true);			

		// Trabalhando com PIV %%%
		piv.load("../../images-data/img1.bmp","../../images-data/img2.bmp");
	
		data=piv.match(conf);


		System.out.println("points1::"+data.initial_points);	
		System.out.println("points2::"+data.final_points);	
		System.out.println("vectors::"+data.vectors);	
		
	}
}
