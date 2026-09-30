#!/usr/bin/env python3
import json
import sys
from pathlib import Path

CODE_HINTS = ('valdistriktskod','valdistriktkod','vd_kod','kod')
GEOM_HINTS = ('coordinates','geometry','polygon','geom','koordinater')

def norm(s):
    return str(s).lower().replace('_','').replace('-','').replace(' ','')

def looks_like_district_record(obj):
    if not isinstance(obj, dict):
        return False
    keys = [norm(k) for k in obj.keys()]
    has_code = any('valdistrikt' in k and 'kod' in k for k in keys) or any(k in ('vd_kod','vdkod') for k in keys)
    has_geom = any(any(h in k for h in GEOM_HINTS) for k in keys)
    return has_code or has_geom

def candidate_lists(obj, path='root'):
    out=[]
    if isinstance(obj, list):
        if obj and isinstance(obj[0], dict):
            score=sum(looks_like_district_record(x) for x in obj[:min(20,len(obj))])
            out.append((path,len(obj),score,obj[0].keys()))
        for i,x in enumerate(obj[:5]):
            if isinstance(x,(dict,list)):
                out.extend(candidate_lists(x,f'{path}[{i}]'))
    elif isinstance(obj, dict):
        if isinstance(obj.get('features'), list):
            f=obj['features']
            keys=f[0].keys() if f and isinstance(f[0],dict) else []
            out.append((path+'.features',len(f),999,keys))
        for k,v in obj.items():
            if isinstance(v,(dict,list)) and k != 'features':
                out.extend(candidate_lists(v,f'{path}.{k}'))
    return out

total=0
for name in sys.argv[1:]:
    path=Path(name)
    with path.open(encoding='utf-8-sig') as fh:
        data=json.load(fh)
    candidates=candidate_lists(data)
    if not candidates:
        root_desc=list(data.keys())[:30] if isinstance(data,dict) else type(data).__name__
        raise SystemExit(f'{path}: no candidate district list; root={root_desc}')
    candidates.sort(key=lambda x:(x[2],x[1]), reverse=True)
    chosen=candidates[0]
    print(f'{path}: chosen {chosen[0]} count={chosen[1]} score={chosen[2]} keys={list(chosen[3])[:20]}')
    total += chosen[1]

print(total)
