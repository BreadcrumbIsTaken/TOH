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

            # So: Bruh moment. Light blocks don't render and also can't move because mincraft is a poopoo head.
            # TODO: Consider:
            #   Keeping the head only,
            #   Switching to spigot and use the light command,
            #   or just place a light block and then remove it (somehow) using the location and then update its location when the plaer moves.

            # - spawn falling_block[material=light[level=15];gravity=false] <player.location.add[.5,.5,.5]> save:light_follower_emitter
            # - define light <entry[light_follower_emitter].spawned_entity>
            # - attach <[light]> to:<player> offset:<player.location.backward[2]> sync_server

            - wait 10s
            # - attach <[light]> to:cancel
            - attach <[light_follower]> to:cancel

            # - remove <[light]>
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