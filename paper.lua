-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
local nodepref = "nc_writing:glyph"

function add_paper_type(name, description, tile)
    minetest.register_craftitem(name, {
        description = description,
        inventory_image = tile
    })

    minetest.register_node(name, {
        description = description,
        drawtype = "nodebox",
        node_box = {-8/16, -0.5, -0.5/16, 8/16, 0, 0},
        selection_box = {-8/16, -0.5, -0.5/16, 8/16, 0, 0},
        tiles = { tile },
        groups = {
            snappy = 1
        }
    })
end

function register_craft(label, item_name, ...)
    nodecore.register_craft({
        label = label,
        indexkeys = { modname .. ":paper" },
        nodes = { 
            { match = modname .. ":paper", replace = "air" },
             { x = 1, match = nodepref .. "1", replace = "air" },
             { z = -1, match = nodepref .. "2", replace = "air" },
             { x = -1, match = nodepref .. "3", replace = "air" }
         },
         items = { 
             { name = item_name, count = ... }
         }
    })
end

add_paper_type(
    modname .. ":paper",
    "Paper",
    modname .. "_paper.png"
)

nodecore.register_craft({
    label = "paper",
    action = "pummel",
    toolgroups = {cracky = 1},
    indexkeys = { "nc_flora:rush_dry" },
    nodes = { 
        { match = "nc_flora:rush_dry", replace = "air" },
        { x = -1, match = "nc_flora:rush_dry", replace = "air" },
        { x = 1, match = "nc_flora:rush_dry", replace = "air" }
     },
     items = { 
         { name = modname .. ":paper" }
     }
})


add_paper_type(
    modname .. ":paper_fire",
    "Paper fire",
    modname .. "_paper_fire.png"
)

register_craft("paper fire", modname .. ":paper_fire")
-->>>>>>>>>>> PAPER FIRE >>>>>>>>>>>