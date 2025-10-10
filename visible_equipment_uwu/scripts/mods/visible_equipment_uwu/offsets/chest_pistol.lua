local mod = get_mod("visible_equipment_uwu")

local vector3_box = Vector3Box

mod:add_global_localize_strings({
    loc_ve_uwu_chest_pistol = {
        en = "Chest Pistol",
    }
})

return {
    offsets = {
        right = {
            node = "j_hips",
            position = vector3_box(0.04, 0.17, 0.4),
            rotation = vector3_box(-15, -40, 90),
        },
    },
    placements = "chest_pistol",
    placement_camera = {
        position = vector3_box(-1.258, 2.639, 1.632),
        rotation = 0.5,
    },
}