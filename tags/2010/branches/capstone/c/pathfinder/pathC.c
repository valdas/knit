#include <stdio.h>

char array[50][50]={0};  
int M, N;

int found= 0;
int entX, entY;
int extX, extY;

void printMaze();
void getArray();
void findEntrance();
int traverseMaze(int row, int col);

main()
{
	getArray();	
	printMaze();
	findEntrance();
	traverseMaze(entX, entY);
	printMaze();
	
	if (found == 1)
		printf("A path to the exit was found.\n");
	else
		printf("No path was found.\n");
}    


void findEntrance(){
	int entrance_found = 0;
	int i, j;
		for (i=0; i<M; i++){
			for (j=0; j < N; j++){
				if ( (array[i][j] == '0')  && (( (i ==0) || (i == M-1) ) || ((j == 0) || (j == N-1 ))) ){
					if (entrance_found == 0){
						entrance_found = 1;
						entX = i;
						entY = j;
					}
					else{ //Exit is found, we mark it down
						extX = i;
						extY = j;
					}
				}
			}
		}
}

void printMaze(){
	int i, j;
	for (i=0; i<M; i++)
	   for (j=0; j<N; j++)  {
	    if (j == 0) printf("\n");                
	    printf("%c  ",array[i][j]);
	   }
	   printf("\n\n");
}


int traverseMaze(int row, int col){ 
   if (row >= 0 && col >= 0 && row <= M && col <= N){ //Checks for bounds
     if ( (array[row][col] != '1') && (array[row][col] != 'X')){ //Checks for walls / visited spaces
        if ( (row == extX) && (col == extY) ){ //Checks if we are at the end of our maze; if we are, we mark it with an X and acknowledge that we found our exit
        found = 1;
	array[row][col] = 'X';
     return 1;
   }
     else {
       array[row][col] = 'X';
         if ( (traverseMaze(row+1, col) == 1) || (traverseMaze(row, col+1)==1) || (traverseMaze(row-1, col)==1) || (traverseMaze(row, col-1)==1)) {  
                array[row][col] = 'X';  //As long as there is one vistable piece of path, our recursive function can continue until all possibilities are exhausted (or we reach the exit)
                return 1;        
         }
        }
     }
    
   }
 return -1;
 }


void getArray(){
	char c;
	char file_name[20];
	int i, j;
	FILE *fptr;
	printf("What is the dimensions of the array? Please enter in the format rows,columns\n");
	scanf("%d, %d", &M, &N);
	printf("Type in the name of the file containing the Field\n");
	scanf("%s",file_name);
	  
	fptr=fopen(file_name,"r");
	 for (i=0; i<M; i++)
	   for (j=0; j<N; j++){
	     c=fgetc(fptr);
	     while ( !((c == '1')||(c =='0')) && (c!=EOF) ){ 		
		c=fgetc(fptr);
		}
		array[i][j]=c;
	   }
	   fclose(fptr);
   }
   
   
   
   
   