# Java-Compiler

This project was created as a part of the Compiler Design Lab in the 6th Semester of my Undergraduate course at Manipal Institute of Technology. This rudimentary compiler for java programs was implemented using bison and flex. 
It has basic error recovery strategy implemented as well, thus missing semicolons in for statements are detected and missing paranthesis are taken care of.


## Installation and Usage
1. Clone this repository 
```
    git clone https://github.com/yashYRS/Java-Compiler
```
2. A few sample files are provided in the `SampleInput` folder for reference. If some new files need to be compiled, add them to the current folder.

3. Build the docker image and give it a custom name. If docker is not installed on your system, instructions to do so can be found [here](https://docs.docker.com/engine/install/ubuntu/)
```
    docker build -t custom_compiler_name .
```
4. Run the Docker image in a interative mode, and give the file to be compiled to the compiler as an argument
```
    # Run the container
    docker run -it custom_compiler_name
    # Run the compiler with file name as argument
    ./run SampleInput/input.java
```



