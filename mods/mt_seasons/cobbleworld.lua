-- Minetest 0.4 mod: mt_seasons
-- 
-- See README.txt for licensing and other information.



--OVERRIDE IMAGES
--example:
--[[
minetest.override_item("default:mese", {
    light_source = LIGHT_MAX,
    groups = {unbreakable=1},
})
]]



--COBBLEWORLD!!

--[[
minetest.override_item("default:cobble", {
	description = "Cobblestone",
	tiles = {"default_cobble.png^[colorize:purple:80"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})
]]
--[[
minetest.override_item("default:mossycobble", {
	description = "Mossy Cobblestone",
	tiles = {"default_cobble.png^[colorize:purple:80"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})
]]
minetest.override_item("default:stone_block", {
	description = "Stone Block",
	tiles = {"default_cobble.png^[colorize:black:24"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.override_item("default:stonebrick", {
	description = "Stone Brick",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_cobble.png^[colorize:black:34"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.override_item("default:desert_stone", {
	description = "Desert Stone",
	tiles = {"default_desert_cobble.png"},
	groups = {cracky = 3, stone = 1},
	drop = 'default:desert_cobble',
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.override_item("default:desert_stonebrick", {
	description = "Desert Stone Brick",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_desert_cobble.png^[colorize:red:34"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.override_item("default:desert_stone_block", {
	description = "Desert Stone Block",
	tiles = {"default_desert_cobble.png^[colorize:red:24"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})


minetest.override_item("default:sandstone", {
	description = "Sandstone",
	tiles = {"default_cobble.png^[colorize:yellow:34"},
	groups = {crumbly = 1, cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.override_item("default:sandstonebrick", {
	description = "Sandstone Brick",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_cobble.png^[colorize:yellow:34"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.override_item("default:sandstone_block", {
	description = "Sandstone Block",
	tiles = {"default_cobble.png^[colorize:yellow:24"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})



minetest.override_item("default:sand", {
	description = "Sand",
	tiles = {"default_cobble.png^[colorize:brown:44"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.override_item("default:desert_sand", {
	description = "Desert Sand",
	tiles = {"default_cobble.png^[colorize:orange:64"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.override_item("default:silver_sand", {
	description = "Silver Sand",
	tiles = {"default_cobble.png^[colorize:white:24"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = default.node_sound_sand_defaults(),
})


--may remove if not transparent.
minetest.override_item("default:glass", {
	description = "Glass",
	drawtype = "glasslike_framed_optional",
	tiles = {"default_cobble.png", "default_glass_detail.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.override_item("default:dirt", {
	description = "Dirt",
	tiles = {"default_cobble.png^[colorize:brown:180"},
	groups = {crumbly = 3, soil = 1},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.override_item("default:dirt_with_grass", {
	description = "Dirt with Grass",
	tiles = {"default_cobble.png^[colorize:green:180", "default_cobble.png",
		{name = "default_cobble.png^[colorize:green:180",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.override_item("default:dirt_with_dry_grass", {
	description = "Dirt with Dry Grass",
	tiles = {"default_cobble.png^[colorize:orange:80", "default_cobble.png",
		{name = "default_cobble.png^[colorize:orange:80",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_snow_footstep", gain = 0.15},
		dug = {name = "default_snow_footstep", gain = 0.2},
		dig = {name = "default_snow_footstep", gain = 0.2}
	}),
})

minetest.override_item("default:dirt_with_snow", {
	description = "Dirt with Snow",
	tiles = {"default_cobble.png^[colorize:white:180", "default_cobble.png^[colorize:white:180",
		{name = "default_cobble.png^[colorize:white:180",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_snow_footstep", gain = 0.15},
	}),
})

--trees
minetest.override_item("default:tree", {
	description = "Tree",
	tiles = {"default_cobble.png^[colorize:black:120", "default_cobble.png^[colorize:black:120", "default_cobble.png^[colorize:black:180"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})
minetest.override_item("default:jungletree", {
	description = "Jungle Tree",
	tiles = {"default_cobble.png^[colorize:brown:120", "default_cobble.png^[colorize:brown:120",
		"default_cobble.png^[colorize:brown:180"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})
minetest.override_item("default:pine_tree", {
	description = "Pine Tree",
	tiles = {"default_cobble.png^[colorize:gray:120", "default_cobble.png^[colorize:gray:120",
		"default_cobble.png^[colorize:gray:180"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})
minetest.override_item("default:acacia_tree", {
	description = "Acacia Tree",
	tiles = {"default_cobble.png^[colorize:red:120", "default_cobble.png^[colorize:red:120",
		"default_cobble.png^[colorize:red:180"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})
minetest.override_item("default:aspen_tree", {
	description = "Aspen Tree",
	tiles = {"default_cobble.png^[colorize:white:120", "default_cobble.png^[colorize:white:120",
		"default_cobble.png^[colorize:white:180"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})





minetest.override_item("default:leaves", {
	description = "Leaves",
	--drawtype = "allfaces_optional",
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.3,
	tiles = {"default_cobble.png^[colorize:green:34"},
	special_tiles = {"default_cobble.png^[colorize:green:34"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {'default:sapling'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'default:leaves'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = default.after_place_leaves,
})


minetest.override_item("default:jungleleaves", {
	description = "Jungle Leaves",
	--drawtype = "allfaces_optional",
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.3,
	tiles = {"default_cobble.png^[colorize:darkgreen:104"},
	special_tiles = {"default_cobble.png^[colorize:darkgreen:104"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {'default:junglesapling'}, rarity = 20},
			{items = {'default:jungleleaves'}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = default.after_place_leaves,
})

minetest.override_item("default:pine_needles",{
	description = "Pine Needles",
	--drawtype = "allfaces_optional",
	drawtype = "plantlike",
	visual_scale = 1.3,
	tiles = {"default_cobble.png^[colorize:green:80"},
	waving = 1,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"default:pine_sapling"}, rarity = 20},
			{items = {"default:pine_needles"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = default.after_place_leaves,
})


minetest.override_item("default:acacia_leaves", {
	description = "Acacia Leaves",
	--drawtype = "allfaces_optional",
	drawtype = "plantlike",
	visual_scale = 1.3,
	tiles = {"default_cobble.png^[colorize:orange:180"},
	waving = 1,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"default:acacia_sapling"}, rarity = 20},
			{items = {"default:acacia_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = default.after_place_leaves,
})

minetest.override_item("default:aspen_leaves", {
	description = "Aspen Leaves",
	--drawtype = "allfaces_optional",
	drawtype = "plantlike",
	visual_scale = 1.3,
	tiles = {"default_cobble.png^[colorize:brown:80"},
	waving = 1,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"default:aspen_sapling"}, rarity = 20},
			{items = {"default:aspen_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = default.after_place_leaves,
})

--
-- Plantlife (non-cubic)
--

minetest.override_item("default:cactus", {
	description = "Cactus",
	tiles = {"default_cobble.png^[colorize:green:130", "default_cobble.png^[colorize:green:130",
		"default_cobble.png^[colorize:green:130"},
	paramtype2 = "facedir",
	groups = {snappy = 1, choppy = 3},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	
	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,
})

minetest.override_item("default:papyrus", {
	description = "Papyrus",
	drawtype = "plantlike",
	tiles = {"default_cobble.png^[colorize:black:120"},
	inventory_image = "default_cobble.png^[colorize:black:120",
	wield_image = "default_cobble.png^[colorize:black:120",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),

	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,
})

minetest.override_item("default:junglegrass", {
	description = "Jungle Grass",
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.3,
	tiles = {"default_cobble.png^[colorize:black:180"},
	inventory_image = "default_cobble.png^[colorize:black:180",
	wield_image = "default_cobble.png^[colorize:black:180",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
})


minetest.override_item("default:grass_1", {
	description = "Grass",
	drawtype = "plantlike",
	waving = 1,
	tiles = {"default_cobble.png^[colorize:red:80"},
	-- Use texture of a taller grass stage in inventory
	inventory_image = "default_cobble.png^[colorize:red:80",
	wield_image = "default_cobble.png^[colorize:red:80",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random grass node
		local stack = ItemStack("default:grass_" .. math.random(1,5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("default:grass_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 5 do
	minetest.override_item("default:grass_" .. i, {
		description = "Grass",
		drawtype = "plantlike",
		waving = 1,
		tiles = {"default_grass_" .. i .. ".png^[colorize:red:80"},
		inventory_image = "default_grass_" .. i .. ".png^[colorize:red:80",
		wield_image = "default_grass_" .. i .. ".png^[colorize:red:80",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		drop = "default:grass_1",
		groups = {snappy = 3, flora = 1, attached_node = 1,
			not_in_creative_inventory = 1, grass = 1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
		},
	})
end




minetest.override_item("default:dry_grass_1", {
	description = "Dry Grass",
	drawtype = "plantlike",
	waving = 1,
	tiles = {"default_cobble.png^[colorize:red:180"},
	inventory_image = "default_cobble.png^[colorize:red:180",
	wield_image = "default_cobble.png^[colorize:red:180",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, flora = 1,
		attached_node = 1, dry_grass = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random dry grass node
		local stack = ItemStack("default:dry_grass_" .. math.random(1, 5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("default:dry_grass_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 5 do
	minetest.override_item("default:dry_grass_" .. i, {
		description = "Dry Grass",
		drawtype = "plantlike",
		waving = 1,
		tiles = {"default_dry_grass_" .. i .. ".png^[colorize:red:180"},
		inventory_image = "default_dry_grass_" .. i .. ".png^[colorize:red:180",
		wield_image = "default_dry_grass_" .. i .. ".png^[colorize:red:180",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1,
			not_in_creative_inventory=1, dry_grass = 1},
		drop = "default:dry_grass_1",
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
		},
	})
end

--
-- Waterlily
--

minetest.override_item("flowers:waterlily", {
	description = "Waterlily",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"default_cobble.png^[colorize:green:180", "default_cobble.png^[colorize:green:180"},
	inventory_image = "default_cobble.png^[colorize:green:180",
	wield_image = "default_cobble.png^[colorize:green:180",
	liquids_pointable = true,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	floodable = true,
	groups = {snappy = 3, flower = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults(),
	node_placement_prediction = "",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.46875, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}
	},

	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.above
		local node = minetest.get_node(pointed_thing.under).name
		local def = minetest.registered_nodes[node]
		local player_name = placer:get_player_name()

		if def and def.liquidtype == "source" and
				minetest.get_item_group(node, "water") > 0 then
			if not minetest.is_protected(pos, player_name) then
				minetest.set_node(pos, {name = "flowers:waterlily",
					param2 = math.random(0, 3)})
				if not minetest.setting_getbool("creative_mode") then
					itemstack:take_item()
				end
			else
				minetest.chat_send_player(player_name, "Node is protected")
				minetest.record_protection_violation(pos, player_name)
			end
		end

		return itemstack
	end
})

--flowers
local function add_simple_flower(name, desc, box, f_groups)
	-- Common flowers' groups
	f_groups.snappy = 3
	f_groups.flower = 1
	f_groups.flora = 1
	f_groups.attached_node = 1
	
	minetest.override_item("flowers:" .. name, {
		description = desc,
		drawtype = "plantlike",
		waving = 1,
		tiles = {"flowers_" .. name .. ".png^[colorize:black:200"},
		inventory_image = "flowers_" .. name .. ".png^[colorize:black:200",
		wield_image = "flowers_" .. name .. ".png^[colorize:black:200",
		sunlight_propagates = true,
		paramtype = "light",
		walkable = false,
		buildable_to = true,
		stack_max = 99,
		groups = f_groups,
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = box
		}
	})
end

flowers.datas = {
	{"rose", "Rose", {-0.15, -0.5, -0.15, 0.15, 0.3, 0.15}, {color_red = 1, flammable = 1}},
	{"tulip", "Orange Tulip", {-0.15, -0.5, -0.15, 0.15, 0.2, 0.15}, {color_orange = 1, flammable = 1}},
	{"dandelion_yellow", "Yellow Dandelion", {-0.15, -0.5, -0.15, 0.15, 0.2, 0.15}, {color_yellow = 1, flammable = 1}},
	{"geranium", "Blue Geranium", {-0.15, -0.5, -0.15, 0.15, 0.2, 0.15}, {color_blue = 1, flammable = 1}},
	{"viola", "Viola", {-0.5, -0.5, -0.5, 0.5, -0.2, 0.5}, {color_violet = 1, flammable = 1}},
	{"dandelion_white", "white dandelion", {-0.5, -0.5, -0.5, 0.5, -0.2, 0.5}, {color_white = 1, flammable = 1}}
}

for _,item in pairs(flowers.datas) do
	add_simple_flower(unpack(item))
end




minetest.override_item("default:chest_locked", {
	tiles = {
		"default_cobble.png^[transform2^[colorize:brown:80",
		"default_cobble.png^[colorize:brown:80",
		"default_cobble.png^[colorize:brown:80",
		"default_cobble.png^[colorize:brown:80",
		"default_cobble.png^[colorize:brown:80",
		"default_cobble.png^[colorize:brown:80"
	},
	light_source = default.LIGHT_MAX,
})

minetest.override_item("default:chest", {
	tiles = {
		"default_cobble.png^[transform2^[colorize:brown:80",
		"default_cobble.png^[colorize:brown:80",
		"default_cobble.png^[colorize:brown:80",
		"default_cobble.png^[colorize:brown:80",
		"default_cobble.png^[colorize:brown:80",
		"default_cobble.png^[colorize:brown:80"
	},
	light_source = default.LIGHT_MAX,
})

minetest.override_item("default:gravel", {
	description = "Gravel",
	tiles = {"default_cobble.png^[colorize:black:80"},
	groups = {crumbly = 2, falling_node = 1},
	sounds = default.node_sound_gravel_defaults(),
	drop = {
		max_items = 1,
		items = {
			{items = {'default:flint'}, rarity = 16},
			{items = {'default:gravel'}}
		}
	}
})

minetest.override_item("default:clay", {
	description = "Clay",
	tiles = {"default_cobble.png^[colorize:gray:180"},
	groups = {crumbly = 3},
	drop = 'default:clay_lump 4',
	sounds = default.node_sound_dirt_defaults(),
})


minetest.override_item("default:snow", {
	description = "Snow",
	tiles = {"default_cobble.png^[colorize:white:190"},
	inventory_image = "default_snowball.png",
	wield_image = "default_snowball.png",
	paramtype = "light",
	buildable_to = true,
	floodable = true,
	walkable = false,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
		},
	},
	groups = {crumbly = 3, falling_node = 1, puts_out_fire = 1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_snow_footstep", gain = 0.15},
		dug = {name = "default_snow_footstep", gain = 0.2},
		dig = {name = "default_snow_footstep", gain = 0.2}
	}),

	on_construct = function(pos)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name == "default:dirt_with_grass" then
			minetest.set_node(pos, {name = "default:dirt_with_snow"})
		end
	end,
})

minetest.override_item("default:snowblock", {
	description = "Snow Block",
	tiles = {"default_cobble.png^[colorize:white:190"},
	groups = {crumbly = 3, puts_out_fire = 1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_snow_footstep", gain = 0.15},
		dug = {name = "default_snow_footstep", gain = 0.2},
		dig = {name = "default_snow_footstep", gain = 0.2}
	}),
})

minetest.override_item("default:ice", {
	description = "Ice",
	tiles = {"default_cobble.png^[colorize:cyan:80"},
	is_ground_content = false,
	paramtype = "light",
	groups = {cracky = 3, puts_out_fire = 1},
	sounds = default.node_sound_glass_defaults(),
})


--
-- Liquids
--

minetest.override_item("default:water_source", {
	description = "Water Source",
	drawtype = "liquid",
	--drawtype = "solid",
	tiles = {
		{
			name = "default_cobble.png^[colorize:blue:120",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	special_tiles = {
		-- New-style water source material (mostly unused)
		{
			name = "default_cobble.png^[colorize:blue:120",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
			backface_culling = false,
		},
	},
	--alpha = 160,
	alpha = 210,
	paramtype = "light",
	--light_source = default.LIGHT_MAX - 1,
	walkable = false,
	--climbable = true,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "default:water_flowing",
	liquid_alternative_source = "default:water_source",
	liquid_viscosity = 4,
	post_effect_color = {a = 213, r = 30, g = 60, b = 90},
	groups = {water = 3, liquid = 3, puts_out_fire = 1},
	
})

minetest.override_item("default:water_flowing", {
	description = "Flowing Water",
	drawtype = "flowingliquid",
	tiles = {"default_cobble.png"},
	special_tiles = {
		{
			name = "default_cobble.png^[colorize:blue:120",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8,
			},
		},
		{
			name = "default_cobble.png^[colorize:blue:120",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8,
			},
		},
	},
	alpha = 210,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	--light_source = default.LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "default:water_flowing",
	liquid_alternative_source = "default:water_source",
	liquid_viscosity = 2,
	post_effect_color = {a = 203, r = 30, g = 60, b = 90},
	groups = {water = 3, liquid = 3, puts_out_fire = 1,
		not_in_creative_inventory = 1},
		--sounds = default.node_sound_glass_defaults(),
})



minetest.override_item("default:stone", {
	description = "Stone",
	tiles = {"default_cobble.png^[colorize:white:34"},
	groups = {cracky = 3, stone = 1},
	drop = 'default:cobble',
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.override_item("default:stone_with_coal", {
	description = "Coal Ore",
	tiles = {"default_cobble.png^default_mineral_coal.png^[colorize:white:34"},
	groups = {cracky = 3},
	drop = 'default:coal_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.override_item("default:stone_with_iron", {
	description = "Iron Ore",
	tiles = {"default_cobble.png^default_mineral_iron.png^[colorize:white:34"},
	groups = {cracky = 2},
	drop = 'default:iron_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.override_item("default:stone_with_copper", {
	description = "Copper Ore",
	tiles = {"default_cobble.png^default_mineral_copper.png^[colorize:white:34"},
	groups = {cracky = 2},
	drop = 'default:copper_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.override_item("default:stone_with_gold", {
	description = "Gold Ore",
	tiles = {"default_cobble.png^default_mineral_gold.png^[colorize:white:34"},
	groups = {cracky = 2},
	drop = "default:gold_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.override_item("default:stone_with_diamond", {
	description = "Diamond Ore",
	tiles = {"default_cobble.png^default_mineral_diamond.png^[colorize:white:34"},
	groups = {cracky = 1},
	drop = "default:diamond",
	sounds = default.node_sound_stone_defaults(),
})

minetest.override_item("default:stone_with_mese", {
	description = "Mese Ore",
	tiles = {"default_cobble.png^default_mineral_mese.png^[colorize:white:34"},
	groups = {cracky = 1},
	drop = "default:mese_crystal",
	sounds = default.node_sound_stone_defaults(),
})


minetest.override_item("default:goldblock", {
	description = "Gold Block",
	tiles = {"default_cobble.png^[colorize:orange:134"},
	is_ground_content = false,
	groups = {cracky = 1},
	sounds = default.node_sound_metal_defaults(),
})
minetest.override_item("default:bronzeblock", {
	description = "Bronze Block",
	tiles = {"default_cobble.png^[colorize:brown:134"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})
minetest.override_item("default:copperblock", {
	description = "Copper Block",
	tiles = {"default_cobble.png^[colorize:red:134"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})
minetest.override_item("default:steelblock", {
	description = "Steel Block",
	tiles = {"default_cobble.png^[colorize:gray:134"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})
minetest.override_item("default:diamondblock", {
	description = "Diamond Block",
	tiles = {"default_cobble.png^[colorize:cyan:134"},
	is_ground_content = false,
	groups = {cracky = 1, level = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.override_item("default:mese", {
	description = "Mese Block",
	tiles = {"default_cobble.png^[colorize:yellow:134"},
	paramtype = "light",
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),
	light_source = 3,
})

minetest.override_item("default:brick", {
	description = "Brick Block",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_cobble.png"},
	is_ground_content = false,
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})




