# Fire Watchers: Fort Valley Tutorial Asset Plan

This scene should feel like the player has stepped into a song they do not want to leave: cold air, warm windows, stone underfoot, supply labor, and a spiritual pressure underneath ordinary objects.

## Canonical scene purpose

Fort Valley is the living-before-broken tutorial space. The player learns movement, interaction, supply work, warmth, hunger, and duty while the place still feels established. The Avalanche does not need to happen yet. The player should first feel what will later be lost.

Novel anchors:

- Fort Valley is where recruitment for the Fire Watchers happens.
- Fort Valley is constantly under threat of evacuation.
- There is an Order Designation list in case of evacuation.
- Cooks feed survivors.
- Outposts and warehouses receive evacuees and put them to work.
- Gideon's arc should move from taking food toward providing food.

## Camera and style

- Top-down 2D, not heavy isometric.
- Pokemon-like readability, survival-RPG atmosphere.
- 32x32 tile logic.
- 1280x720 gameplay presentation.
- Warm light against cold blues/grays.
- Assets should be readable as individual objects with interaction rules.

## Asset registry for first tutorial slice

Each item below should eventually become its own sprite/object pair or tile asset. The current controller-drawn version is only a composition scaffold.

### 1. Gideon player

Object: `obj_player`

Needed art:

- Idle down/up/left/right
- Walk down/up/left/right, at least 2 frames each
- Optional later: tired, cold, injured, carrying crate, lantern-held

Rules:

- WASD / arrow movement
- Facing direction stored
- Interaction direction later uses `facing`
- Carry state later slows movement

### 2. Order Designation Board

Future object: `obj_order_designation_board`

Purpose:

- Main tutorial objective
- Shows evacuation/order lore without dumping exposition

Needed art:

- Board idle
- Board hover/interaction glint
- Small paper flutter animation

Rules:

- Press interact when close
- Opens text box: `Order Designation Board`
- Updates objective to supply task

### 3. Cookhouse marker / cookhouse door

Future object: `obj_cookhouse_door`

Purpose:

- Establishes warmth, food, and what Gideon later longs for
- Connects to Chapter 2 memory of warm bread, blackberries, dough, honey, and salt

Needed art:

- Door/window glow
- Chimney smoke strip
- Warm window flicker

Rules:

- Non-enterable at first or single interaction text
- Later receives crate delivery
- Adds warmth when near

### 4. Supply crate

Future object: `obj_supply_crate`

Purpose:

- First object-based labor task
- Teaches carrying and placement
- Prepares player for warehouse work after the Avalanche

Needed art:

- Crate idle
- Crate lifted/carried
- Crate placed
- Optional: ration-marked crate, medical crate, tool crate

Rules:

- Interact to pick up
- Carry slows player
- Place on marked tile
- Wrong placement gives gentle feedback

### 5. Lantern post

Future object: `obj_lantern_post`

Purpose:

- Visual warmth language
- Teaches warmth meter later

Needed art:

- Post idle
- Flame flicker animation strip
- Glow overlay if possible

Rules:

- Adds warmth when close later
- Flicker can intensify during storm warning

### 6. Snowbank / snow pile

Future object/tile: `obj_snowbank` or tile asset

Purpose:

- Scene boundary
- Soft natural collision
- Shows Fort Valley's constant winter threat

Needed art:

- Small pile
- Large drift
- Trampled snow edge
- Avalanche-blocked variant later

Rules:

- Collision object or tile collision
- Some snowbanks can be cleared by shovel later

### 7. Fence / gate

Future object: `obj_wood_fence`, `obj_gate`

Purpose:

- Guides player path without hard UI
- Supports evacuation routing later

Needed art:

- Fence straight/horizontal/vertical/corners
- Gate open/closed
- Snow-covered variants

Rules:

- Collision
- Gate can open after objective

### 8. Footprints / path marks

Future tile overlay or object: `obj_footprints`

Purpose:

- Environmental guidance
- Implies community movement and routine

Needed art:

- Footprint trail north/south/east/west
- Sled track trail
- Drag marks for crates

Rules:

- No collision
- Directional visual guidance

### 9. Workshop / Garret prefigure

Future object cluster:

- `obj_workshop_door`
- `obj_tool_bench`
- `obj_broken_truck_preview` later

Purpose:

- Seeds Garret's repair theme before the warehouse

Needed art:

- Tool bench
- Hanging tools
- Warm lamp
- Smoke/steam detail

Rules:

- Optional interaction text
- Later becomes repair system teaching location

### 10. Tutorial UI

Future object: `obj_tutorial_hud`

Purpose:

- Minimal orientation, not clutter

Needed art/code:

- Objective panel
- Controls panel
- Inventory strip later

Rules:

- Objective changes with tutorial step
- Can fade after progress

## First playable tutorial flow

1. Player spawns in Fort Valley supply yard.
2. Objective: Report to the Order Designation Board.
3. Board interaction assigns crate delivery.
4. Player picks up supply crate.
5. Player carries crate to cookhouse marker.
6. Cookhouse interaction gives warmth/provision text.
7. A distant bell or warning text foreshadows Avalanche later, but does not trigger it yet.

## Implementation principle

Do not make the final look by drawing everything inside the player. Use the player for player behavior. Use scene controllers and eventually separate asset objects for the world.

The current `obj_fort_valley_controller` is a staging scaffold only. It exists so layout, mood, and spatial canon can be tested before making real imported sprite strips.
