#!/usr/bin/env bash
# Decompila o HabboAir.swf inteiro para uma arvore de codigo-fonte .as legivel, usando o JPEXS (ffdec).
# Uso: ./decompile.sh <ffdec_dir> <swf_path> <out_dir>
set -euo pipefail

FFDEC_DIR="${1:?uso: decompile.sh <ffdec_dir> <swf_path> <out_dir>}"
SWF_PATH="${2:?}"
OUT_DIR="${3:?}"

if [ ! -f "$FFDEC_DIR/ffdec.jar" ]; then
    echo "Nao encontrei ffdec.jar em $FFDEC_DIR (ver docs/SETUP.md)" >&2
    exit 1
fi

echo "Decompilando $SWF_PATH -> $OUT_DIR (isso demora uns 10-15 minutos)..."
java -Xmx4g -jar "$FFDEC_DIR/ffdec.jar" -onerror ignore -export script "$OUT_DIR" "$SWF_PATH"
echo "Concluido. Classes .as em: $OUT_DIR/scripts"
