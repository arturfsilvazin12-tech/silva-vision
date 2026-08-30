# Silva Vision — Visual Design Specification

## Core identity

The project should look realistic first and cinematic second. Avoid excessive saturation, crushed blacks, giant bloom halos and uniformly colored lighting.

## Lighting model

| Source | Target behavior |
|---|---|
| Sun | Natural, controlled highlights |
| Street lamps | Warm urban light |
| Vehicle headlights | Neutral/white |
| Brake/rear lights | Strong red without clipping |
| Neon | Preserve source hue |
| Interiors | Warm/neutral variation |
| Rain | Increase visible light interaction without flooding the image |

## Day

Preserve sky detail, surface texture and shadow information. Color should be vivid but not cartoon-like.

## Sunset

Use warmer light, longer perceived shadows and controlled highlight rolloff. Avoid a global orange filter.

## Night

Keep blacks deep while retaining local detail. Artificial lights should become visual anchors rather than simply raising global exposure.

## Rain

The visual response should combine wet surfaces, atmospheric moisture, reflections and light interaction. A wet road should not behave like a mirror everywhere.

## Performance philosophy

Every expensive effect must have a reason to exist. Heavy effects are isolated into higher quality profiles so the balanced preset can preserve the visual identity at lower cost.

## Compatibility philosophy

Never rename or replace a native file merely for organization. First identify the native target, expected format, load path and interaction with other layers.
