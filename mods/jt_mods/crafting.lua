-- mods/jt_mods/crafting.lua
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



minetest.override_item("default:gold_ingot", {
	description = "Gold Ingot",
	inventory_image = "default_gold_ingot.png",
	stack_max = 999,
})


--hehe change up the craft ;-)
minetest.register_craft({
	output = 'default:desert_cobble 8',
	recipe = {
		{'default:cobble', 'default:cobble', 'default:cobble'},
		{'default:cobble', 'dye:red', 'default:cobble'},
		{'default:cobble', 'default:cobble', 'default:cobble'},
	}
})
minetest.register_craft({
	output = 'default:desert_sand 8',
	recipe = {
		{'default:sand', 'default:sand', 'default:sand'},
		{'default:sand', 'dye:orange', 'default:sand'},
		{'default:sand', 'default:sand', 'default:sand'},
	}
})

minetest.register_craft({
	output = 'default:silver_sand 8',
	recipe = {
		{'default:sand', 'default:sand', 'default:sand'},
		{'default:sand', 'dye:white', 'default:sand'},
		{'default:sand', 'default:sand', 'default:sand'},
	}
})
-- Minetest 0.4 mod: apple_sapling
-- Craft a tree sapling from dirt and apple.
-- 
-- maikerumine
minetest.register_craft({
	output = 'default:sapling',
	recipe = {
		{"default:dirt", "default:dirt", "default:dirt"},
		{"default:dirt", "default:apple", "default:dirt"},
		{"default:dirt", "default:dirt", "default:dirt"},
	},
})

minetest.register_craft({
	output = 'default:junglesapling',
	recipe = {
		{"group:leaves", "default:junglegrass", "group:leaves"},
		{"default:junglegrass", "default:sapling", "default:junglegrass"},
		{"group:leaves", "default:junglegrass", "group:leaves"},
	},
})

minetest.register_craft({
	output = 'default:pine_sapling',
	recipe = {
		{"group:leaves", "default:sand", "group:leaves"},
		{"default:sand", "default:junglesapling", "default:sand"},
		{"group:leaves", "default:sand", "group:leaves"},
	},
})

minetest.register_craft({
	output = 'default:acacia_sapling',
	recipe = {
		{"group:leaves", "default:dry_shrub", "group:leaves"},
		{"default:dry_shrub", "default:pine_sapling", "default:dry_shrub"},
		{"group:leaves", "default:dry_shrub", "group:leaves"},
	},
})

minetest.register_craft({
	output = 'default:aspen_sapling',
	recipe = {
		{"group:leaves", "default:papyrus", "group:leaves"},
		{"default:papyrus", "default:acacia_sapling", "default:papyrus"},
		{"group:leaves", "default:papyrus", "group:leaves"},
	},
})

minetest.register_craft({
	type = "cooking",
	output = "default:dry_shrub",
	recipe = "default:junglegrass",
})

--Lag Block
--maikerumine
minetest.register_craft({
	output = 'jt_mods:lag_block',
	recipe = {
		{"default:dirt_with_grass", "default:desert_stonebrick", "default:bronze_ingot"},
		{"default:diamondblock", "default:ice", "default:snowblock"},
		{"default:pick_diamond", "default:sandstonebrick", "default:obsidian"},
	},
	
})
minetest.register_craft({
	output = 'jt_mods:heart_block',
	recipe = {
		{"default:stone", "default:stone", "default:stone"},
		{"default:stone", "default:apple", "default:stone"},
		{"default:stone", "default:stone", "default:stone"},
	},
})



minetest.register_craft({
	output = 'jt_mods:lag_ice',
	recipe = {
		{'default:snowblock', 'default:snowblock', 'default:snowblock'},
		{'default:snowblock', 'bucket:bucket_water', 'default:snowblock'},
		{'default:snowblock', 'default:snowblock', 'default:snowblock'},
	}
})

minetest.register_craft({
	output = 'default:ice',
	recipe = {
		{'jt_mods:lag_ice', 'jt_mods:lag_ice', 'jt_mods:lag_ice'},
		{'jt_mods:lag_ice', 'bucket:bucket_water', 'jt_mods:lag_ice'},
		{'jt_mods:lag_ice', 'jt_mods:lag_ice', 'jt_mods:lag_ice'},
	}
})

minetest.register_craft({
	output = 'default:dirt_with_grass 6',
	recipe = {
		{"default:dirt", "default:dirt", "default:dirt"},
		{"default:grass_1", "default:grass_1", "default:grass_1"},
		{"default:dirt", "default:dirt", "default:dirt"},
	},
})

-- Minetest 0.4 mod: bone_collector
-- Bones can be crafted to clay, sand or coal to motivate players clear the playground.
-- 
-- See README.txt for licensing and other information.

minetest.register_craft({
	output = 'default:clay_lump',
	recipe = {
		{"bones:bones", "", ""},
		{"", "", ""},
		{"", "", ""},
	},
})
minetest.register_craft({
	output = 'default:gravel',
	recipe = {
		{"", "", ""},
		{"", "", ""},
		{"bones:bones", "bones:bones", "bones:bones"},
	},
})
minetest.register_craft({
	output = 'default:sand',
	recipe = {
		{"bones:bones", "", "bones:bones"},
		{"", "bones:bones", ""},
		{"bones:bones", "", "bones:bones"},
	},
})
minetest.register_craft({
	output = 'default:coal_lump',
	recipe = {
		{"", "bones:bones", ""},
		{"bones:bones", "bones:bones", "bones:bones"},
		{"", "bones:bones", ""},
	},
})
minetest.register_craft({
	output = 'default:dirt',
	recipe = {
		{"bones:bones", "bones:bones", "bones:bones"},
		{"bones:bones", "bones:bones", "bones:bones"},
		{"bones:bones", "bones:bones", "bones:bones"},
	},
})


--[[
minetest.register_craft({
	output = 'jt_mods:pick_obsidian',
	recipe = {
		{'default:obsidian_shard', 'default:obsidian_shard', 'default:obsidian_shard'},
		{'', 'jt_mods:handle', ''},
		{'', 'jt_mods:handle', ''},
	}
})

minetest.register_craft({
	output = 'jt_mods:handle',
	recipe = {
		{'default:steel_ingot', 'jt_mods:griefer_soul', 'default:steel_ingot'},
		{'default:steel_ingot', 'jt_mods:griefer_soul', 'default:steel_ingot'},
		{'default:steel_ingot', 'jt_mods:griefer_soul', 'default:steel_ingot'},
	}
})
]]

minetest.register_craft({
	output = 'jt_mods:meselamp_white 1',
	recipe = {
		{'', 'default:mese_crystal',''},
		{'default:mese_crystal', 'default:obsidian_glass', 'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = 'jt_mods:griefer_soul_block',
	recipe = {
		{'jt_mods:griefer_soul', 'jt_mods:griefer_soul', 'jt_mods:griefer_soul'},
		{'jt_mods:griefer_soul', 'jt_mods:griefer_soul', 'jt_mods:griefer_soul'},
		{'jt_mods:griefer_soul', 'jt_mods:griefer_soul', 'jt_mods:griefer_soul'},
	}
})

minetest.register_craft({
	output = 'jt_mods:admin_tnt',
	recipe = {
		{'default:wood', 'tnt:gunpowder', 'default:wood'},
		{'tnt:gunpowder', 'jt_mods:griefer_soul_block', 'tnt:gunpowder'},
		{'default:wood', 'tnt:gunpowder', 'default:wood'},
	}
})
