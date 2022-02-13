glyphs:
    type: task
    script:
        - clickable display_light_glyph_instructions save:light_glyph_clickable
        - clickable display_ice_glyph_instructions save:ice_glyph_clickable

        - narrate "To see the crafting recipe for the <yellow>Light Glyph<reset>, click <blue><element[here!].on_click[<entry[light_glyph_clickable].command>]>"
        - narrate "To see the crafting recipe for the <yellow>Ice Glyph<reset>, click <blue><element[here!].on_click[<entry[ice_glyph_clickable].command>]>"
    light:
        - if !<player.has_flag[using_light_glyph]>:
            - flag <player> using_light_glyph
            - spawn armor_stand[visible=false;gravity=false] <player.location.add[.5,.5,.5]> save:light_follower

            - define light_follower <entry[light_follower].spawned_entity>

            - playeffect effect:end_rod at:<[light_follower].location.add[.5,<[light_follower].eye_height>,.5]> quantity:10
            - playsound sound:BLOCK_CANDLE_EXTINGUISH <player.location> pitch:.5

            - equip <[light_follower]> head:light_glyph_floating_object_head
            - attach <[light_follower]> to:<player> offset:<player.location.backward[2]> sync_server

            - wait 20s
            - attach <[light_follower]> to:cancel

            - remove <[light_follower]>
            - flag <player> using_light_glyph:!
        - else:
            - ratelimit <player> 5s
            - narrate "<&color[#17AEE8]>You can only use the light glyph once every 20 seconds!"
    ice:
        - flag player using_ice_glyph
        # Just a fail-safe. If somehow the schematic isn't loaded on server startup this will load it here instead.
        - if !<schematic[ice_glyph_pillar_slice].exists>:
            - schematic load name:ice_glyph_pillar_slice

        - repeat 5:
            - adjust <player> location:<player.location.add[0,1,0]>
            - schematic paste name:ice_glyph_pillar_slice <player.location.below.sub[0,1,0]>
            - playsound sound:block_amethyst_block_chime <player.location> volume:2
            - wait 2t

        - push <player> destination:<player.location.forward.add[0,3,0]> speed:1 no_rotate
        - wait 2s
        - flag player using_ice_glyph:!

glyph_weapons:
    type: task
    script:
        - clickable display_ice_sword_instructions save:ice_sword_clickable

        - narrate "To see the crafting recipe for the <yellow>Ice Sword<reset>, click <blue><element[here].on_click[<entry[ice_sword_clickable].command>]>"
    ice_sword:
        - adjust <[1]> freeze_duration:10s
        - cast slow <[1]> amplifier:3 duration:8s hide_particles no_ambient no_icon

glyphs_command:
    type: command
    name: glyph
    usage: /glyph
    aliases:
        - glyphs
        - glyphmagic
    description: Gives you instruction on how to craft each glyph!
    script:
        - run glyphs