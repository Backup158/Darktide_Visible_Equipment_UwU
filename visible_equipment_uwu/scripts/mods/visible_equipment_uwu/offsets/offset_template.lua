local mod = get_mod("visible_equipment_uwu")

local vector3_box = Vector3Box

mod:add_global_localize_strings({
    loc_ve_TEMPLATE = {
        en = "NAME",
    }
})

return {
    offsets = {
        right = {
            node = "j_hips",
            position = vector3_box(0.005, -0.05, -0.069),
            rotation = vector3_box(-5, 0, 90),
        },
    },
    placements = "hip_back",
    placement_camera = {
        position = vector3_box(-1.2683889865875244, 2.639409065246582, 1.6318360567092896),
        rotation = 3.5,
    },
}