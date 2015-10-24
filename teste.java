//javac  -classpath . teste.java

import net.trucomanx.pdsplibj.pdspiv.PdsPoints;
import java.awt.Point;

public class teste {
	
	public static void main (String args[]) {
		int L=8;
		
		PdsPoints pts =new PdsPoints(L);
		PdsPoints pts2=new PdsPoints(L);
		Point p;
		
		for(int i=0;i<L;i++)
		{
			p=pts.get_point_from_id(i);
			System.out.println("Point:"+p);
			pts.set_point(i,i-1,i+1);
			System.out.println("Point:"+pts.get_point_from_id(i));
		}
		pts2.set_points(pts);
		System.out.println("Point:\n"+pts2);
		
	}
}
