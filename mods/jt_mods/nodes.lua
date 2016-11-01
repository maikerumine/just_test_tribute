-- mods/jt_mods/nodes.lua
--Just Test Mods created by maikerumine
--inspired by Andrey "lag01" the creator of the original Just Test server.
-- Minetest 0.4.14 mod: "jt_mods"
-- namespace: jt_mods
--https://github.com/maikerumine

--License:
--~~~~~~~~
--Code:
--(c) Copyright 2016 maikerumine; modified zlib-License
--see "LICENSE.txt" for details.

--Media(if not stated differently):
--(c) Copyright (2014-2016) maikerumine; CC-BY-SA 3.0
--maikerumine added

minetest.register_node("jt_mods:lag_block", {
	description = "Show this around town to sho you love the original Just Test.  REMEMBER THE TEST.  Lag, This is a dedication block to your ideas, your server, and you.  My skuchayem i lyubyat vas.  WE MISS AND LOVE YOU!",
	tiles = {"default_water.png^treeprop.png^heart.png"},
	is_ground_content = false,
	walkable = false,
	light_source = default.LIGHT_MAX,
	groups = {immortal=1,cracky=1,not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("jt_mods:lag_ice", {
	description = "Lag's Ice  --THIS WILL MELT IN SUNLIGHT--",
	tiles = {"default_ice.png^default_glass_detail.png^[colorize:blue:80"},
	is_ground_content = false,
	paramtype = "light",
	groups = {cracky = 1, puts_out_fire = 1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("jt_mods:griefer_soul_block", {
	description = "A Block Of Griefer Souls",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"bones_front.png^[colorize:red:120", "bones_front.png^[colorize:red:120", "bones_front.png^[colorize:red:120"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1,dig_immediate=2},
	sounds =default.node_sound_wood_defaults(),
})

minetest.register_node("jt_mods:heart_block", {
	description = "Why's Heart Block",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_stone.png^heart.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1,dig_immediate=2},
	sounds =default.node_sound_wood_defaults(),
})

minetest.register_node("jt_mods:meselamp_white", {
	description = "Mese Lamp White",
	drawtype = "glasslike",
	tiles = {"light.png^default_obsidian_glass.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 2},
	sounds =default.node_sound_glass_defaults(),
	light_source = default.LIGHT_MAX,
})
