# README
# DocGen
> script for documenting sets of projects

This script is designed to generate master documentation for multiple projects.


## Installing / Getting started

To run the application, the folder which need to be documented to this dorectory. 
In each folder FOLDERNAME, implement a shell program `sub_gen_doc.sh` so that when that script is run from the directory FOLDERNAME, documentation for the project if built the file `gen_doc_FOLDERNAME.pdf`.  
A simple example of such a script may be 

```shell
  #!/bin/bash
  # sub_gen_doc.sh
  doxygen;
  cd latex;
  pdflatex refman.tex;
  cp refman.tex ../sub_gen_FOLDERNAME.pdf;
  cd ..;
  rm -rf latex/;
  rm -rf html/;
```

This script is appropriate for a project with a Doxyfile in its top level directory.

To run DocGen itself, in the root directory of this repository, run `$ ./doc_gen.sh`.
Master documentation for your projects should then be stored in `./Documentation.pdf`.
You can customize the begining of the generated documentation by replacing `title.pdf`

# Installation

See `doc/INSTALL.md`

# Contributing

See `doc/CONTRIBUTING.md`

# Licence

This is licensed under Apache 2. See `doc/LICENCE.txt`.
