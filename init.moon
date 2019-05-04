minetest.register_node 'living_mese:fooblock',
  description: 'foo'
  tiles:
    { 'lines3_chaotic.png' }
  groups:
    oddly_breakable_by_hand: 1

sand  = 'default:sand'
mfrag = 'default:mese_crystal_fragment'

minetest.register_craft
  output: 'living_mese:fooblock'
  recipe: {
    { sand, mfrag, sand }
    { sand, mfrag, sand }
    { sand, sand,  sand }
  }

neighbor_pos = (pos, number) ->
  a = {
    { pos.x, pos.y + 1, pos.z }
    { pos.x, pos.y - 1, pos.z }
    { pos.x + 1, pos.y, pos.z }
    { pos.x - 1, pos.y, pos.z }
    { pos.x, pos.y, pos.z + 1 }
    { pos.x, pos.y, pos.z - 1 }
  }

  a[number]

get_neighbors = (pos) ->
  with pos
    count = 0
    nodes = {
      (minetest.get_node { x: .x + 1, y: .y,     z: .z     }).name
      (minetest.get_node { x: .x,     y: .y + 1, z: .z     }).name
      (minetest.get_node { x: .x,     y: .y,     z: .z + 1 }).name
      (minetest.get_node { x: .x - 1, y: .y,     z: .z     }).name
      (minetest.get_node { x: .x,     y: .y - 1, z: .z     }).name
      (minetest.get_node { x: .x,     y: .y,     z: .z - 1 }).name
    }

    for n in *nodes
      count += 1 if n != 'air'

    { :count, :nodes }

