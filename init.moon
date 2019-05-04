dofile minetest.get_modpath 'living_mese' .. '/recipes.lua'

minetest.register_node 'fooblock:fooblock',
  description: 'foo'
  tiles:
    'fooblock.png'
  groups:
    oddly_breakable_by_hand: 1

sand  = 'default:sand'
mfrag = 'default:mese_crystal_fragment'

minetest.register_craft
  output: 'fooblock:fooblock'
  recipe:
    [1]: { sand, mfrag, sand }
    [2]: { sand, mfrag, sand }
    [3]: { sand, sand,  sand }

foo = true

neighbor_pos = (pos, number) ->
  a =
    [1]: { pos.x, pos.y + 1, pos.z }
    [2]: { pos.x, pos.y - 1, pos.z }
    [3]: { pos.x + 1, pos.y, pos.z }
    [4]: { pos.x - 1, pos.y, pos.z }
    [5]: { pos.x, pos.y, pos.z + 1 }
    [6]: { pos.x, pos.y, pos.z - 1 }

  a[number]

get_neighbors = (pos) ->
  with pos
    count = 0
    nodes =
      [1]: (minetest.get_node { x: .x + 1, y: .y,     z: .z     }).name
      [2]: (minetest.get_node { x: .x,     y: .y + 1, z: .z     }).name
      [3]: (minetest.get_node { x: .x,     y: .y,     z: .z + 1 }).name
      [4]: (minetest.get_node { x: .x - 1, y: .y,     z: .z     }).name
      [5]: (minetest.get_node { x: .x,     y: .y - 1, z: .z     }).name
      [6]: (minetest.get_node { x: .x,     y: .y,     z: .z - 1 }).name

    for n in *nodes
      count += 1 if n != 'air'

    { :count, :nodes }

