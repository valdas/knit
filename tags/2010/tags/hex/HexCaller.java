/* Zach Cowell - zcowell
 CS 110 LAB
 Sept 20, 2007
 Brandi Shafer
 Program: HexCaller.java
*/

public class HexCaller {
 private String letter;  
 
public HexCaller (String lett_in) {
   letter=lett_in;
}
  
  
public int converter(String lett_in) { 
  int num;
  
  if (lett_in == "0")
  {
    num = 0;
  }
  else if (lett_in == "1")
  {
    num = 1;
  }
  else if (lett_in == "2")
  {
    num = 2;
  }
  else if (lett_in == "3")
  {
    num = 3;
  }
  else if (lett_in == "4")
  {
    num = 4;
  }
  else if (lett_in == "5")
  {
    num = 5;
  }
  else if (lett_in == "6")
  {
    num = 6;
  }
  else if (lett_in == "7")
  {
    num = 7;
  }
  else if (lett_in == "8")
  {
    num = 8;
  }
  else if (lett_in == "9")
  {
    num = 9;
  }
  
  else if (lett_in == "a")
  {
  num = 10;
  }
  else if (lett_in == "b")
  {
    num = 11;
  }
  else if (lett_in == "c")
  {
    num = 12;
  }
  else if (lett_in == "d")
  {
    num = 13;
  }
  else if (lett_in == "e")
  {
    num = 14;
  }
  else 
  {
    num = 15;
  }
  return num;
 }
}