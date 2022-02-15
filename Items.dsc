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