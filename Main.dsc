glyphs:
    type: task
    script:
        - clickable display_light_glyph_instructions save:light_glyph_clickable
        - clickable display_ice_glyph_instructions save:ice_glyph_clickable
        - clickable display_plant_glyph_instructions save:plant_glyph_clickable

        - narrate "To see the crafting recipe for the <yellow>Light Glyph<reset>, click <blue><element[here!].on_click[<entry[light_glyph_clickable].command>]>"
        - narrate "To see the crafting recipe for the <yellow>Ice Glyph<reset>, click <blue><element[here!].on_click[<entry[ice_glyph_clickable].command>]>"
        - narrate "To see the crafting recipe for the <yellow>Plant Glyph<reset>, click <blue><element[here!].on_click[<entry[plant_glyph_clickable].command>]>"
        - narrate <green>---
        - run glyph_weapons
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
    plant:
        pillar:
            - flag player using_plant_glyph
            - define points <player.location.points_around_y[radius=3;points=7]>
            - foreach <[points]> as:i:
                - modifyblock <[i]> flowering_azalea_leaves[persistent=true]
                - repeat 4:
                    - wait 1t
                    - modifyblock <[i].add[0,<[value]>,0]> flowering_azalea_leaves[persistent=true]
                    - playsound sound:block_bamboo_break <player.location> pitch:.5 volume:2
                    - playeffect effect:redstone at:<[i]> quantity:10 special_data:1.2|green
            - repeat 4:
                - wait 1t
                - adjust <player> location:<player.location.add[0,1,0]>
                - modifyblock <player.location.below> flowering_azalea_leaves[persistent=true]
                - playsound sound:block_bamboo_break <player.location> pitch:.5 volume:2
                - playeffect effect:redstone at:<[value]> quantity:10 special_data:1.2|light_green
            - push <player> destination:<player.location.forward.add[0,3,0]> speed:1 no_rotate
            - wait 2s
            - flag player using_plant_glyph:!
        spread:
            - repeat 6:
                - define points <player.location.below.points_around_y[radius=<[value]>;points=10]>
                - foreach <[points]> as:i:
                    - modifyblock <[i]> grass_block[biome=flower_forest]
                    - adjust <[i]> apply_bonemeal:up
                    - playeffect effect:redstone at:<[i].add[0,1.5,0]> quantity:10 special_data:1.2|light_green

glyph_weapons:
    type: task
    script:
        - clickable display_ice_sword_instructions save:ice_sword_clickable
        - clickable display_plant_sword_instructions save:plant_sword_clickable

        - narrate "To see the crafting recipe for the <yellow>Ice Sword<reset>, click <blue><element[here].on_click[<entry[ice_sword_clickable].command>]>"
        - narrate "To see the crafting recipe for the <yellow>Plant Sword<reset>, click <blue><element[here].on_click[<entry[plant_sword_clickable].command>]>"
    ice_sword:
        - adjust <[1]> freeze_duration:10s
        - cast slow <[1]> amplifier:3 duration:8s hide_particles no_ambient no_icon
    plant_sword:
        - define points <[1].location.points_around_y[radius=2;points=10]>
        - foreach <[points]> as:i:
            - modifyblock <[i]> flowering_azalea_leaves
            - repeat 4:
                - modifyblock <[i].add[0,<[value]>,0]> flowering_azalea_leaves
                - playsound sound:block_bamboo_break <player.location> pitch:.5 volume:2
                - playeffect effect:redstone at:<[value]> quantity:10 special_data:1.2|light_green

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