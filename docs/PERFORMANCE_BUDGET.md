# Silva Vision — Performance Budget

## Goal

The graphics pack must improve image quality without turning expensive post-processing into an uncontrolled FPS tax.

## Effect classes

| Class | Meaning | Allowed in Balanced |
|---|---|---|
| A | Very low cost | Yes |
| B | Low cost | Yes |
| C | Moderate | Conditional |
| D | High | High/Ultra |
| E | Very high / unstable | Ultra or optional |

## GPU-time mindset

Do not judge a shader only by whether it looks good in a screenshot. ReShade statistics should be used during development to identify unexpected GPU-time spikes.

## Budget rules

1. No redundant sharpening stages.
2. No multiple bloom/glow passes doing the same job.
3. Depth-heavy effects require a depth-health check.
4. SSR/GI/DOF are optional and profile-gated.
5. A fallback preset must exist for diagnosing performance problems.
6. Changes that improve visuals but cause disproportionate frame-time increases are rejected or isolated.

## Diagnostic sequence

When FPS drops:

1. Compare SAFE vs current profile.
2. Disable depth-dependent effects.
3. Check ReShade statistics.
4. Disable expensive effects one at a time.
5. Check game-side render distance/grass/shadow settings.
6. Check VRAM/streaming behavior.
7. Record the result before changing another variable.

## Target hardware strategy

The project will support a balanced 1080p class profile in addition to high-end presets. Hardware-specific tuning is not claimed until real benchmark data exists.
