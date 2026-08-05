# Violence District Pro Hub

Professional, keyless script and GUI panel for **Violence District** on Roblox.

## Features
- **Auto Generator (AFK Farm)** with working **Stop / Exit Button** (no more getting stuck in infinite repair loops!).
- **No CD Dagger** (Instant attack cooldown removal for daggers and weapons).
- **Auto Perfect Skill-Check** (Never fail generator repairs).
- **ESP / Wallhack Suite**: Survivors ESP, Killers ESP, Generator ESP, and Box ESP with distance tracking.
- **Teleport System**: Instant teleport to nearest generator.
- **Modern GUI Panel**: Clean non-AI professional user interface with custom SVG icons hosted on GitHub.

## Quick Start / Loader
Run this in your Roblox executor:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/pipiskazhopakakashka/violence-district/arena/019fd39e-violence-district/loader.lua"))()
```

## Repository Structure
- `loader.lua` - Main script loader
- `src/esp.lua` - Drawing-based ESP / Wallhack
- `src/features.lua` - Game mechanics (Auto Generator fix, No CD Dagger, Skill Checks)
- `src/gui.lua` - Professional UI panel with SVG icon integration
- `assets/` - SVG icons (`home.svg`, `combat.svg`, `esp.svg`, `generator.svg`, `teleport.svg`, `settings.svg`)
