/* Zach Cowell - zcowell
 CS 110 LAB
 Sept 27, 2007
 Brandi Shafer
 Program: Grades.java
*/



import java.util.Scanner;

public class Gpa{
  public static void main(String [] args){
    
    Scanner in = new Scanner(System.in);
    
    System.out.print("Input your grade values (0-100, negative number terminates): ");
    int theGrade = in.nextInt();
    int i = 0;
    value = 0;
    System.out.println();
    while (theGrade > 0)
    {
      theGrade = in.nextInt();
      if (theGrade > 0){
        if (theGrade >=90){
        value = 4 + value;
        }
        else if (theGrade >=80)
        {
        value = 3+value;
        }
        else if (theGrade >=70)
        {
        value = 2+value;
        }
        else if (theGrade>=60)
        {
        value = 1+value;
        }
        else
        {
        value = 0 + value;
        }
        
      i=i+1;
      }
      System.out.println();
    }
    
    double gpa = value / i;
    
    String str = dig1.split(theGrade);
    System.out.println("Your GPA is : " +gpa);
  }
}
