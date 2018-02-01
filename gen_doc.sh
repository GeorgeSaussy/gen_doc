#!/bin/bash


WORK_DIR=gen_doc_work

mkdir $WORK_DIR
cp title.pdf $WORK_DIR/ongoing.pdf

for FILE in */; do
  if [ "$FILE" != "old/" ] && [ "$FILE" != "misc/" ] && [ "$FILE" != "gen_doc_work/" ]; then
    cd $FILE;
    ./sub_gen_doc.sh ${FILE:0:(-1)};
    cp gen_doc_${FILE:0:(-1)}.pdf ../gen_doc_work/${FILE:0:(-1)}.pdf;
    cd ..;
  fi;
done;

for FILE in */; do
  if [ "$FILE" != "old/" ] && [ "$FILE" != "misc/" ] && [ "$FILE" != "gen_doc_work/" ]; then
    qpdf --empty --pages $WORK_DIR/ongoing.pdf 1-z $WORK_DIR/${FILE:0:(-1)}.pdf 1-z -- $WORK_DIR/new.pdf
    mv $WORK_DIR/new.pdf $WORK_DIR/ongoing.pdf
  fi;
done;

cp $WORK_DIR/ongoing.pdf Documentation.pdf
rm -rf $WORK_DIR
