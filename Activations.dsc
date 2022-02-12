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
            - schematic load name:ice_glyph_pillar_slice filename:../scripts/schematics/ICE_GLYPH_PILLAR_SLICE.schem