# Silva Vision — Compatibility and Conflict Matrix

## Ownership model

| Layer | Owns | Must avoid duplicating |
|---|---|---|
| Citizen/world data | Engine-side world behavior | ReShade-only compensation |
| visualsettings.dat | Global visual/lighting parameters | duplicate packs overwriting the same file |
| timecycle/weather | Weather/time-of-day state | multiple resources fighting for the same modifier |
| water data | Water surface/wave behavior | unrelated reflection hacks |
| ReShade | Screen-space post-processing | fixing world parameters that belong in engine data |
| ENB | Optional advanced rendering layer | duplicating ReShade effects without a reason |

## High-risk overlap

- `visualsettings.dat`
- `timecycle_mods_*.xml`
- `w_*.xml`
- `weather.xml`
- `water.xml`
- HBAO/SSAO configuration
- lens artifacts / lens flare
- ReShade depth effects
- ENB/ReShade bloom and exposure

## Resolution strategy

1. Identify which package owns the file.
2. Preserve the native filename when required.
3. Back up before replacement.
4. Merge only when format and ownership are understood.
5. Never combine two complete visual packs blindly.
6. Prefer one authoritative owner for each engine-side file.

## Server-side consideration

A FiveM server can run resources that modify weather/timecycle behavior. Client-side graphics should therefore avoid assuming that it controls every world state.

## Release gate

A file is not considered release-ready merely because it loads. It must have a known target, known owner, rollback path and documented conflict surface.
