minetest.register_craft({
    output="living_mese:chaotic"
    { "default:gold_ingot",         "default:mese_crystal_shard",   "default:gold_ingot" },
    { "default:mese_crystal_shard", "default:sand",                 "default:mese_crystal_shard" },
    { "default:gold_ingot",         "default:mese_crystal_shard",   "default:gold_ingot" }
})

minetest.register_craft({
    output="living_mese:chaotic",
    type="shapeless",
    { "living_mese:chaotic", }
})