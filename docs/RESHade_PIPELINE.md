# Silva Vision — ReShade Pipeline

## Principle

Use the minimum number of effects necessary to produce the target image. Avoid stacking multiple effects that perform the same job.

## Proposed order

1. Input/depth diagnostics (development only)
2. Anti-aliasing when required and compatible
3. Base exposure / white balance
4. Tonemapping / highlight rolloff
5. Color grading / curves / selective color
6. Local contrast or clarity, only if needed
7. Atmospheric/depth effects, only when depth is healthy
8. Bloom/glow at restrained intensity
9. Debanding/dithering
10. Final sharpening
11. Debug split/comparison tools (development only)

## Depth gate

Depth-dependent effects are disabled when depth is invalid, reversed incorrectly, unstable under the active AA/upscaler combination, or unavailable to the effect.

Affected class:
- MXAO / SSAO
- SSR
- GI / RTGI-style effects
- DOF
- depth fog
- depth outlines

## Profile design

### SAFE
Color correction, tonemap, conservative sharpening and debanding only.

### PERFORMANCE
Same visual identity as SAFE plus low-cost anti-aliasing/clarity where compatible.

### BALANCED
Adds selective depth effects with strict cost limits.

### HIGH
Higher-quality depth effects and controlled atmosphere/reflection enhancement.

### ULTRA
All compatible effects permitted, but still subject to cost and artifact gates. Ultra is not an 'everything enabled' mode.

## Development rule

Any new effect must document:
- purpose
- dependency
- expected visual gain
- cost class
- artifact risks
- fallback
- recommended profile
