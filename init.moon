neighbor_pos = (pos, number) ->
  a = {
    { x: pos.x,     y: pos.y + 1, z: pos.z }
    { x: pos.x,     y: pos.y - 1, z: pos.z }
    { x: pos.x + 1, y: pos.y,     z: pos.z }
    { x: pos.x - 1, y: pos.y,     z: pos.z }
    { x: pos.x,     y: pos.y,     z: pos.z + 1 }
    { x: pos.x,     y: pos.y,     z: pos.z - 1 }
  }

  a[number]

get_neighbors = (pos) ->
  with pos
    count = 0
    nodes = {
      (minetest.get_node { x: .x + 1, y: .y,     z: .z     })
      (minetest.get_node { x: .x,     y: .y + 1, z: .z     })
      (minetest.get_node { x: .x,     y: .y,     z: .z + 1 })
      (minetest.get_node { x: .x - 1, y: .y,     z: .z     })
      (minetest.get_node { x: .x,     y: .y - 1, z: .z     })
      (minetest.get_node { x: .x,     y: .y,     z: .z - 1 })
    }

    for n in *nodes
      count += 1 if n.name == 'living_mese:chaotic'

    return { :count, :nodes }



-- TODO: Move scripts below to ./strands/chaotic_mese.moon when I learn how


chaotic_step = (pos, node, active_object_count, active_object_count_wider) -> 
  neighbors = get_neighbors(pos)

  if neighbors.count >=4
    minetest.set_node(pos, { name:'air' })
    return

  if neighbors.count >= 1
    minetest.set_node(neighbor_pos(pos, math.random(1,5)), { name:'living_mese:chaotic' })
    return

  minetest.set_node(pos, { name:'air' })
  

minetest.register_node 'living_mese:chaotic',
  description: 'chaotic living mese'
  tiles:
    { 'lines3_chaotic.png' }
  groups:
    oddly_breakable_by_hand: 1

minetest.register_node 'living_mese:mese_repellant',
  description: 'Farmer\'s Totem'
  tiles:
    { 'lines.png' }
  groups:
    oddly_breakable_by_hand: 1

minetest.register_craft
  output: 'living_mese:chaotic'
  recipe: {
    { 'default:mese_crystal_fragment', 'group:cracky', 'default:mese_crystal_fragment' }
    { 'group:cracky',         'default:mese_crystal_fragment', 'group:cracky' }
    { 'default:mese_crystal_fragment', 'group:cracky',  'default:mese_crystal_fragment' }
  }
  

minetest.register_abm 
  label: 'Chaotic living mese'
  nodenames: { 'living_mese:chaotic'}
  interval: 3
  chance: 1
  action: chaotic_step