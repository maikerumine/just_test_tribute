
-- Spider by AspireMint (fishyWET (CC-BY-SA 3.0 license for texture)
mobs:register_mob("mobs:spider", {
	type = "monster",
	docile_by_day = true,
	pathfinding = 1,
	reach = 1,
	hp_min = 15,
	hp_max = 30,
	collisionbox = {-0.9, -0.01, -0.7, 0.7, 0.6, 0.7},
	textures = {
	{"mobs_spider.png"}
	},
	visual_size = {x=7,y=7},
	visual = "mesh",
	mesh = "spider_model.x",
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 3,
    armor = 200,
	damage = 3,
	drops = {
		{name = "farming:string",
		chance = 2,
		min = 1,
		max = 3,},
		{name = "mobs:meat_raw",
		chance = 4,
		min = 1,
		max = 2,},		
	},
    light_resistant = true,
	drawtype = "front",
	water_damage = 5,
	lava_damage = 5,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 1,
		stand_end = 1,
		walk_start = 20,
		walk_end = 40,
		run_start = 20,
		run_end = 40,
		punch_start = 50,
		punch_end = 90,
	},
	jump = true,
	step = 1,
	blood_texture = "mobs_blood.png",
	sounds = {
		war_cry = "mobs_eerie",
		death = "mobs_howl",
		attack = "mobs_oerkki_attack",
	},
})
--spidermob:register_spawn("spidermob:spider", {"default:junglegrass", "default:jungleleaves", "default:leaves","default:jungletree"}, 5, -1, 7500, 1, 31000)  --was light 20,-10
mobs:spawn_specific("mobs:spider", {"default:junglegrass", "default:jungleleaves", "default:jungletree"}, {"air"},
	0, 5, 35, 4000, 2, -10, 31000)
	
mobs:alias_mob("spidermob:spider", "mobs:spider")
	
if minetest.setting_get("log_mods") then
	minetest.log("action", "Just Test 2 mobs loaded")
end
