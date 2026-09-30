#!/usr/bin/env python3
import csv
import re
import sys
from pathlib import Path
from openpyxl import load_workbook

def norm(value):
    if value is None:
        return ""
    s = str(value).strip().lower()
    s = s.replace("å","a").replace("ä","a").replace("ö","o")
    return re.sub(r"[^a-z0-9]+","",s)

def find_col(headers, candidates):
    normalized = {norm(h): i for i,h in enumerate(headers)}
    for cand in candidates:
        nc = norm(cand)
        if nc in normalized:
            return normalized[nc]
    for key, idx in normalized.items():
        if any(norm(c) in key or key in norm(c) for c in candidates):
            return idx
    return None

src = Path(sys.argv[1])
dst = Path(sys.argv[2])
wb = load_workbook(src, read_only=True, data_only=True)

sheet = None
header_row = None
headers = None
for ws in wb.worksheets:
    for rownum, row in enumerate(ws.iter_rows(min_row=1, max_row=min(ws.max_row, 30), values_only=True), start=1):
        vals = ["" if v is None else str(v) for v in row]
        joined = " ".join(norm(v) for v in vals)
        if "2026" in joined and ("valdistrikt" in joined or "kod" in joined):
            sheet = ws
            header_row = rownum
            headers = vals
            break
    if sheet:
        break

if sheet is None:
    raise SystemExit("Could not locate comparison data header")

mapping = {
    "target_code_2026": find_col(headers, ["Valdistriktets kod 2026","Valdistriktskod 2026","Kod 2026"]),
    "target_name_2026": find_col(headers, ["Valdistriktets namn 2026","Valdistriktsnamn 2026","Valdistrikt 2026"]),
    "municipality": find_col(headers, ["Kommun"]),
    "county": find_col(headers, ["Län","Lan"]),
    "comparability": find_col(headers, ["Jämförbarhet","Jamforbarhet"]),
    "source_code_2022_1": find_col(headers, ["Valdistriktskod 1 2022","Valdistriktskod 2022","Kod 1 2022"]),
    "source_code_2022_2": find_col(headers, ["Valdistriktskod 2 2022","Kod 2 2022"]),
}
required = ["target_code_2026","comparability","source_code_2022_1"]
missing = [k for k in required if mapping[k] is None]
if missing:
    raise SystemExit(f"Missing required columns: {missing}; headers={headers}")

dst.parent.mkdir(parents=True, exist_ok=True)
count = 0
with dst.open("w", newline="", encoding="utf-8") as fh:
    writer = csv.DictWriter(fh, fieldnames=list(mapping))
    writer.writeheader()
    for row in sheet.iter_rows(min_row=header_row+1, values_only=True):
        record = {}
        for key, idx in mapping.items():
            record[key] = "" if idx is None or idx >= len(row) or row[idx] is None else str(row[idx]).strip()
        if not record["target_code_2026"]:
            continue
        writer.writerow(record)
        count += 1

if count == 0:
    raise SystemExit("No comparison rows parsed")

print(f"Parsed {count} polling-district comparison rows -> {dst}")
