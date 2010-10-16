/* Zach Cowell - zcowell
 CS 110 LAB
 Dec 6, 2007
 Brandi Shafer
 Program: Matrix.java
*/



import java.io.*;
import java.util.*;

public class Matrix {
    public static void main (String [] args){
      FileOutputStream out; // declare a file output object
      PrintStream p; // declare a print stream object

                try
                {
                        // Create a new file output stream
                        // connected to "myfile.txt"
                        out = new FileOutputStream("outfile");
                        // Connect print stream to the output stream
                        p = new PrintStream( out );
   int[][] board,board2;
   Scanner in = new Scanner(System.in);
   System.out.println("Please input the size of your matrix:");
   int size = in.nextInt();
   int ROWS = size;
   int COLUMNS = size;
      
   board = new int[ROWS][COLUMNS];
   board2 = new int[ROWS][COLUMNS];
  
   System.out.println();
      for (int i = 0; i < ROWS; i++){
        for (int j = 0; j < COLUMNS; j++){
          System.out.println("Please enter element "+ i+"," +j +" of the first matrix."); 
          board[i][j] = in.nextInt();
        }}
      
         for (int i = 0; i < ROWS; i++){
        for (int j = 0; j < COLUMNS; j++){
          System.out.println("Please enter element "+i+"," +j + " of the second matrix."); 
          board2[i][j] = in.nextInt();
        }}   
  System.out.println();
    for (int i = 0; i < ROWS; i++){
      p.println();
        for (int j = 0; j < COLUMNS; j++){
          p.print(board[i][j] + board2[i][j] + " "); 
             
        }}   
   
                        p.close();    
 }
                catch (Exception e)
                {
                        System.err.println ("Error writing to file");
                }
 
    }}
