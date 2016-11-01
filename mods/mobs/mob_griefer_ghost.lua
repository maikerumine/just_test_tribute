
--Andrey created mob for his world needs


mobs:register_mob("mobs:griefer_ghost", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	reach = 2,
	pathfinding =1,
	hp_max = 20,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.9, 0.4},
	visual = "mesh",
	mesh = "mobs_oerkki.x",
	textures = {{"mobs_oerkki.png"}},
	blood_texture ="default_coal_lump.png^[colorize:red:120",
	visual_size = {x=5, y=5},
	makes_footstep_sound = true,
	view_range = 10,
	walk_velocity = 1,
	run_velocity = 3,
	damage = 1,

	drops = {
		{name = "default:junglegrass",
		chance = 20,
		min = 1,
		max = 2,
		},
		{name = "default:grass_1",
		chance = 20,
		min = 1,
		max = 2,
		},
		{name = "default:cactus",
			chance = 5,
			min = 0,
			max=1,
		},
	},	
	armor = 60,
	drawtype = "front",
	light_resistant = true,
	water_damage = 0,
	lava_damage = 1,
	light_damage = 1,
	attack_type = "dogfight",
	lifetimer=30,
	group_attack = true,
	animation = {
		stand_start = 0,
		stand_end = 23,
		walk_start = 24,
		walk_end = 36,
		run_start = 37,
		run_end = 49,
		punch_start = 37,
		punch_end = 49,
		speed_normal = 15,
		speed_run = 15,
	},
	follow="",
	jump=true,

})

--mobs:spawn_specfic(name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height, day_toggle, on_spawn)
--mobs:register_spawn("mobs_monster:dirt_monster",{"default:dirt_with_grass", "ethereal:gray_dirt"}, 7, 0, 7000, 1, 31000, false)
--mobs:register_spawn("mobs:griefer_ghost", {"default:stone"}, 7, 0, 7000, 1, 3100)
mobs:spawn_specific("mobs:griefer_ghost", {"default:stone"}, {"air"},
	0, 7, 35, 7000, 1, -4550, 31000)




minetest.register_node("mobs:cursed_stone", {
	description = "Cursed stone",
	tiles = {
		"mobs_cursed_stone_top.png",
		"mobs_cursed_stone_bottom.png",
		"mobs_cursed_stone.png",
		"mobs_cursed_stone.png",
		"mobs_cursed_stone.png",
		"mobs_cursed_stone.png"
	},
	is_ground_content = false,
	groups = {cracky=1, level=2},
	drop = 'default:goldblock',
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'mobs:cursed_stone',
	recipe = {
		{'default:obsidian', 'default:obsidian', 'default:obsidian'},
		{'default:obsidian', 'default:goldblock', 'default:obsidian'},
		{'default:obsidian', 'default:obsidian', 'default:obsidian'},
	}
})
--mobs:spawn_specfic(name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height, day_toggle, on_spawn)
mobs:spawn_specific("mobs:griefer_ghost", {"mobs:cursed_stone"}, {"air"},
	0, 5, 5, 3, 8, -520, 31000)

	
if minetest.setting_get("log_mods") then
	minetest.log("action", "Just Test 2 mobs loaded")
end
