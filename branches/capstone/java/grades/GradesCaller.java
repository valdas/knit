/* Zach Cowell - zcowell
 CS 110 LAB
 Sept 27, 2007
 Brandi Shafer
 Program: GradesCaller.java
*/

public class GradesCaller {
private int x;  
 
public GradesCaller (int num) {
   num=x;
}
  
  
public String split(int num) { 

  String str;
  
  if (num == 100)
  {
  str = "You recieved a perfect score! Congratulations.";
  }
  else if (num >= 90)
  {
  str = "You recieved a letter grade of A.";
  }
  else if (num >= 80)
  {
  str = "You recieved a letter grade of B.";
  }
  else if (num >= 70)
  {
  str = "You recieved a letter grade of C.";
  } 
  else if (num >= 60)
  {
  str = "You recieved a letter grade of D.";
  }
  else
  {
  str = "You recieved a letter grade of F.";
  }
 
  return str;
}
}