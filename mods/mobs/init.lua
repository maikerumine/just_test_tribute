dofile(minetest.get_modpath("mobs").."/api.lua")

--Andrey created mob for his world needs
--maikerumine added to it

mobs:alias_mob("creatures:zombie_spawner_dummy", "mobs:just_test_griefer")
mobs:alias_mob("creatures:ghost_spawner_dummy", "mobs:just_test_griefer")
minetest.register_alias("creatures:zombie_spawner", "default:dirt")
minetest.register_alias("creatures:ghost_spawner", "default:dirt")
mobs:alias_mob("creatures:zombie", "mobs:just_test_griefer")
mobs:alias_mob("creatures:ghost", "mobs:just_test_griefer")
mobs:alias_mob("mobs:spider", "mobs:just_test_griefer")
mobs:alias_mob("mobs:sheep", "mobs:stone_monster")
mobs:alias_mob("mobs:jack", "mobs:stone_monster")
mobs:alias_mob("mobs:jack_junior", "mobs:stone_monster")
mobs:alias_mob("mobs:turkey", "mobs:stone_monster")
--meat
minetest.register_craftitem("mobs:meat", {
	description = "Cooked Meat",
	inventory_image = "mobs_meat.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craftitem("mobs:meat_raw", {
	description = "Raw Meat",
	inventory_image = "mobs_meat_raw.png",
})

minetest.register_craft({
	type = "cooking",
	output = "mobs:meat",
	recipe = "mobs:meat_raw",
})


minetest.register_alias("spidermob:meat", "default:meat")
minetest.register_alias("spidermob:meat_raw", "default:meat_raw")


minetest.register_alias("default:meat_raw", "mobs:meat_raw")
minetest.register_alias("default:meat", "mobs:meat")

-- Chicken by JK Murray

mobs:register_mob("mobs:turkey", {
	type = "animal",
	--full_name = Turkii,
	hp_max = 70,
	collisionbox = {-0.6, -2.1, -0.6, 0.6, 0.1, 0.6},
	visual_size = {x=3, y=3},
	visual = "mesh",
	mesh = "mobs_chicken.x",
	--textures = {"mobs_chicken_black.png"},
		textures = {
		"mobs_chicken_black.png", "mobs_chicken_black.png", "mobs_chicken_black.png", "mobs_chicken_black.png",
		"mobs_chicken_black.png", "mobs_chicken_black.png", "mobs_chicken_black.png", "mobs_chicken_black.png", "mobs_chicken_black.png",
	},
	makes_footstep_sound = true,
	view_range = 10,
	walk_velocity = 6,
	run_velocity = 2.5,
	damage = 1,
	lifetimer=300,
	drops = {
		{name = "mobs:meat_raw",
		chance = 20,
		min = 1,
		max = 2,
		},
		{name = "default:grass_1",
		chance = 20,
		min = 1,
		max = 2,
		},
	},

	
	bone_drops = {
		{name = "mobs:meat_raw",
		chance = 20,
		min = 1,
		max = 2,
		},
		{name = "default:grass_1",
		chance = 20,
		min = 1,
		max = 2,
		},
		{name = "farming:wheat",
		chance = 30,
		min = 1,
		max = 2,
		},
	},
	
	armor = 70,
	drawtype = "front",
	light_resistant = true,
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	attack_type = "dogfight",
	lifetimer=300,
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
--mobs:register_spawn("mobs:turkey", "default:dirt_with_grass", 20, 8, 19000, 2, 30, -100) --was48



--lags mobs

mobs:register_mob("mobs:griefer_ghost", {
	type = "monster",
	--full_name = Oerkii,
	hp_max = 20,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.9, 0.4},
	visual = "mesh",
	mesh = "mobs_oerkki.x",
	textures = {"mobs_oerkki.png"},
	visual_size = {x=5, y=5},
	makes_footstep_sound = true,
	view_range = 10,
	walk_velocity = 1,
	run_velocity = 3,
	damage = 1,
	lifetimer=300,
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
		{name = "bones:bones",
			chance = 5,
			min = 0,
			max=1,
		},
	},

	
	bone_drops = {
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
		chance = 30,
		min = 1,
		max = 2,
		},
	},
	
	armor = 60,
	drawtype = "front",
	light_resistant = true,
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	attack_type = "dogfight",
	lifetimer=30,
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
--function mobs:register_spawn_near(name, nodes, max_light, min_light, tries)
mobs:register_spawn_near("mobs:griefer_ghost", "default:stone", 4, -1, 2)

mobs:register_mob("mobs:stone_monster", {
	type = "monster",
	--full_name = Stoney,
	hp_max = 15,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.9, 0.4},
	visual = "mesh",
	mesh = "mobs_stone_monster.x",
	textures = {"mobs_stone_monster.png"},
	visual_size = {x=3, y=2.6},
	makes_footstep_sound = true,
	view_range = 10,
	walk_velocity = 0.5,
	run_velocity = 1,
	damage = 2,
	
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
	
	bone_drops = {
		{name = "default:mossycobble",
		chance = 3,
		min = 2,
		max = 5,
		},
		{name = "default:papyrus",
		chance = 30,
		min = 2,
		max = 5,
		},
		--{name = "default:grass_1",
		--chance = 20,
		--min = 1,
		--max = 2,
		--},
	},
	light_resistant = true,
	armor = 60,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	attack_type = "dogfight",
	lifetimer=300,
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
--function mobs:register_spawn(name, nodes, max_light, min_light, chance, active_object_count, max_height, min_height, spawn_func)
--mobs:register_spawn("mobs:stone_monster", "default:stone", 3, -1, 9000, 20 500, 0) --was48
mobs:register_spawn("mobs:stone_monster", "default:stone", 3, -1, 9000, 48, 500, 0) --was48
mobs:register_spawn("mobs:stone_monster", "default:desert_stone", 3, -1, 9000, 48, 500, 0) --was48

-------------------------
--BAD NPC
-------------------------
mobs:register_mob("mobs:just_test_griefer", {
	type = "monster",
	--hp_min = 35,
	hp_max = 20,
	collisionbox = {-0.3, -1.0, -0.3, 0.3, 0.8, 0.3},
	visual = "mesh",
	mesh = "3d_armor_character.b3d",
	--mesh = "character.x",
	--textures = {"character_32.png"},
	--[[]]
	textures = {
	"character_32.png",
	"3d_armor_trans.png",
	minetest.registered_items["default:sword_steel"].inventory_image,
	},
	--[[]]		
			
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	view_range = 10,
	walk_velocity = 2.5,
	run_velocity = 3,
	damage = 2,
	drops = {
		{name = "jt_mods:griefer_soul",
		chance = 7,
		min = 1,
		max = 1,},
		{name = "default:sword_mese",
		chance = 5,
		min = 0,
		max = 1,},
		{name = "default:stick",
			chance = 2,
			min = 0,
			max=3,},

	},
	bone_drops = {
		{name = "jt_mods:griefer_soul",
		chance = 7,
		min = 1,
		max = 1,},
		{name = "default:sword_steel",
		chance = 5,
		min = 0,
		max = 1,},
		{name = "default:stick",
		chance = 2,
		min = 1,
		max=12,},
	},
	light_resistant = true,
	armor = 60,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 1,
	light_damage = 1,
	attack_type = "dogfight",
	lifetimer=300,
	animation = {
		speed_normal = 30,		speed_run = 30,
		stand_start = 0,		stand_end = 79,
		walk_start = 168,		walk_end = 187,
		run_start = 168,		run_end = 187,
		punch_start = 200,		punch_end = 219,
	},
})
mobs:register_spawn("mobs:just_test_griefer", "default:cobble", 4, -1, 9000, 1, 500, -60) --was48

--[[
mobs:register_mob("mobs:jack", {
	type = "monster",
	hp_max = 25,
	collisionbox = {-0.75, -0.75, -0.75, 0.75, 0.75, 0.75},
	visual_size = {x=1.5, y=1.5},

	textures = {
	--{
	"farming_pumpkin_top.png",
	"farming_pumpkin_top.png",
	"farming_pumpkin_side.png",
	"farming_pumpkin_side.png",
	"farming_pumpkin_face_on.png",
	"farming_pumpkin_side.png"
	--}
	},
	
	--textures = {"farming_pumpkin_face_on.png"},
	visual = "cube",
	blood_texture ="farming_pumpkin_side.png",
	--rotate = 270,
	makes_footstep_sound = true,
	walk_velocity = .8,
	run_velocity = 1.6,
	damage = 3,
	armor = 100,
	drops = {
		{name = "default:leaves",
		chance = 2,
		min = 1,
		max = 1,},
		{name = "default:pumpkin_slice",
		chance = 3,
		min = 1,
		max = 5,},
	},
	bone_drops = {
		{name = "default:pumpkin_slice",
		chance = 9,
		min = 1,
		max = 4,},
		
	},
	
	animation = {
		speed_normal = 24,
		speed_run = 48,
		stand_start = 0,
		stand_end = 23,
		walk_start = 24,
		walk_end = 47,
		run_start = 48,
		run_end = 62,
		hurt_start = 64,
		hurt_end = 86,
		death_start = 88,
		death_end = 118,
	},
	drawtype = "front",
	water_damage = 0,
	lava_damage = 10,
	light_damage = 0,
	view_range = 16,
	attack_type = "dogfight",
	lifetimer=300,
	
	on_die =function(self, pos)
		lavasmall = minetest.add_entity(self.object:getpos(), "mobs:stone_monster")
		lavasmall = minetest.add_entity(self.object:getpos(), "mobs:stone_monster")
			ent = lavasmall:get_luaentity()
			end
			
})
mobs:register_spawn("mobs:jack",  "default:mossycobble", 4, -1, 9000, 2, 500, 0)
]]

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
--function mobs:register_spawn_near(name, nodes, max_light, min_light, tries)
--mobs:register_spawn("mobs:griefer_ghost", "mobs:cursed_stone", 4, -1, 2, 16,500, -500)  --was40
mobs:register_spawn("mobs:griefer_ghost", "mobs:cursed_stone", 4, -1, 2, 16,40, -500)  --was40


if minetest.setting_get("log_mods") then
	minetest.log("action", "mobs loaded")
end
