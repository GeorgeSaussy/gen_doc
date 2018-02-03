## An Example sub_gen_doc.sh
# George Saussy

function contains() {
    local n=$#
    local value=${!n}
    for ((i=1;i < $#;i++)) {
        if [ "${!i}" == "${value}" ]; then
            echo "y"
            return 0
        fi
    }
    echo "n"
    return 1
}

# Create workspace
WORK_DIR=gen_doc_work_$1;
WORK_FILE=$WORK_DIR/cat_file.tex;
mkdir $WORK_DIR;
touch $WORK_FILE;
echo "" > $WORK_FILE;

# Write file contents to PDF

## Initialize TeX document
echo "" >> $WORK_FILE 
echo "\\documentclass[a4paper,10pt]{article}\\usepackage[utf8]{inputenc}\\usepackage{listings}\\title{Source Code}\\author{George Saussy}\\begin{document}\\maketitle" >> $WORK_FILE

## Initialize loop variables
FILE_EXTENTIONS=(c cpp h txt md py rb sh go)
EXEMPT_DIRECTORIES=(scripts $WORK_DIR)
EXEMPT_FILES=(sub_gen_doc.sh)

## Loop over files
for FE in ${FILE_EXTENTIONS[@]}; do 
  for FILE in *.$FE; do
    if [ "$FILE" != "*.$FE" ] && [ $(contains ${EXEMPT_FILES[@]} $FILE) != "y" ]; then
      echo "\\newpage" >> $WORK_FILE;
      echo "\\[$FILE\\]" >> $WORK_FILE;
      echo "\\begin{verbatim}" >> $WORK_FILE;
      cat $FILE | sed -e 's,\\,\\\\,g' | sed -E 's,\$,\\\$,g' | sed -E 's,_,\\textunderscore,g' >> $WORK_FILE;
      echo "\\end{verbatim}" >> $WORK_FILE;
    fi;
  done;
  for FILE in **/*.$FE; do
    CONTINUE=true
    for DIR in ${EXEMPT_DIRECTORIES}; do
      if [ `expr match "$FILE" "$DIR"` == ${#DIR} ]; then
        CONTINUE=false;
      fi;
    done; 
    if [ "$FILE" != "**/*.$FE" ] && [ $(contains ${EXEMPT_FILES[@]} $FILE) != "y" ] && $CONTINUE; then
      echo "\\newpage" >> $WORK_FILE;
      echo "\\[$FILE\\]" >> $WORK_FILE;
      echo "\\begin{verbatim}" >> $WORK_FILE;
      cat $FILE | sed -e 's,\\,\\\\,g' | sed -E 's,\$,\\\$,g' | sed -E 's,_,\\textunderscore,g' >> $WORK_FILE;
      echo "\\end{verbatim}" >> $WORK_FILE;
    fi;
  done;
  for FILE in **/**/*.$FE; do
    CONTINUE=true
    for DIR in ${EXEMPT_DIRECTORIES}; do
      if [ `expr match "$FILE" "$DIR"` == ${#DIR} ]; then
        CONTINUE=false;
      fi;
    done;
    if [ "$FILE" != "**/**/*.$FE" ] && [ $(contains ${EXEMPT_FILES[@]} $FILE) != "y" ] && $CONTINUE; then
      echo "\\newpage" >> $WORK_FILE;
      echo "\\[$FILE\\]" >> $WORK_FILE;
      echo "\\begin{verbatim}" >> $WORK_FILE;
      cat $FILE | sed -e 's,\\,\\\\,g' | sed -E 's,\$,\\\$,g' | sed -E 's,_,\\textunderscore,g' >> $WORK_FILE;
      echo "\\end{verbatim}" >> $WORK_FILE;
    fi;
  done;
done;

echo "\\end{document}" >> $WORK_FILE

## Compile Source LaTeX
cd $WORK_DIR;
pdflatex -interaction nonstopmode cat_file.tex;
cd ..;

# Move work to current directory
cp $WORK_DIR/cat_file.pdf ./gen_doc_$1.pdf

# Clean up
rm -rf html;
rm -rf latex;
rm -rf $WORK_DIR;
