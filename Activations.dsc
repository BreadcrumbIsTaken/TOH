activate_glyphs:
    type: world
    events:
        on player right clicks block with:light_glyph:
            - run glyphs.light
        on player right clicks block with:ice_glyph:
            - ratelimit <player> 5s
            - run glyphs.ice

# Will load the schematic into memory when the server starts.
# This will (most likely) prevent the ice glyph pillar from loading a bit slower the first time it is preformed after the server resets.
load_ice_glyph_pillar_schematic:
    type: world
    events:
        on server start:
            - schematic load name:ice_glyph_pillar_slice

activate_ice_sword:
    type: world
    events:
        on player damaged by player with:ice_sword:
            - determine passively cancelled
            - hurt <context.final_damage.div[2]> <context.entity>
            - run glyph_weapons.ice_sword def.1:<context.entity>
        # Prevents the player from taking any further damage form the ice effect
        on player damaged by freeze:
            - determine cancelled
        on player right clicks block with:ice_sword:
            - ratelimit <player> 4s
            - give <context.location.material.name>
            - modifyblock <context.location> ice

prevent_ice_glyph_pillar_damage:
    type: world
    events:
        on player damaged by fall flagged:using_ice_glyph:
            - determine cancelled