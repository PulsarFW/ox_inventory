<div align="center">

<img src="https://r2.fivemanage.com/GPYOH8Hq4GPyAY7czrgLe/pulsarbanner.png" alt="Pulsar Framework" width="100%" />

<br/>

# ox_inventory

### Slot-based inventory system — Pulsar Framework edition

<br/>

![Lua](https://img.shields.io/badge/Lua_5.4-2C2D72?style=flat-square&logo=lua&logoColor=white)
![FiveM](https://img.shields.io/badge/FiveM-F40552?style=flat-square)
![React](https://img.shields.io/badge/React_18-61DAFB?style=flat-square&logo=react&logoColor=black)
![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?style=flat-square&logo=typescript&logoColor=white)
![Mantine](https://img.shields.io/badge/Mantine_7-339AF0?style=flat-square&logo=mantine&logoColor=white)

<br/>

[Overview](#overview) · [Bridge](#bridge) · [Configuration](#configuration) · [UI Development](#ui-development) · [Dependencies](#dependencies)

</div>

---

## Overview

A production fork of [ox_inventory](https://github.com/communityox/ox_inventory) shipping with a full **Pulsar Framework** bridge. Every resource in the stack — drugs, police, finance, targeting, crafting — interacts with inventory without modification. Item definitions, shop configs, and crafting tables are bundled directly into this resource.

**`pulsar-inventory` does not need to run.**

> [!WARNING]
> Do not pull from upstream ox_inventory without reviewing bridge compatibility first. The bridge overrides core server and client behaviours.

---

## Bridge

Located in `modules/bridge/pulsar/`. Loaded automatically when `inventory:framework "pulsar"` is set.

### Server

| System | Status |
|--------|--------|
| Character spawn — inventory load + cash sync | ✅ |
| Character logout — inventory save | ✅ |
| Job / group updates — live sync | ✅ |
| Cash as inventory item (bidirectional with pulsar-characters) | ✅ |
| `SetData('Cash')` handler — keeps cash item in sync | ✅ |
| Item database — all item files converted at boot | ✅ |
| Item metadata — staticMetadata, type-based auto-generation, govid | ✅ |
| Consumable use — status, health, armour, energy, stress, drugs, progress | ✅ |
| Weapon items — equip / unequip via Weapons component | ✅ |
| Ammo items — load into weapon with count input | ✅ |
| Dispense items — pack count tracked in metadata | ✅ |
| Bullet packing — combine loose bullets into ammo box | ✅ |
| Shops — location-based + ped-spawned + programmatic | ✅ |
| Stashes, trunks, gloveboxes, drops | ✅ |
| Crafting benches — ped/model spawn, targeting, open | ✅ |
| Schematics — per-player unlock + DB storage | ⏳ |
| State bags — ItemStates, isCuffed, isDead | ✅ |

### Client

| System | Status |
|--------|--------|
| Shop open (pedinteraction → ox UI) | ✅ |
| Crafting open (pedinteraction → ox UI) | ✅ |
| Crafting bench ped + model spawning | ✅ |
| Item use — anim config + progress bar | ✅ |
| Armour / health modifiers | ✅ |
| Energy + speed modifier | ✅ |
| Stress tick state | ✅ |
| Drug state (persisted to character) | ✅ |
| Progress modifier | ✅ |
| Item slot notifications (add / remove) | ✅ |
| Ammo load UI (weapon list + count input) | ✅ |
| Vending machine target integration | ✅ |

---

## Configuration

Add to `server.cfg`:

```
setr inventory:framework  "pulsar"
setr inventory:slots       50
setr inventory:weight      30000
setr inventory:target      0
```

| Convar | Default | Description |
|--------|---------|-------------|
| `inventory:framework` | `ox` | Must be `pulsar` |
| `inventory:slots` | `50` | Player inventory slots |
| `inventory:weight` | `30000` | Max carry weight (grams) |
| `inventory:target` | `0` | `0` = ox_lib points, `1` = ox_target zones |
| `inventory:itemnotify` | `1` | Show item add/remove HUD popups |
| `inventory:loglevel` | `0` | `0` = off, `1` = high-value, `2` = all |

---

## Data

Item definitions, shop configs, and crafting tables live under `data/` and are loaded at boot.

```
data/
├── pulsar-items/          # Item definitions (converted from Pulsar format at runtime)
│   └── index.lua          # Aggregator — lists all item files
├── pulsar-crafting/
│   ├── crafting_config.lua  # Bench definitions (label, location, targeting, recipes)
│   └── schematic_config.lua # Schematic recipes (per-player unlock)
├── shops.lua              # Location-based shop definitions
└── licenses.lua           # License purchase point definitions
```

---

## UI Development

The NUI is a React 18 + Mantine 7 + Redux app compiled with Vite.

```bash
cd web
bun install
bun run start    # dev server (http://localhost:3000) with hot reload
bun run build    # production build → web/build/
```

**Theme:** `web/src/theme.ts` — Pulsar purple palette (`#7c3aed` primary, `#0a0614` dark base).  
**SCSS variables:** `web/src/index.scss` — grid sizing, slot colours, typography.

---

## Dependencies

| Resource | Purpose |
|----------|---------|
| `ox_lib` | Points, callbacks, notify, keybinds, progress |
| `oxmysql` | Database (inventory persistence) |
| `pulsar-base` | Framework core — middleware, fetch, callbacks |
| `pulsar-characters` | Character data — cash, name, SID, jobs |
| `pulsar-pedinteraction` | Ped interaction events (shops, crafting) |
| `ox_target` | World targeting (optional, controlled by `inventory:target`) |

---

<div align="center">

![Pulsar Framework](https://img.shields.io/badge/Pulsar-Framework-7c3aed?style=flat-square)
![Built for FiveM](https://img.shields.io/badge/Built_for-FiveM-F40552?style=flat-square)
![License](https://img.shields.io/badge/License-LGPL_3.0-green?style=flat-square)

</div>
