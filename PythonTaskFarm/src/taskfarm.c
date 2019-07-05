#include<stdio.h>
#include<stdlib.h>
#include<mpi.h>
#include<string.h>
#include<errno.h>
#ifdef PYTHON3
#include<python3.5m/Python.h>
#include<python3.5m/pythonrun.h>
#else
#include<python2.7/Python.h>
#include<python2.7/pythonrun.h>
#endif

#define TRUE 1
#define FALSE 0
#define MASTER 0
#define MAXLENGTHRANK 10
#define MAXPROGRAMLENGTH 1000000

int read_python_source_file(FILE *, char *, int);
int open_python_source_file(FILE **, char *, int);
int parse_arguments(int, char **, char **, char ***, int);
void itoa(int, char *, int);
void reverse(char *);
char * trim(char *);
void deallocate_char_array(char***, int);

int main(int argc, char *argv[]){
  int i, errorcode;
  int rank, size;
  FILE *file;
  char *filename;
  char *programstring;
  char **newargv;

  errorcode = TRUE;

  MPI_Init(&argc, &argv);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  MPI_Comm_size(MPI_COMM_WORLD, &size);

  // Process the command line arguments passed to this program.  The main 
  // thing done here is removing the first argument (which is always the program 
  // name in C) and adding the MPI rank as a new argument at the end. 
  if(parse_arguments(argc, argv, &filename, &newargv, rank) == FALSE){
    if(rank == MASTER){
      printf("Exiting application\n");
    }
    MPI_Finalize();
    exit(1);
  }

  programstring = malloc(sizeof(char)*MAXPROGRAMLENGTH);

  // Setup python
  // Pickup the python executable from the command line. 
  // This is necessary to ensure that this will work with virtualenv and things like it.
#ifdef PYTHON3
  wchar_t *programname = Py_DecodeLocale("python", NULL);
  Py_SetProgramName(programname);
#else
  Py_SetProgramName("python");
#endif
  Py_Initialize();
 
#ifdef PYTHON3
  wchar_t** python3argv = PyMem_Malloc(sizeof(wchar_t*)*argc);
  for (int i=0; i<argc; i++) {
  wchar_t* arg = Py_DecodeLocale(newargv[i], NULL);
    python3argv[i] = arg;
  }
  PySys_SetArgv(argc, python3argv);
#else
 // Set the command line arguments for python.
  PySys_SetArgv(argc, newargv);
#endif

  // Read in the python program on the master process
  if(rank == MASTER){
    if(open_python_source_file(&file, filename, rank) == FALSE){
	printf("Exiting application\n");
	errorcode = FALSE;
    }else{
      if(read_python_source_file(file, programstring, rank) == FALSE){
      	printf("Exiting application\n");
      	errorcode = FALSE;
      }
    }
  }
	
  // Pass any error code (i.e. the master couldn't read in the python program) to all programs.
  MPI_Bcast(&errorcode, 1, MPI_INT, MASTER, MPI_COMM_WORLD);
  // If there has been an error on the master then cancel the program.
  if(errorcode == FALSE){
    MPI_Finalize();
    exit(1);
  }

  // Broadcast the python program string to all processes
  MPI_Bcast(programstring, MAXPROGRAMLENGTH, MPI_CHAR, MASTER, MPI_COMM_WORLD);

  if(rank == MASTER){
    printf("Running python code (%s) on %d cores\n", argv[1], size);
  }

  PyRun_SimpleString(programstring);

  Py_Finalize();

  MPI_Finalize();

#ifdef PYTHON3
  free(python3argv);
#endif
  free(programstring);

  deallocate_char_array(&newargv, argc);

  exit(0);


}

int read_python_source_file(FILE *file, char *programstring, int rank){

  int i = 0;
  char c;

  while((c = fgetc(file)) != EOF){
     programstring[i] = c;
     i++;
     if(i >= MAXPROGRAMLENGTH){
       printf("Python file larger than internal buffer (which is %d characters long)\n", MAXPROGRAMLENGTH);
       return FALSE;
     }  
  }
  return TRUE;
}


int open_python_source_file(FILE **file, char *filename, int rank){

  *file = fopen(trim(filename), "rb");

  if(file == NULL){
    printf("Error opening python file.  Error number: %d\n",errno);
    return FALSE;
  }

  return TRUE;


}


int parse_arguments(int argc, char *argv[], char **filename, char ***newargv, int rank){

  int i, j;
  char rank_string[MAXLENGTHRANK];

  if(argc < 2){
    if(rank == MASTER){
      printf("Expected a different number of arguments, got %d but expected at least 1 (the name of the python file to run).\n",argc-1);
    }
    return FALSE;
  }

  *(filename) = argv[1];

  *(newargv) =  malloc(sizeof(char *)*argc);

  // Copy the arguments passed to a new data set, but remove the name of this executable so when the arguments 
  // are passed to python it takes the name of the python script as the first argument.
  for(i=0; i<argc-1; i++){
    (*newargv)[i] = malloc(sizeof(char)*strlen(argv[i+1]));
    for(j=0; j<strlen(argv[i+1])+1; j++){
      (*newargv)[i][j] = argv[i+1][j];
    }
  }
  // Convert the MPI rank into a string (character array) and add it as the last argument passed to python
  // MPI ranks are rebased to 1->size rather than 0->size-1. If you don't want that remove the +1 from the 
  // rank below
  itoa(rank+1, rank_string, MAXLENGTHRANK);
  (*newargv)[argc-1] = malloc(sizeof(char)*(strlen(rank_string)+1));
  for(i=0; i<strlen(rank_string)+1; i++){
    (*newargv)[argc-1][i] = rank_string[i];
  }

  return TRUE;

}


void itoa(int n, char s[], int maxlength){
  int i, sign;
  
  if ((sign = n) < 0){
    n = -n; 
  }
  
  i = 0;
  
  do {    
    s[i++] = n % 10 + '0';
  } while ((n /= 10) > 0 && i < maxlength);
  
  if(i == maxlength){
    printf("Error: converting string to number has run out of storage\n");
    return;
  }
  
  if (sign < 0){
    s[i++] = '-';
  }
  
  s[i] = '\0';
  
  reverse(s);
}

void reverse(char s[]){
  int i, j;
  char c;
  
  for (i = 0, j = strlen(s)-1; i<j; i++, j--) {
    c = s[i];
    s[i] = s[j];
    s[j] = c;
  }
}

char *trim(char *str){
  
  size_t len = 0;
  char *frontp = str - 1;
  char *endp = NULL;
  
  if(str == NULL){
    return NULL;
  }

  if(str[0] == '\0'){
    return str;
  }  

  len = strlen(str);
  endp = str + len;

  /* Move the front and back pointers to address
   * the first non-whitespace characters from
   * each end.
   */
  while( isspace(*(++frontp)) );
  while( isspace(*(--endp)) && endp != frontp);
  
  if(str + len - 1 != endp){
    *(endp + 1) = '\0';
  }else if( frontp != str &&  endp == frontp){
    *str = '\0';
  }
  
  /* Shift the string so that it starts at str so
   * that if it's dynamically allocated, we can
   * still free it on the returned pointer.  Note
   * the reuse of endp to mean the front of the
   * string buffer now.
   */
  endp = str;
  if(frontp != str){
    while( *frontp ) *endp++ = *frontp++;
    *endp = '\0';
  }
 
  return str;
}


void deallocate_char_array(char ***arr, int n){

  int i;

  for(i = 0; i < n; i++){
    free((*arr)[i]);
  }
  free(*arr); 
}
