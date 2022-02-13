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