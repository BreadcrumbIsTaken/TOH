activate_glyphs:
    type: world
    events:
        on player right clicks block with:light_glyph:
            - run glyphs.light
        on player right clicks block with:ice_glyph:
            - ratelimit <player> 2s
            - run glyphs.ice
        on player right clicks block with:plant_glyph:
            - ratelimit <player> 2s
            - if <player.is_sneaking>:
                - run glyphs.plant.spread
            - else:
                - run glyphs.plant.pillar
        on player right clicks block with:fire_glyph:
            - ratelimit <player> 2s
            - if <player.is_sneaking>:
                - run glyphs.fire.ignite def.1:<context.location>
            - else:
                - run glyphs.fire.throw
        on player right clicks block with:invisible_glyph:
            - if <player.has_flag[using_invisibility_glyph]>:
                - ratelimit <player> 5s
                - narrate "<yellow>You can't use this while you are already invisible!"
            - else:
                - flag player using_invisibility_glyph expire:10s
                - run glyphs.invisible.cast

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
            - ratelimit <player> 5s
            - determine passively cancelled
            - hurt <context.final_damage.div[2]> <context.entity>
            - run glyph_weapons.ice_sword def.1:<context.entity>
        # Prevents the player from taking any further damage form the ice effect
        on player damaged by freeze:
            - determine cancelled
        on player right clicks block with:ice_sword:
            - ratelimit <player> 2s
            - give <context.location.material.name>
            - modifyblock <context.location> ice

activate_plant_sword:
    type: world
    events:
        on player damaged by player with:plant_sword:
            - ratelimit <player> 5s
            - determine passively cancelled
            - hurt <context.final_damage.div[2]> <context.entity>
            - run glyph_weapons.plant_sword def.1:<context.entity>
        on player right clicks block with:plant_sword:
            - ratelimit <player> 2s
            - give <context.location.material.name>
            - modifyblock <context.location> <list[dandelion|poppy|blue_orchid|allium|azure_bluet|pink_tulip|orange_tulip|red_tulip|white_tulip|oxeye_daisy|cornflower|lily_of_the_valley].random>

prevent_glyph_power_damage:
    type: world
    events:
        on player damaged by fall flagged:using_ice_glyph:
            - determine cancelled
        on player damaged by fall flagged:using_plant_glyph:
            - determine cancelled

# You can tell that because this is here that I accidentally dyed a sheep with a glyph while testing. :|
prevent_dying_of_sheep:
    type: world
    events:
        on sheep dyed color:
            - determine cancelled

trigger_invisibility_glyph_off:
    type: world
    events:
        on player steps on block flagged:using_invisibility_glyph:
            - flag player using_invisibility_glyph:!
            - run glyphs.invisible.remove