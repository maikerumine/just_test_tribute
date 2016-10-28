-- mods/default/crafting.lua
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
	output = 'default:dirt_with_grass',
	recipe = {
		{"default:dirt", "default:grass_1", "default:dirt"},
		{"default:grass_1", "bones:bones", "default:grass_1"},
		{"default:dirt", "default:grass_1", "default:dirt"},
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

minetest.register_alias("default:hd_stonebrick", "air")
minetest.register_alias("spidermob:meat", "default:meat")
minetest.register_alias("spidermob:meat_raw", "default:meat_raw")


minetest.register_alias("default:meat_raw", "mobs:meat_raw")
minetest.register_alias("default:meat", "mobs:meat")