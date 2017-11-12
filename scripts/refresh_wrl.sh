#!/bin/sh

set -e

KICAD_LIBS_PATH=$1

if [ ! -d "${KICAD_LIBS_PATH}" ]; then
	echo "Usage:"
	echo "  refresh_wrl.sh <path_to_kicad_libs_dir>"
	exit 1
fi

# https://github.com/KiCad/kicad-library
KICAD_LIBRARY=${KICAD_LIBS_PATH}/kicad-library
# https://github.com/engstad/Walter
WALTER_LIBRARY=${KICAD_LIBS_PATH}/Walter
# https://github.com/metacollin/kicad-gigalib
GIGA_LIBRARY=${KICAD_LIBS_PATH}/kicad-gigalib

SHAPES3D=lib/kicad/testlib.3dshapes
PRETTY=lib/kicad/testlib.pretty

patch_kicad_mod()
{
	NEWWRL="$1"
	NAME="$2"
	WRL="$NAME.wrl"
	PATCH="$NAME.patch"
	KICAD_MOD="$PRETTY/$NAME.kicad_mod"

	AT="$3"
	SCALE="$4"
	ROTATE="$5"

	if [ ! -e ${SHAPES3D}/${WRL} ]; then
		echo "error: ${SHAPES3D}/${WRL} does not exist"
		exit 1
	fi

	cp ${NEWWRL} ${SHAPES3D}/${WRL}

	cat > $PATCH <<EOF
  (model $WRL
    (at (xyz $AT))
    (scale (xyz $SCALE))
    (rotate (xyz $ROTATE))
  )
EOF
	sed -i -ne "/  (model $WRL/ { r $PATCH" -e ':a; n; /  )/ {b}; ba}; p' $KICAD_MOD
	rm -f $PATCH
}

patch_kicad_mod ${KICAD_LIBRARY}/modules/packages3d/TO_SOT_Packages_SMD.3dshapes/TO-263-5_TabPin6.wrl \
	TO170P1023X864X465-5N "0 0 0" "1 1 1" "0 0 0"
patch_kicad_mod ${KICAD_LIBRARY}/modules/packages3d/Diodes_SMD.3dshapes/D_SMA.wrl \
	DIOM4326X290N "0 0 0" "1 1 1" "0 0 90"
patch_kicad_mod ${KICAD_LIBRARY}/modules/packages3d/Inductors_SMD.3dshapes/L_12x12mm_h8mm.wrl \
	INDM128128X800N "0 0 0" "3.937 3.937 3.937" "0 0 90"
patch_kicad_mod ${KICAD_LIBRARY}/modules/packages3d/Resistors_SMD.3dshapes/R_0805.wrl \
	RESC2013X65N "0 0 0" "1 1 1" "0 0 90"
patch_kicad_mod ${KICAD_LIBRARY}/modules/packages3d/Capacitors_SMD.3dshapes/CP_Elec_6.3x7.7.wrl \
	CAPPM7343X310N "0 0 0" "1 1 1" "0 0 -90"

patch_kicad_mod ${WALTER_LIBRARY}/packages3d/walter/pth_resistors/rc05.wrl \
	RESISTOR_R-CF-25 "0 0 0" "1 1 1" "0 0 90"
patch_kicad_mod ${WALTER_LIBRARY}/packages3d/walter/pth_resistors/trimmer_diplohm_p94.wrl \
	BOURNS_3296 "0 0 0" "1 1 1" "0 0 0"
