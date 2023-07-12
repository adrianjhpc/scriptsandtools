#include <exception>
#include <iostream>
#include <cxxabi.h>

struct empty { };

template <typename T, int N>
  struct bar { };

int main(int argc, char **argv){
  int     status;
  char   *realname;

  if(argc != 2){
    std::cout << "Expecting one argument, the name to demangle" << std::endl;
    return 0;
  }

  realname = abi::__cxa_demangle(argv[1], 0, 0, &status);
  if(realname != NULL){
     std::cout << argv[1] << "\t=> " << realname << "\t: " << status << std::endl;
     std::cout << std::endl;
  }else{
     std::cout << "Failed to demangle " << argv[1] << std::endl;
     if(status == -1){
        std::cout << " status code " << status << " which means memory allocation failure occurred." << std::endl;
     }else if(status == -2){
        std::cout << " status code " << status << " which means the mangled name is not a valid name under the C++ ABI mangling rules." << std::endl;
     }else if(status == -3){
        std::cout << " status code " << status << " which means one of the arguments invalid." << std::endl;
     }else{
       std::cout << " status code " << status << " unknown error." << std::endl;
     }
  }

  free(realname);

  return 0;
}

