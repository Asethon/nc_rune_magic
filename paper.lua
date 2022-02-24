-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
local nodepref = "nc_writing:glyph"
local rush = "nc_flora:rush_dry"

minetest.register_craftitem(modname .. ":paper", {
    description = "Paper",
    inventory_image = modname .. "_paper.png"
})

minetest.register_node(modname .. ":paper", {
    description = "Paper",
    drawtype = "nodebox",
	node_box = nodecore.fixedbox(-8/16, -0.5, -0.5/16, 8/16, 0, 0),
	selection_box = nodecore.fixedbox(-8/16, -0.5, -0.5/16, 8/16, 0, 0),
    paramtype = "light",
	sunlight_propagates = true,
    tiles = {modname .. "_paper.png"},
    groups = {
        snappy = 1
    }
})

nodecore.register_craft({
    label = "paper",
    action = "pummel",
    toolgroups = {cracky = 1},
    indexkeys = { rush },
    nodes = { 
        { match = rush, replace = "air" },
        { x = -1, match = rush, replace = "air" },
        { x = 1, match = rush, replace = "air" }
     },
     items = { 
         { name = modname .. ":paper" }
     }
})


-------------------- PAPER FIRE -----------------------
minetest.register_craftitem(modname .. ":paper_fire", {
    description = "Paper",
    inventory_image = modname .. "_paper_fire.png"
})


minetest.register_node(modname .. ":paper_fire", {
    description = "Paper fire",
    drawtype = "nodebox",
	node_box = nodecore.fixedbox(-8/16, -0.5, -0.5/16, 8/16, 0, 0),
	selection_box = nodecore.fixedbox(-8/16, -0.5, -0.5/16, 8/16, 0, 0),
    paramtype = "light",
	sunlight_propagates = true,
    tiles = { modname .. "_paper_fire.png"},
    groups = {
        snappy = 1
    }
})

nodecore.register_craft({
    label = "paper fire",
    indexkeys = { modname .. ":paper" },
    nodes = { 
        -- "group:alpha_glyph"
        { match = modname .. ":paper", replace = "air" },
         { x = 1, match = "nc_writing:glyph1", replace = "air" },
         { z = -1, match = "nc_writing:glyph2", replace = "air" },
         { x = -1, match = "nc_writing:glyph3", replace = "air" }
     },
     items = { 
         { name = modname .. ":paper_fire" }
     }
})
-->>>>>>>>>>> PAPER FIRE >>>>>>>>>>>