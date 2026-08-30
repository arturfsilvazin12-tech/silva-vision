# Silva Vision — Advanced Engineering System

## 1. Visual Parameter Registry

Every tunable parameter should eventually have:

- `id`
- display name
- layer (`citizen`, `visualsettings`, `timecycle`, `reshade`, `enb`, environment)
- default value
- Silva Vision value
- safe range
- weather scope
- day/night scope
- expected visual effect
- estimated performance cost
- conflict notes
- rollback path

This prevents random tuning and makes the project maintainable.

## 2. Weather Matrix

The weather system will be evaluated as a matrix rather than independent presets.

| State | Exposure | Sky | Atmosphere | Surface | Lighting |
|---|---|---|---|---|---|
| Clear | neutral | clear | low haze | dry | natural |
| Sunny | neutral/high | bright | low haze | dry | strong sun |
| Cloudy | slightly reduced | diffuse | medium | dry | soft |
| Overcast | reduced | dense | medium/high | dry | soft/cool |
| Rain | controlled | dark/diffuse | high | wet | reflective |
| Thunder | dynamic | storm | high | wet | dramatic |
| Fog | controlled | muted | very high | damp | diffuse |

Exact numeric values will only be introduced after testing against the target base files.

## 3. Lighting Temperature Matrix

| Source | Intended character |
|---|---|
| Street lamp | warm urban |
| Headlight | neutral white |
| Brake light | saturated red, controlled clipping |
| Police/emergency | preserve distinct signal colors |
| Neon | source hue preserved |
| Vehicle interior | warm/neutral variation |
| Building windows | mixed warm/neutral |

The objective is believable contrast between light sources, not a single global tint.

## 4. Performance Cost Matrix

Effects will be classified as:

- `LOW`: negligible or very small cost
- `MEDIUM`: measurable cost; acceptable in Balanced/High
- `HIGH`: reserve for Ultra/Cinematic
- `VARIABLE`: cost depends on resolution, depth buffer, scene complexity or implementation

A future benchmark should capture average FPS, 1% low FPS, frametime, VRAM and GPU utilization for each profile.

## 5. A/B methodology

For every major visual change:

1. Establish stock/baseline values.
2. Change one subsystem at a time when possible.
3. Record the expected visual effect.
4. Record conflicts and side effects.
5. Keep the best version as a named revision.
6. Document rollback.

This is deliberately slower than random tweaking but produces a reproducible graphics pack.

## 6. Compatibility matrix

Release notes should identify:

- FiveM build/date when relevant
- GTA edition/base
- ReShade version used during validation
- resolution
- render/upscaling mode
- optional ENB/Special K layer
- known UI or injection conflicts

## 7. Release architecture

The final project should distinguish:

- `Core`: required visual configuration
- `ReShade`: optional post-processing
- `Ultra`: high-cost optional effects
- `Performance`: reduced-cost profile
- `Developer`: tuning/debug materials
- `Docs`: installation, rollback and compatibility

## 8. Future developer toolkit

Investigate a safe live-tuning workflow for visualsettings/timecycle data. The goal is to reduce restart cycles during development. Any third-party reloader must remain a separate optional dependency until its license, security and FiveM compatibility are verified.
