#!/bin/sh

set -e

patch_pcb()
{
	BOARD="$1"
	WRL="$2"
	AT="$3"
	SCALE="$4"
	ROTATE="$5"

	cat > $WRL.patch <<EOF
    (model $WRL
      (at (xyz $AT))
      (scale (xyz $SCALE))
      (rotate (xyz $ROTATE))
    )
EOF
	sed -i -ne "/    (model $WRL/ { r $WRL.patch" -e ':a; n; /    )/ {b}; ba}; p' $BOARD
	rm -rf $WRL.patch
}

for PCB in boards/*/*.kicad_pcb; do

	patch_pcb $PCB CAPC2013X140N.wrl \
		"0 0 0" "1 1 1" "0 0 90"
	patch_pcb $PCB LEDC2013X65N.wrl \
		"0 0 0" "1 1 1" "0 0 -90"

done
