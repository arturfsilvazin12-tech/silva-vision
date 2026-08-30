# Silva Vision

Graphics project for FiveM/GTA V focused on realistic lighting, atmosphere, weather, color grading, reflections and performance-aware presets.

## Project principles

- Preserve native file names unless compatibility has been verified.
- Separate Citizen, visual settings, ReShade, ENB and optional assets.
- Prefer measurable, reversible changes over blind tuning.
- Maintain performance profiles alongside visual-quality profiles.
- Research public FiveM/ReShade/GitHub/community techniques before adopting an approach.
- Do not redistribute third-party assets without permission or compatible licensing.

## Planned architecture

```text
silva-vision/
├── docs/
├── presets/
│   ├── reshade/
│   └── profiles/
├── visualsettings/
├── citizen/
├── enb/
├── shaders/
├── tools/
├── compatibility/
├── benchmarks/
└── releases/
```

## Visual targets

- Natural daylight with controlled highlights and shadows
- Warm urban street lighting with neutral vehicle headlights
- Detailed but dark night scenes
- Rain with wet-surface response and controlled reflections
- Cinematic sunset and atmospheric depth
- Multiple performance tiers

## Status

Research and architecture phase. Installation-ready game files are only added after their exact target path and compatibility are verified.
