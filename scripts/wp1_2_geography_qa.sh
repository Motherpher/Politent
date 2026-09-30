#!/usr/bin/env bash
set -euo pipefail

WORK="${1:-/tmp/politent-wp1_2}"
mkdir -p "$WORK"

DESO2018='https://geodata.scb.se/geoserver/stat/wfs?REQUEST=GetFeature&TYPENAMES=stat%3ADeSO_2018&outputFormat=geopackage&service=WFS&version=1.1.0'
DESO2025='https://geodata.scb.se/geoserver/stat/wfs?REQUEST=GetFeature&TYPENAMES=stat%3ADeSO_2025&outputFormat=geopackage&service=WFS&version=1.1.0'
VAL2026='https://www.val.se/download/18.332cf48819bd61ac1513889/1785491689960/valdistrikt-riket-2026.zip'
VALCMP='https://www.val.se/download/18.1a2972da19f159e73fd3a47/1787064655347/valdistrikt-jamforelser-mellan-2022-och-2026.xlsx'

curl -L --fail --retry 3 "$DESO2018" -o "$WORK/deso_2018.gpkg"
curl -L --fail --retry 3 "$DESO2025" -o "$WORK/deso_2025.gpkg"
curl -L --fail --retry 3 "$VAL2026" -o "$WORK/valdistrikt_2026.zip"
curl -L --fail --retry 3 "$VALCMP" -o "$WORK/valdistrikt_compare_2022_2026.xlsx"

feature_count() {
  ogrinfo -ro -al -so "$1" 2>/dev/null | awk -F": " '/Feature Count:/ {sum += $2} END {print sum+0}'
}

c18="$(feature_count "$WORK/deso_2018.gpkg")"
c25="$(feature_count "$WORK/deso_2025.gpkg")"

echo "DeSO 2018 detected features: $c18"
echo "DeSO 2025 detected features: $c25"
test "$c18" = "5984"
test "$c25" = "6160"

rm -rf "$WORK/val2026"
mkdir -p "$WORK/val2026"
unzip -q "$WORK/valdistrikt_2026.zip" -d "$WORK/val2026"
echo "Election Authority ZIP contents:"
find "$WORK/val2026" -maxdepth 3 -type f -printf "%P\n" | head -50

mapfile -d '' val_json_files < <(find "$WORK/val2026" -type f \( -iname '*.json' -o -iname '*.geojson' \) -print0)
json_files="${#val_json_files[@]}"
echo "Election Authority GIS JSON/GeoJSON file count: $json_files"
if [[ "$json_files" -eq 0 ]]; then
  echo "No JSON/GeoJSON files detected in Election Authority GIS ZIP" >&2
  exit 1
fi

counter_output="$(python3 scripts/count_valdistrict_json.py "${val_json_files[@]}")"
echo "$counter_output"
val_count="$(echo "$counter_output" | tail -n 1)"

echo "Valdistrikt 2026 detected features: $val_count in $json_files JSON file(s)"
test "$val_count" = "6312"

python3 scripts/parse_valdistrict_crosswalk.py \
  "$WORK/valdistrikt_compare_2022_2026.xlsx" \
  "$WORK/valdistrikt_compare_2022_2026.csv"

test "$(wc -l < "$WORK/valdistrikt_compare_2022_2026.csv")" -gt 1000

echo "WP1.2 geography source QA: PASS"
echo "DeSO 2018 features: $c18"
echo "DeSO 2025 features: $c25"
echo "Valdistrikt 2026 features: $val_count in $json_files JSON file(s)"
