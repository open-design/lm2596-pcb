#!/bin/sh

set -e

NEWBOARD=$1

TEMPLATE=lib/board-template

if [ -e $NEWBOARD ]; then
	echo "$NEWBOARD already exists"
	exit 1
fi

mkdir $NEWBOARD

for i in kicad_pcb pro sch; do
	cp $TEMPLATE/$(basename $TEMPLATE).$i $NEWBOARD/$(basename $NEWBOARD).$i
done

cp $TEMPLATE/fp-lib-table $NEWBOARD/
