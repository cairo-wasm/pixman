#!/bin/bash
set -e
OUT_DIR="$(pwd)"
ROOT_DIR=${OUT_DIR}"/.."

declare -a sources=(
"pixman/pixman.c"
"pixman/pixman-access-accessors.c"
"pixman/pixman-access.c"
"pixman/pixman-arm.c"
"pixman/pixman-arm-neon.c"
"pixman/pixman-arm-simd.c"
"pixman/pixman-bits-image.c"
"pixman/pixman-combine32.c"
"pixman/pixman-combine-float.c"
"pixman/pixman-conical-gradient.c"
"pixman/pixman-edge-accessors.c"
"pixman/pixman-edge.c"
"pixman/pixman-fast-path.c"
"pixman/pixman-filter.c"
"pixman/pixman-general.c"
"pixman/pixman-glyph.c"
"pixman/pixman-gradient-walker.c"
"pixman/pixman-image.c"
"pixman/pixman-implementation.c"
"pixman/pixman-linear-gradient.c"
"pixman/pixman-matrix.c"
"pixman/pixman-mips.c"
"pixman/pixman-mips-dspr2.c"
"pixman/pixman-mmx.c"
"pixman/pixman-noop.c"
"pixman/pixman-ppc.c"
"pixman/pixman-radial-gradient.c"
"pixman/pixman-region16.c"
"pixman/pixman-region32.c"
"pixman/pixman-solid-fill.c"
"pixman/pixman-timer.c"
"pixman/pixman-trap.c"
"pixman/pixman-utils.c"
"pixman/pixman-x86.c"
)

results=""

for src in "${sources[@]}"
do
  result=${OUT_DIR}/$(basename ${src} .c)'.bc'
  if [ ! -f ${result} ]; then
    emcc -O3 -D HAVE_CONFIG_H -o ${result} -c -I ${ROOT_DIR} -I ${ROOT_DIR}/pixman ${ROOT_DIR}/${src}
    echo ${src} '->' ${result}
  fi
  results=${results}" "${result}
done

rm -f ${OUT_DIR}/libpixman.a
emar r ${OUT_DIR}/libpixman.a $results
