local minetest, nodecore, vector, math
    = minetest, nodecore, vector, math

local modname = minetest.get_current_modname()
local paper_fire = modname .. ":paper_fire"

function dump_t(obj)
    minetest.chat_send_all(dump(obj))
end

function fire_on_pos(pos, fire)

    local checkdirs = {
        {x = 1, y = 0, z = 0},
        {x = -1, y = 0, z = 0},
        {x = 0, y = 0, z = 1},
        {x = 0, y = 0, z = -1},
        {x = 0, y = 1, z = 0}
    }

    for i = 1, #fire do
        ::cycle::
        for n = 1, #fire[i] do
            ::element::
            if fire[i][n] == 0 then
                n = n + 1
                if n > #fire[i] then
                    i = i + 1
                    if i > #fire then
                        break
                    end
                    goto cycle
                end
                goto element
            end
            local center = math.floor(#fire / 2) + 1
            local fire_pos = {x = pos.x, z = pos.z + 2 - i, y = pos.y}
            
            local fire_node = ""
    
            if n < center then
                fire_pos.x = fire_pos.x - 1
                fire_node = minetest.get_node(fire_pos).name
            elseif n == center then
                fire_node = minetest.get_node(fire_pos).name
            else
                fire_pos.x = fire_pos.x + 1
                fire_node = minetest.get_node(fire_pos).name
            end

            if fire_node == "air" then 
                minetest.set_node(fire_pos, {name="nc_fire:fire"})
            else
                fire_pos.y = fire_pos.y + 1
                fire_node = minetest.get_node(fire_pos).name
                if fire_node == "air" then
                    minetest.set_node(fire_pos, {name="nc_fire:fire"})
                end
            end
            for _, ofst in pairs(checkdirs) do
                local npos = vector.add(fire_pos, ofst)
                local nbr = minetest.get_node(npos)
                if minetest.get_item_group(nbr.name, "flammable") > 0
                and not nodecore.quenched(npos) then
                    nodecore.fire_check_ignite(npos, nbr)
                end
            end
        end
    end
end

nodecore.register_on_punchnode("use fire paper", function(pos, node, puncher, pointed)
    if (not puncher) or (not puncher:is_player()) then return end
    local wield = puncher:get_wielded_item()
	if wield:get_name() ~= paper_fire then return end
    local anode = pointed.above

    local fire = { { 0, 1, 0 }, { 1, 0, 1 }, { 0, 1, 0} }
    fire_on_pos(pos, fire)
end)
