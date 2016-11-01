-- mods/jt_mods/tools.lua
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

minetest.register_tool("jt_mods:pick_obsidian", {
	description = "Obsidian Pickaxe",
	inventory_image = "jt_mods_tool_obsidianpick.png",
	tool_capabilities = {
		full_punch_interval = 0.1,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=0.3, [2]=0.2, [3]=0.05}, uses=3, maxlevel=3},
		},
		damage_groups = {fleshy=6},
	},
})

minetest.register_tool("jt_mods:pick_admin", {
	description = "ADMIN Obsidian Pickaxe",
	inventory_image = "jt_mods_tool_obsidianpick.png",
	tool_capabilities = {
		full_punch_interval = 0.1,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=0.3, [2]=0.2, [3]=0.05}, uses=3000, maxlevel=3},
			crumbly = {times={[1]=0.3, [2]=0.2, [3]=0.05}, uses=3000, maxlevel=3},
			snappy = {times={[1]=0.3, [2]=0.2, [3]=0.05}, uses=3000, maxlevel=3},
			choppy = {times={[1]=0.3, [2]=0.2, [3]=0.05}, uses=3000, maxlevel=3},
		},
		damage_groups = {fleshy=60},
	},
})


