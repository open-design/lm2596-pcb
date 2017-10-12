#!/bin/sh

set -e

usage()
{
	echo "Usage:"
	echo "  edit_pcb.sh <kicad project dir>"
}

BOARD=$1
if [ -z "$1" ]; then
	usage
	exit 1
fi

KICAD_PCB=$(basename $BOARD).kicad_pcb

if [ ! -e $BOARD/$KICAD_PCB ]; then
	echo "no $BOARD/$KICAD_PCB file"
	echo
	usage
	exit 1
fi

( \
	export KISYS3DMOD=$(pwd)/lib/kicad/testlib.3dshapes/ && \
	cd $BOARD/ && \
	pcbnew $KICAD_PCB \
)
