glyphs:
    type: task
    script:
        - narrate "<aqua>Craft a light glyph to get started! Here's how in a crafting table:"
        - narrate "<yellow>torch  <green>|           |"
        - narrate "<yellow>paper <green>| <yellow>ink_sac <green>|"
    light:
        - if !<player.has_flag[using_glyph]>:
            - flag <player> using_glyph
            - spawn armor_stand[visible=false;gravity=false] <player.location.add[.5,.5,.5]> save:light_follower

            - define light_follower <entry[light_follower].spawned_entity>

            - equip <[light_follower]> head:light_glyph_floating_object_head
            - attach <[light_follower]> to:<player> offset:<player.location.backward[2]> sync_server

            # TODO: Add a particle effect.

            - wait 10s
            - attach <[light_follower]> to:cancel

            - remove <[light_follower]>
            - flag <player> using_glyph:!
        - else:
            - narrate "Please wait for other glyphs to end before using this glyph!"

player_uses_light_glyph:
    type: world
    events:
        on player right clicks block with:light_glyph:
            - determine passively cancelled
            - run glyphs.light