dofile(minetest.get_modpath('living_mese' .. '/recipes.lua'))
minetest.register_node('fooblock:fooblock', {
  description = 'foo',
  tiles = 'fooblock.png',
  groups = {
    oddly_breakable_by_hand = 1
  }
})
local sand = 'default:sand'
local mfrag = 'default:mese_crystal_fragment'
minetest.register_craft({
  output = 'fooblock:fooblock',
  recipe = {
    [1] = {
      sand,
      mfrag,
      sand
    },
    [2] = {
      sand,
      mfrag,
      sand
    },
    [3] = {
      sand,
      sand,
      sand
    }
  }
})
local foo = true
local neighbor_pos
neighbor_pos = function(pos, number)
  local a = {
    [1] = {
      pos.x,
      pos.y + 1,
      pos.z
    },
    [2] = {
      pos.x,
      pos.y - 1,
      pos.z
    },
    [3] = {
      pos.x + 1,
      pos.y,
      pos.z
    },
    [4] = {
      pos.x - 1,
      pos.y,
      pos.z
    },
    [5] = {
      pos.x,
      pos.y,
      pos.z + 1
    },
    [6] = {
      pos.x,
      pos.y,
      pos.z - 1
    }
  }
  return a[number]
end
local get_neighbors
get_neighbors = function(pos)
  do
    local _with_0 = pos
    local count = 0
    local nodes = {
      [1] = (minetest.get_node({
        x = _with_0.x + 1,
        y = _with_0.y,
        z = _with_0.z
      })).name,
      [2] = (minetest.get_node({
        x = _with_0.x,
        y = _with_0.y + 1,
        z = _with_0.z
      })).name,
      [3] = (minetest.get_node({
        x = _with_0.x,
        y = _with_0.y,
        z = _with_0.z + 1
      })).name,
      [4] = (minetest.get_node({
        x = _with_0.x - 1,
        y = _with_0.y,
        z = _with_0.z
      })).name,
      [5] = (minetest.get_node({
        x = _with_0.x,
        y = _with_0.y - 1,
        z = _with_0.z
      })).name,
      [6] = (minetest.get_node({
        x = _with_0.x,
        y = _with_0.y,
        z = _with_0.z - 1
      })).name
    }
    for _index_0 = 1, #nodes do
      local n = nodes[_index_0]
      if n ~= 'air' then
        count = count + 1
      end
    end
    local _ = {
      count = count,
      nodes = nodes
    }
    return _with_0
  end
end
