#|     _____ _             _       __  __             _
#|    / ____| |           | |     |  \/  |           (_)
#|   | |  __| |_   _ _ __ | |__   | \  / | __ _  __ _ _  ___
#|   | | |_ | | | | | '_ \| '_ \  | |\/| |/ _` |/ _` | |/ __|
#|   | |__| | | |_| | |_) | | | | | |  | | (_| | (_| | | (__
#|    \_____|_|\__, | .__/|_| |_| |_|  |_|\__,_|\__, |_|\___|
#|              __/ | |                          __/ |
#|             |___/|_|                         |___/
#|
#-      Created by Breadcrumb (https://breadcrumb.fun).
#-      Description:
#-          A recreation of Luz Noceda's glyph magic from The Owl House in Minecraft using Denizen!
#-      GitHub URL:
#-          https://github.com/BreadcrumbIsTaken/TOH
#-      License:
#-          Apache License 2.0: https://github.com/BreadcrumbIsTaken/TOH/blob/main/LICENSE.txt

#-      Happy Programming!

glyphs:
    type: task
    script:
        - clickable display_light_glyph_instructions save:light_glyph_clickable
        - clickable display_ice_glyph_instructions save:ice_glyph_clickable
        - clickable display_plant_glyph_instructions save:plant_glyph_clickable
        - clickable display_fire_glyph_instructions save:fire_glyph_clickable
        - clickable display_invisible_glyph_instructions save:invisible_glyph_clickable

        - narrate "To see the crafting recipe for the <yellow>Light Glyph<reset>, click <blue><element[here!].on_click[<entry[light_glyph_clickable].command>]>"
        - narrate "To see the crafting recipe for the <yellow>Ice Glyph<reset>, click <blue><element[here!].on_click[<entry[ice_glyph_clickable].command>]>"
        - narrate "To see the crafting recipe for the <yellow>Plant Glyph<reset>, click <blue><element[here!].on_click[<entry[plant_glyph_clickable].command>]>"
        - narrate "To see the crafting recipe for the <yellow>Fire Glyph<reset>, click <blue><element[here!].on_click[<entry[fire_glyph_clickable].command>]>"
        - narrate "To see the crafting recipe for the <yellow>Invisible Glyph<reset>, click <blue><element[here!].on_click[<entry[invisible_glyph_clickable].command>]>"
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
            - attach <[light_follower]> to:<player> offset:0,-2,0 sync_server

            - repeat 20:
                - run light_follower_particle_update def:<[light_follower]>
                - wait 1s

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
                - repeat 3:
                    - wait 1t
                    - modifyblock <[i].add[0,<[value]>,0]> flowering_azalea_leaves[persistent=true]
                    - playsound sound:block_bamboo_break <player.location> pitch:.5 volume:2
                    - playeffect effect:redstone at:<[i]> quantity:10 special_data:1.2|green
            - repeat 4:
                - wait 1t
                - adjust <player> location:<player.location.add[0,1,0]>
                - modifyblock <player.location.below> flowering_azalea_leaves[persistent=true]
                - playsound sound:block_bamboo_break <player.location> pitch:.5 volume:2
                - playeffect effect:redstone at:<player.location.add[0,<[value]>,0]> quantity:10 special_data:1.2|lime
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
    fire:
        throw:
            - shoot fireball origin:<player> destination:<player.cursor_on.forward[3]> speed:2
        ignite:
            - modifyblock <[1]> fire
            - playsound sound:BLOCK_FIRE_EXTINGUISH <[1]> pitch:.5
    invisible:
        cast:
            - cast invisibility amplifier:0 duration:10s hide_particles no_icon
            - playeffect at:<player.location> effect:PORTAL quantity:20
            - playsound sound:BLOCK_PORTAL_TRIGGER <player.location> pitch:3
        remove:
            - cast invisibility remove
            - playeffect at:<player.location> effect:PORTAL quantity:20
            - playsound sound:BLOCK_PORTAL_TRIGGER <player.location> pitch:3

light_follower_particle_update:
    type: task
    definitions: follower
    script:
        - playeffect effect:end_rod at:<[follower].location.add[.5,4.5,.5]> quantity:5

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

light_glyph:
    type: item
    material: yellow_dye
    display name: <yellow>Light Glyph
    lore:
        - <white>Right click to use!
    enchantments:
        - sharpness:1
    mechanisms:
        hides: ENCHANTS
    recipes:
        1:
            type: shaped
            input:
                - torch|air
                - paper|ink_sac

light_glyph_floating_object_head:
    type: item
    material: player_head
    mechanisms:
        skull_skin: 17b9fdf7-6ca9-414b-b07d-9d694125e611|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMWQzNmEzNjFjMjFkOGY3YmQ0YWM2Mzg1NzVjM2I2NzdmMGJlMWFmODE4ZjRjMWEyODQ3MDUxNTUzMTQzZDkxZSJ9fX0=

ice_glyph:
    type: item
    material: light_blue_dye
    display name: <yellow>Ice Glyph
    lore:
        - <white>Right click to use!
    enchantments:
        - sharpness:1
    mechanisms:
        hides: ENCHANTS
    recipes:
        1:
            type: shaped
            input:
                - blue_ice|air
                - paper|ink_sac

ice_sword:
    type: item
    material: iron_sword
    display name: <yellow>Ice Sword
    lore:
        - <white>A sword infused with
        - <white>a <yellow>Light Glyph<reset><white>!
        - <white>Right click a block
        - <white>to turn it to ice!
        - <white>Attack a player to
        - <white>temporarally stun them, but only
        - <white>dealing half the ammount of damage.
    enchantments:
        - unbreaking:1
    mechanisms:
        hides: ENCHANTS
    recipes:
        1:
            type: smithing
            base: iron_sword
            upgrade: ice_glyph
            retain: display

plant_glyph:
    type: item
    material: green_dye
    display name: <yellow>Plant Glyph
    lore:
        - <white>Right click to use!
    enchantments:
        - sharpness:1
    mechanisms:
        hides: ENCHANTS
    recipes:
        1:
            type: shaped
            input:
                - dandelion/poppy/blue_orchid/allium/azure_bluet/*_tulip/oxeye_daisy/cornflower/lily_of_the_valley|air
                - paper|ink_sac

plant_sword:
    type: item
    material: stone_sword
    display name: <yellow>Plant Sword
    lore:
        - <white>A sword infused with
        - <white>a <yellow>Plant Glyph<reset><white>!
        - <white>Right click a block
        - <white>to grow a flower!
        - <white>Attack a player to
        - <white>trap them, but deals
        - <white>half damage!
    enchantments:
        - unbreaking:1
    mechanisms:
        hides: ENCHANTS
    recipes:
        1:
            type: smithing
            base: stone_sword
            upgrade: plant_glyph
            retain: display

fire_glyph:
    type: item
    material: orange_dye
    display name: <yellow>Fire Glyph
    lore:
        - <white>Right click to shoot a fireball!
        - <white>Shift right click to catch a block on fire!
    enchantments:
        - sharpness:1
    mechanisms:
        hides: ENCHANTS
    recipes:
        1:
            type: shaped
            input:
                - flint_and_steel|air
                - paper|ink_sac

fire_glyph_projectile:
    type: item
    material: fire_charge

invisible_glyph:
    type: item
    material: magenta_dye
    display name: <yellow>Invisible Glyph
    lore:
        - <white>Right click to turn invisible!
        - <white>Works for 10 seconds.
        - <white>If you move within those 10 seconds,
        - <white>the ability ends.
    enchantments:
        - sharpness:1
    mechanisms:
        hides: ENCHANTS
    recipes:
        1:
            type: shaped
            input:
                - glass|air
                - paper|ink_sac

how_to_craft_light_glyph_inventory:
    type: inventory
    inventory: chest
    title: Light Glyph Recipie
    gui: true
    size: 45
    procedural items:
        - determine <list[].pad_right[45].with[black_stained_glass_pane]>
    slots:
        - [] [] [] [] [] [] [] [] []
        - [] [torch] [air] [air] [] [] [] [] []
        - [] [paper] [ink_sac] [air] [] [] [] [light_glyph] []
        - [] [air] [air] [air] [] [] [] [] []
        - [] [] [] [] [] [] [] [] []

display_light_glyph_instructions:
    type: task
    script:
        - inventory open d:how_to_craft_light_glyph_inventory

how_to_craft_ice_glyph_inventory:
    type: inventory
    inventory: chest
    title: Ice Glyph Recipie
    gui: true
    size: 45
    procedural items:
        - determine <list[].pad_right[45].with[black_stained_glass_pane]>
    slots:
        - [] [] [] [] [] [] [] [] []
        - [] [blue_ice] [air] [air] [] [] [] [] []
        - [] [paper] [ink_sac] [air] [] [] [] [ice_glyph] []
        - [] [air] [air] [air] [] [] [] [] []
        - [] [] [] [] [] [] [] [] []

display_ice_glyph_instructions:
    type: task
    script:
        - inventory open d:how_to_craft_ice_glyph_inventory

how_to_craft_ice_sword_glyph_inventory:
    type: inventory
    inventory: chest
    title: Ice Glyph Recipie (Smithing table)
    gui: true
    size: 45
    procedural items:
        - determine <list[].pad_right[45].with[black_stained_glass_pane]>
    slots:
        - [] [] [] [] [] [] [] [] []
        - [] [] [] [] [] [] [] [] []
        - [] [iron_sword] [air] [ice_glyph] [] [] [] [ice_sword] []
        - [] [] [] [] [] [] [] [] []
        - [] [] [] [] [] [] [] [] []

display_ice_sword_instructions:
    type: task
    script:
        - inventory open d:how_to_craft_ice_sword_glyph_inventory

how_to_craft_plant_glyph_inventory:
    type: inventory
    inventory: chest
    title: Plant Glyph Recipie
    gui: true
    size: 45
    procedural items:
        - determine <list[].pad_right[45].with[black_stained_glass_pane]>
    slots:
        - [] [] [] [] [] [] [] [] []
        - [] [dandelion[display_name=Any Flower;lore=Excluding wither roses]] [air] [air] [] [] [] [] []
        - [] [paper] [ink_sac] [air] [] [] [] [plant_glyph] []
        - [] [air] [air] [air] [] [] [] [] []
        - [] [] [] [] [] [] [] [] []

display_plant_glyph_instructions:
    type: task
    script:
        - inventory open d:how_to_craft_plant_glyph_inventory

how_to_craft_plant_sword_glyph_inventory:
    type: inventory
    inventory: chest
    title: Plant Glyph Recipie (Smithing table)
    gui: true
    size: 45
    procedural items:
        - determine <list[].pad_right[45].with[black_stained_glass_pane]>
    slots:
        - [] [] [] [] [] [] [] [] []
        - [] [] [] [] [] [] [] [] []
        - [] [iron_sword] [air] [plant_glyph] [] [] [] [ice_sword] []
        - [] [] [] [] [] [] [] [] []
        - [] [] [] [] [] [] [] [] []

display_plant_sword_instructions:
    type: task
    script:
        - inventory open d:how_to_craft_plant_sword_glyph_inventory

how_to_craft_fire_glyph_inventory:
    type: inventory
    inventory: chest
    title: Fire Glyph Recipie
    gui: true
    size: 45
    procedural items:
        - determine <list[].pad_right[45].with[black_stained_glass_pane]>
    slots:
        - [] [] [] [] [] [] [] [] []
        - [] [flint_and_steel] [air] [air] [] [] [] [] []
        - [] [paper] [ink_sac] [air] [] [] [] [fire_glyph] []
        - [] [air] [air] [air] [] [] [] [] []
        - [] [] [] [] [] [] [] [] []

display_fire_glyph_instructions:
    type: task
    script:
        - inventory open d:how_to_craft_fire_glyph_inventory

how_to_craft_invisible_glyph_inventory:
    type: inventory
    inventory: chest
    title: Invisible Glyph Recipie
    gui: true
    size: 45
    procedural items:
        - determine <list[].pad_right[45].with[black_stained_glass_pane]>
    slots:
        - [] [] [] [] [] [] [] [] []
        - [] [glass] [air] [air] [] [] [] [] []
        - [] [paper] [ink_sac] [air] [] [] [] [invisible_glyph] []
        - [] [air] [air] [air] [] [] [] [] []
        - [] [] [] [] [] [] [] [] []

display_invisible_glyph_instructions:
    type: task
    script:
        - inventory open d:how_to_craft_invisible_glyph_inventory

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