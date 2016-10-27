
--Andrey created mob for his world needs

	
mobs:register_mob("mobs:stone_monster", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	reach = 2,
	pathfinding = 1,
	hp_min = 10,
	hp_max = 15,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.9, 0.4},
	visual = "mesh",
	mesh = "mobs_stone_monster.x",
	textures = {{"mobs_stone_monster.png"}},
	blood_texture ="default_stone.png",
	visual_size = {x=3, y=2.6},
	makes_footstep_sound = true,
	view_range = 20,
	walk_velocity = 0.5,
	run_velocity = 1,
	damage = 2,
	floats = 0,
	
	drops = {
		{name = "default:mossycobble",
		chance = 3,
		min = 2,
		max = 5,},
		{name = "bones:bones",
			chance = 5,
			min = 0,
			max=1,
		},
	},
	light_resistant = true,
	armor = 80,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 1,
	light_damage = 100,
	attack_type = "dogfight",
	lifetimer=300,
	group_attack = true,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 14,
		walk_start = 15,
		walk_end = 38,
		run_start = 40,
		run_end = 63,
		punch_start = 40,
		punch_end = 63,
	}
})
--mobs:spawn_specfic(name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height, day_toggle, on_spawn)
--mobs:register_spawn("mobs_monster:dirt_monster",{"default:dirt_with_grass", "ethereal:gray_dirt"}, 7, 0, 7000, 1, 31000, false)
--mobs:register_spawn("mobs:stone_monster",{"default:stone", "default:desert_stone"}, 7, 0, 60, 8, 3100)
mobs:spawn_specific("mobs:stone_monster",{"default:stone", "default:desert_stone"}, {"air"},
	0, 4, 15, 2000, 20, 0, 31000)
	
if minetest.setting_get("log_mods") then
	minetest.log("action", "Just Test 2 mobs loaded")
end
