glyphs:
    type: task
    script:
        - narrate "<aqua>Craft a light glyph to get started! Here's how in a crafting table:"
        - narrate "<yellow>torch  <green>|           |"
        - narrate "<yellow>paper <green>| <yellow>ink_sac <green>|"
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
        - if !<schematic[ice_glyph_pillar_slice].exists>:
            - schematic load name:ice_glyph_pillar_slice filename:../scripts/schematics/ICE_GLYPH_PILLAR_SLICE.schem

        - repeat 5:
            - adjust <player> location:<player.location.add[0,1,0]>
            - schematic paste name:ice_glyph_pillar_slice <player.location.below.sub[0,1,0]>
            - playsound sound:block_amethyst_block_chime <player.location> volume:2
            - wait 2t

        - push <player> destination:<player.location.forward.add[0,3,0]> speed:1 no_rotate