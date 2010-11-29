/* Zach Cowell - zcowell
 CS 110 LAB
 Oct 11th
 Brandi Shafer
 Program: GPA.java
*/
import java.io.*;
import java.util.*;
public class Gpa{
  public static void main(String [] args){
    Scanner in = new Scanner(System.in);
    FileOutputStream out;
    PrintStream p;
   try{
		out = new FileOutputStream("tests/tmp/outfile");
		p = new PrintStream (out);
		System.out.print("Input your grade values (0-100, negative number terminates): ");
		int theGrade = in.nextInt();
		double i =0; double value = 0;
		System.out.println();
		
		while (theGrade >= 0)
		{
		  if (theGrade >= 0){
			if (theGrade >=90)
			  value = 4+value;
			else if (theGrade >=80)
			  value = 3+value;
			else if (theGrade >=70)
			  value = 2+value;
			else if (theGrade>=60)
			  value = 1+value;
			else
			  value = 0 + value;
			i=i+1;
		  }
		 theGrade = in.nextInt();
		}
		double gpa = value / i;
		p.print("Your GPA is : " +gpa);
		p.close();
 }
 catch (Exception e){
 System.err.println("ERROR WRITING TO FILE"); 
 } 
}
}

