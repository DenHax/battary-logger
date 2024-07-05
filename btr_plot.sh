#!/bin/bash

scr_dir=$(dirname "$(realpath "$0")")

DATA_FILE="$scr_dir/battery_data.txt"
YEAR_VIEW_DIR="$scr_dir/energ_view/"

if [ ! -f "$DATA_FILE" ]; then
  echo "Ошибка: Файл battery_data.txt не найден."
  exit 1
fi

CURRENT_YEAR=$(date +"%Y")
CURRENT_MONTH=$(date +"%m")
YEAR_VIEW_DIR="${YEAR_VIEW_DIR}${CURRENT_YEAR}"
if [ ! -d "$YEAR_VIEW_DIR" ]; then
  mkdir -p "$YEAR_VIEW_DIR"
fi

DATA=$(cat "$DATA_FILE")

echo "$DATA" | awk '{split($1, date, "-"); print date[3] "-" $2 " " $3}' >"$YEAR_VIEW_DIR/${CURRENT_MONTH}_data.txt"

GNUPLOT_SCRIPT=$(
  cat <<EOF
set terminal pngcairo enhanced font "Arial,10" size 1800,1080
set output "${YEAR_VIEW_DIR}/${CURRENT_MONTH}_view.png"
set xlabel "Дата"
set ylabel "Заряд батареи (%)"
set xdata time
set timefmt "%d-%H:%M"
set format x "%d-%H:%M"
set yrange [0:100]
set ytics 5
set grid xtics ytics linestyle 1
set linestyle 1 lc rgb "#5F5F5F"
plot "${YEAR_VIEW_DIR}/${CURRENT_MONTH}_data.txt" using 1:2:xtic(1) with lines linewidth 4 linecolor "red" title "Заряд батареи"
EOF
)

echo "$GNUPLOT_SCRIPT" | gnuplot

echo "График создан: ${YEAR_VIEW_DIR}/${CURRENT_MONTH}_view.png"
