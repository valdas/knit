/*@author Zach Cowell - zcowell
 Program: Replacement.java
*/

import java.util.*;
import java.io.PrintWriter;
import java.io.FileReader;

public class Palindrome{
  public static void main(String args[]) throws Exception{
    
    Scanner in = new Scanner(System.in);
    System.out.println("Enter the name of the file to use: ");
    String pally = in.nextLine();
    ArrayList<String> list = new ArrayList<String>();
  
    pally = pally.trim();
    pally = pally.toLowerCase();
    pally = pally.superTrim;
    
    
    
    while(scr.hasNextLine()){
      String str = scr.nextLine();
      list.add(str);
    }
    

     for(int i = 0; i < list.length(); i++)
     {
       if (list.get(i).equals("{"))
        list.replace("{","BEGIN");
       else if (list.get(i).equals("}"))
        list.replace("}","END");
     }
  
  
   for(int i = 0; i < list.size(); i++)
     System.out.println(list.get(i)); 

  
  }}

    
