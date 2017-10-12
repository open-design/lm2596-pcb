#!/bin/sh

set -e

BOARD=$1

( \
	cd $BOARD && \
	eeschema $(basename $BOARD).sch \
)
