#!/usr/bin/env bash
# Reimporta classes .as editadas de volta num .swf, gerando um novo .swf customizado.
# import_folder deve conter "scripts/..." espelhando o pacote das classes editadas.
# Uso: ./recompile.sh <ffdec_dir> <in_swf> <out_swf> <import_folder>
set -euo pipefail

FFDEC_DIR="${1:?uso: recompile.sh <ffdec_dir> <in_swf> <out_swf> <import_folder>}"
IN_SWF="${2:?}"
OUT_SWF="${3:?}"
IMPORT_FOLDER="${4:?}"

if [ ! -f "$FFDEC_DIR/ffdec.jar" ]; then
    echo "Nao encontrei ffdec.jar em $FFDEC_DIR (ver docs/SETUP.md)" >&2
    exit 1
fi

echo "Recompilando $IN_SWF + $IMPORT_FOLDER -> $OUT_SWF ..."
java -Xmx4g -jar "$FFDEC_DIR/ffdec.jar" -onerror ignore -air -importScript "$IN_SWF" "$OUT_SWF" "$IMPORT_FOLDER"

if [ -f "$OUT_SWF" ]; then
    echo "OK: $OUT_SWF gerado."
else
    echo "Algo falhou, o arquivo de saida nao foi criado. Veja o log acima." >&2
    exit 1
fi
