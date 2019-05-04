dofile(minetest.get_modpath("living_mese") .. "/recipes.lua")

minetest.register_node("fooblock:fooblock", {
  description="foo",
  tiles={"fooblock.png"},
  groups={oddly_breakable_by_hand = 1}
})

local sand = "default:sand"
local mfrag = "default:mese_crystal_fragment"
minetest.register_craft({
    output="fooblock:fooblock",
    recipe = {
    {sand,    mfrag,  sand},
    {mfrag,  sand,    mfrag},
    {sand,    mfrag,  sand},
}})

foo = true

function neighbor_pos(pos, number)
    
    return {
        [1] = {pos.x,   pos.y+1,  pos.z},
        [2] = {pos.x,   pos.y-1,  pos.z},
        [3] = {pos.x+1,   pos.y,  pos.z},
        [4] = {pos.x-1,   pos.y,  pos.z},
        [5] = {pos.x,   pos.y,  pos.z+1},
        [6] = {pos.x,   pos.y,  pos.z-1}
    }[number]
end

function get_neighbors(pos)
    local x, y, z = pos.x, pos.y, pos.z
    local count = 0;
    local nodes = { false, false, false, false, false, false }

    if minetest.get_node({ x=x+1,  y=y,    z=z   }).name == "fooblock:fooblock" then
        count = count + 1
        nodes[1] = true
    end
    if minetest.get_node({ x=x,    y=y+1,  z=z   }).name == "fooblock:fooblock" then
        count = count + 1
        nodes[2] = true
    end
    if minetest.get_node({ x=x,    y=y,    z=z+1 }).name == "fooblock:fooblock" then
        count = count + 1
        nodes[3] = true
    end
    if minetest.get_node({ x=x-1,  y=y,    z=z   }).name == "fooblock:fooblock" then
        count = count + 1
        nodes[4] = true
    end
    if minetest.get_node({ x=x,    y=y-1,  z=z   }).name == "fooblock:fooblock" then
        count = count + 1
        nodes[5] = true
    end
    if minetest.get_node({ x=x,    y=y,    z=z-1 }).name == "fooblock:fooblock" then
        count = count + 1
        nodes[6] = true
    end

    return {count = count, nodes}
end


function random_offset(pos)
    local x, y, z = pos.x, pos.y, pos.z
    local random = math.random(0,5)
    if random == 0 then
        return { x=x+1, y=y, z=z}
    end
    if random == 1 then
        return { x=x, y=y+1, z=z}
    end
    if random == 2 then
        return { x=x, y=y, z=z+1}
    end
    if random == 3 then
        return { x=x-1, y=y, z=z}
    end
    if random == 4 then
        return { x=x, y=y-1, z=z}
    end
    if random == 5 then
        return { x=x, y=y, z=z-1}
    end
end

function reproduce(pos)
    local x, y, z = pos.x, pos.y, pos.z
    local offspring_pos

    if not minetest.get_node({ x=x,    y=y+1,  z=z   }).name == "fooblock:fooblock" then
        offsping_pos = { x=x,    y=y+1,  z=z   }
    elseif not minetest.get_node({ x=x,    y=y-1,  z=z   }).name == "fooblock:fooblock" then
        offspring_pos = { x=x,    y=y-1,  z=z   }
    elseif not minetest.get_node({ x=x+1,  y=y,    z=z   }).name == "fooblock:fooblock" then
        offspring_pos = { x=x+1,  y=y,    z=z   }
    elseif not minetest.get_node({ x=x-1,  y=y,    z=z   }).name == "fooblock:fooblock" then
        offspring_pos = { x=x-1,  y=y,    z=z   }
    elseif not minetest.get_node({ x=x,    y=y,    z=z+1 }).name == "fooblock:fooblock" then
        offspring_pos = { x=x,    y=y,    z=z+1 }
    elseif not minetest.get_node({ x=x,    y=y,    z=z-1 }).name == "fooblock:fooblock" then
        offspring_pos = { x=x,    y=y,    z=z-1 }
    end

    minetest.add_node(offspring_pos, {name="fooblock:fooblock"})
end

minetest.register_abm({
    nodenames="fooblock:fooblock",
    interval=3,
    chance=1,
    action=function(pos)
        if foo == false then
            minetest.add_node(pos, {name="air"})
            return 
        end

        local neighbors = get_neighbors(pos)

        if neighbors.count  >= 2 then
            minetest.add_node(pos, {name = "air"})
            return
        end

        if neighbors.count >= 1 then
            reproduce(pos)
            return
        end

        if neighbors.count == 0 then
            minetest.add_node(pos, {name = "air"})
        end
    end
})

minetest.register_chatcommand("no_foo", {
    description="no_foo: No more foo",
    func=function(_,_)
        foo = false
    end
})

minetest.register_chatcommand("foo_again", {
    description="foo_again: foo",
    func=function(_,_)
        foo = true
    end
})