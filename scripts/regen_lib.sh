#!/bin/sh

set -e

qeda reset

qeda add ti/lm2596

qeda add resistor/r0805

qeda add capacitor/cp-d

qeda add tdk/b82477g4

qeda add diodes/b340a

qeda add misc/sp-th-3

qeda generate testlib
