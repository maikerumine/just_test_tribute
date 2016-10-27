	
mobs:register_mob("mobs:jack", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	pathfinding = 1,
	reach = 2,
	hp_min = 19,
	hp_max = 25,
	collisionbox = {-0.75, -0.75, -0.75, 0.75, 0.75, 0.75},
	visual_size = {x=1.5, y=1.5},

	--JACKS SEASONAL TEXTURE
	textures = {
	{
	"farming_pumpkin_top.png",
	"farming_pumpkin_top.png",
	"farming_pumpkin_side.png",
	"farming_pumpkin_side.png",
	"farming_pumpkin_face_on.png",
	"farming_pumpkin_side.png"
	}
	},
	
	--[[
	--JACKS NORMAL TEXTURE
	textures = {
	{
	"default_stone.png^crack_anylength.png",
	"default_stone.png",
	"default_stone.png",
	"default_stone.png",
	"default_stone.png^heart.png^[colorize:black:120",
	"default_stone.png"
	}
	},
	]]
	
	visual = "cube",
	blood_texture ="default_stone.png",
	--rotate = 270,
	makes_footstep_sound = true,
	walk_velocity = .8,
	run_velocity = 2.6,
	damage = 2,
	armor = 100,
	drops = {
		{name = "default:jungleleaves",
		chance = 2,
		min = 1,
		max = 1,},		
		{name = "default:leaves",
		chance = 2,
		min = 1,
		max = 1,},
		{name = "default:stick",
		chance = 22,
		min = 1,
		max = 2,},
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
	fear_height = 12,
	fall_speed = -4,
	jump = true,
	jump_height = 6,
	runaway = true,
	
	attack_type = "dogfight",
	lifetimer=300,
	group_attack = true,
	
	on_die =function(self, pos)
		jacksmall = minetest.add_entity(self.object:getpos(), "mobs:jack_junior")
		jacksmall = minetest.add_entity(self.object:getpos(), "mobs:jack_junior")
		jacksmall = minetest.add_entity(self.object:getpos(), "mobs:jack_junior")
		jacksmall = minetest.add_entity(self.object:getpos(), "mobs:jack_junior")
			ent = jacksmall:get_luaentity()
			end
			
})
--mobs:spawn_specfic(name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height, day_toggle, on_spawn)
--mobs:register_spawn("mobs_monster:dirt_monster",{"default:dirt_with_grass", "ethereal:gray_dirt"}, 7, 0, 7000, 1, 31000, false)
--mobs:register_spawn("mobs:jack", {"default:mossycobble"}, 7, 0, 50, 2, 31000)
mobs:spawn_specific("mobs:jack", {"default:mossycobble"}, {"air"},
	0, 6, 35, 3000, 2, -1, 31000)
	
mobs:register_mob("mobs:jack_junior", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	pathfinding = 1,
	reach = 1,
	hp_min = 4,
	hp_max = 8,
	collisionbox = {-0.375, -0.375, -0.375, 0.375, 0.375, 0.375},
	visual_size = {x=0.75, y=0.75},
	
	--JACKS SEASONAL TEXTURE
	textures = {
	{
	"farming_pumpkin_top.png",
	"farming_pumpkin_top.png",
	"farming_pumpkin_side.png",
	"farming_pumpkin_side.png",
	"farming_pumpkin_face_on.png",
	"farming_pumpkin_side.png"
	}
	},
	
	--[[
	--JACKS NORMAL TEXTURE
	textures = {
	{
	"default_stone.png^crack_anylength.png",
	"default_stone.png",
	"default_stone.png",
	"default_stone.png",
	"default_stone.png^heart.png^[colorize:black:120",
	"default_stone.png"
	}
	},
	]]
	visual = "cube",
	blood_texture ="default_stone.png",
	--rotate = 270,
	makes_footstep_sound = true,
	walk_velocity = 2.8,
	run_velocity = 3.1,
	damage = 1,
	armor = 100,
	drops = {
		{name = "default:stone",
		chance = 1,
		min = 1,
		max = 2,},
		{name = "mt_seasons:pumpkin_slice",
		chance = 1,
		min = 1,
		max = 2,},
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
	fear_height = 2,
	fall_speed = -4,
	jump = true,
	jump_height = 3,
	runaway = true,
	
	attack_type = "dogfight",
	lifetimer=300,
	group_attack = true,
	--[[
	on_die =function(self, pos)
		jacksmall = minetest.add_entity(self.object:getpos(), "mobs:little_jack")
		jacksmall = minetest.add_entity(self.object:getpos(), "mobs:little_jack")
			ent = jacksmall:get_luaentity()
			end
		]]	
})

	
if minetest.setting_get("log_mods") then
	minetest.log("action", "Just Test 2 mobs loaded")
end
