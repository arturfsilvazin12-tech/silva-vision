# Silva Vision — Research Findings 001

Research sweep across public GitHub projects, Reddit discussions, Cfx.re forums and YouTube references. The goal is to identify techniques worth investigating, not to copy third-party assets.

## High-value findings

### 1. Separate engine-side lighting from post-processing
Community projects repeatedly combine visual settings/timecycle changes with ReShade. This supports a layered architecture: native/world data establishes the lighting scene, while ReShade handles final color and image treatment.

### 2. `visualsettings.dat` exposes more than simple brightness
Public FiveM/GTA repositories contain controls for rain particles, rain lighting, cloud behavior, vehicle interior lights, coronas, reflections and other scene parameters. This makes visualsettings a major research target rather than a minor config file.

### 3. Rain should be multi-layered
Public files expose rain particle count, lit rain shader behavior, gravity, diffuse/ambient contribution, default light and rain collision/reflection parameters. Silva Vision should therefore treat rain as particles + surface response + lighting + atmosphere rather than one slider.

### 4. Live iteration is a major productivity opportunity
The public `fxReloader` project demonstrates live reloading/editing of `visualsettings.dat` and timecycle data. This suggests a future Silva Vision developer workflow where values are changed and compared rapidly rather than restarting the game for every adjustment. We should investigate the concept, but not ship third-party code without license/compatibility review.

### 5. ReShade compatibility needs its own layer
Cfx.re reports show recurring issues around ReShade loading, resolution/upscaling changes, UI-lag settings and graphics-mod injection. Silva Vision should document supported configurations and include a compatibility checklist instead of assuming one installation path works forever.

### 6. Performance profiles are not optional
Community reports favor combinations that preserve visual quality while limiting expensive effects. Silva Vision should maintain distinct Ultra, High, Balanced and Performance profiles and identify expensive effects individually.

### 7. Avoid the 'wet-everything' look
Community reactions repeatedly criticize graphics presets that make roads permanently wet/reflective or overcast. Realism should come from context: weather state, surface response, lighting direction and controlled reflection—not global gloss.

### 8. Lighting temperature needs local variation
The design target should not be 'all street lights yellow'. Use warm urban sources, neutral headlights, preserved neon colors and different interior/emissive behavior.

### 9. Visual settings can be resource-driven in FiveM
Open-source FiveM examples load a visualsettings file and apply values through native calls. This is a useful research direction for a server/resource-side configuration architecture, but it must be validated against the exact FiveM behavior before being presented as universal.

### 10. Compatibility must be version-aware
GTA V Legacy/Enhanced and FiveM can have different file behavior. Public tooling now exists that explicitly distinguishes Legacy and Enhanced. Silva Vision should record target platform/version in every release and never silently mix files from incompatible bases.

## Research-derived development upgrades

1. Add a **Visual Parameter Registry** documenting every Silva Vision variable, its source layer, expected range, visual effect, performance cost and rollback method.
2. Add a **Weather Matrix** mapping each weather state to lighting, exposure, reflection, fog and color behavior.
3. Add a **Lighting Temperature Matrix** for street lights, vehicle lights, interiors, emergency lights and neon.
4. Add a **Performance Cost Matrix** for ReShade effects and optional world changes.
5. Add **A/B preset methodology** so every major change can be compared against a baseline.
6. Add a **Compatibility Matrix** covering FiveM build, GTA edition, ReShade version, resolution/upscaling mode and optional ENB layer.
7. Add a **Rollback-first packaging rule**: every installable modification must have an explicit backup/restore path.
8. Add a future **Developer Tuning Toolkit** inspired by live-reload workflows, but implemented or integrated only after licensing and FiveM compatibility review.

## Sources reviewed

- Cfx.re discussions on ReShade compatibility and graphics-mod loading
- Public GitHub visualsettings repositories
- `fxReloader` public GitHub project
- Reddit discussions on NVE/QuantV/VisualV combinations and performance
- Reddit discussions on rain/reflections and realistic graphics presets
- Recent YouTube FiveM graphics tutorials showing Citizen + ReShade workflows

## Important boundary

Research findings are design inputs. Third-party source code, shaders, presets, textures, RPF content or paid assets are not copied into Silva Vision merely because they are publicly visible. Licensing and technical compatibility must be checked first.
