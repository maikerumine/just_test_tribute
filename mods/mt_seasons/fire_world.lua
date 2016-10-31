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



--FIRE AND LAVA
minetest.override_item("default:stone", {
	description = "Stone",
	tiles = {"default_obsidian.png"},
	groups = {cracky = 3, stone = 1},
	drop = 'default:cobble',
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})
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
	tiles = {"default_mossycobble.png^[colorize:purple:80"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})
]]
minetest.override_item("default:stonebrick", {
	description = "Stone Brick",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_obsidian_block.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.override_item("default:glass", {
	description = "Glass",
	drawtype = "glasslike_framed_optional",
	tiles = {"default_portal.png", "default_glass_detail.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.override_item("default:dirt", {
	description = "Dirt",
	tiles = {"default_dirt.png^[colorize:black:80"},
	groups = {crumbly = 3, soil = 1},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.override_item("default:dirt_with_grass", {
	description = "Dirt with Grass",
	tiles = {"default_dry_grass.png^[colorize:black:180", "default_dirt.png",
		{name = "default_dirt.png^default_dry_grass_side.png^[colorize:black:180",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.override_item("default:dirt_with_dry_grass", {
	description = "Dirt with Dry Grass",
	tiles = {"default_snow.png^[colorize:orange:80", "default_dirt.png",
		{name = "default_dirt.png^default_snow_side.png^[colorize:orange:80",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_snow_footstep", gain = 0.15},
		dug = {name = "default_snow_footstep", gain = 0.2},
		dig = {name = "default_snow_footstep", gain = 0.2}
	}),
})


minetest.override_item("default:leaves", {
	description = "Leaves",
	--drawtype = "allfaces_optional",
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.3,
	tiles = {"default_dry_shrub.png"},
	special_tiles = {"default_dry_shrub.png"},
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
	tiles = {"default_dry_shrub.png"},
	special_tiles = {"default_dry_shrub.png"},
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
	tiles = {"default_pine_needles.png^[colorize:orange:80"},
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
	tiles = {"default_dry_shrub.png^[colorize:orange:180"},
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
	tiles = {"default_dry_shrub.png^[colorize:brown:80"},
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
	tiles = {"default_cactus_top.png^[colorize:black:200", "default_cactus_top.png^[colorize:black:200",
		"default_cactus_side.png^[colorize:black:200"},
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
	tiles = {"fertiliser_bone.png^[colorize:black:120"},
	inventory_image = "fertiliser_bone.png^[colorize:black:120",
	wield_image = "fertiliser_bone.png^[colorize:black:120",
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
	tiles = {"default_junglegrass.png^[colorize:red:180"},
	inventory_image = "default_junglegrass.png^[colorize:red:180",
	wield_image = "default_junglegrass.png^[colorize:red:180",
	paramtype = "light",
	light_source = default.LIGHT_MAX - 1,
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
	tiles = {"default_grass_1.png^[colorize:red:80"},
	-- Use texture of a taller grass stage in inventory
	inventory_image = "default_grass_3.png^[colorize:red:80",
	wield_image = "default_grass_3.png^[colorize:red:80",
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
	tiles = {"default_dry_grass_1.png^[colorize:red:180"},
	inventory_image = "default_dry_grass_3.png^[colorize:red:180",
	wield_image = "default_dry_grass_3.png^[colorize:red:180",
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
	tiles = {"flowers_waterlily.png^[colorize:brown:180", "flowers_waterlily_bottom.png^[colorize:brown:180"},
	inventory_image = "flowers_waterlily.png^[colorize:brown:180",
	wield_image = "flowers_waterlily.png^[colorize:brown:180",
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
		"bones_top.png^[transform2^[colorize:purple:80",
		"bones_bottom.png^[colorize:purple:80",
		"bones_side.png^[colorize:purple:80",
		"bones_side.png^[colorize:purple:80",
		"bones_rear.png^[colorize:purple:80",
		"bones_front.png^[colorize:purple:80"
	},
	light_source = default.LIGHT_MAX,
})

minetest.override_item("default:chest", {
	tiles = {
		"bones_top.png^[transform2^[colorize:purple:80",
		"bones_bottom.png^[colorize:purple:80",
		"bones_side.png^[colorize:purple:80",
		"bones_side.png^[colorize:purple:80",
		"bones_rear.png^[colorize:purple:80",
		"bones_front.png^[colorize:purple:80"
	},
	light_source = default.LIGHT_MAX,
})

minetest.override_item("default:gravel", {
	description = "Gravel",
	tiles = {"default_gravel.png^[colorize:purple:134"},
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


--
-- Liquids
--

minetest.override_item("default:water_source", {
	description = "Water Source",
	drawtype = "liquid",
	--drawtype = "solid",
	tiles = {
		{
			name = "default_lava_source_animated.png",
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
			name = "default_lava_source_animated.png",
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
	light_source = default.LIGHT_MAX - 1,
	walkable = false,
	climbable = true,
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
	tiles = {"default_water.png"},
	special_tiles = {
		{
			name = "default_lava_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8,
			},
		},
		{
			name = "default_lava_flowing_animated.png",
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
	light_source = default.LIGHT_MAX - 1,
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

minetest.override_item("default:stone_with_coal", {
	description = "Coal Ore",
	tiles = {"default_obsidian.png^default_mineral_coal.png"},
	groups = {cracky = 3},
	drop = 'default:coal_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.override_item("default:stone_with_iron", {
	description = "Iron Ore",
	tiles = {"default_obsidian.png^default_mineral_iron.png"},
	groups = {cracky = 2},
	drop = 'default:iron_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.override_item("default:stone_with_copper", {
	description = "Copper Ore",
	tiles = {"default_obsidian.png^default_mineral_copper.png"},
	groups = {cracky = 2},
	drop = 'default:copper_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.override_item("default:stone_with_gold", {
	description = "Gold Ore",
	tiles = {"default_obsidian.png^default_mineral_gold.png"},
	groups = {cracky = 2},
	drop = "default:gold_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.override_item("default:stone_with_diamond", {
	description = "Diamond Ore",
	tiles = {"default_obsidian.png^default_mineral_diamond.png"},
	groups = {cracky = 1},
	drop = "default:diamond",
	sounds = default.node_sound_stone_defaults(),
})



minetest.override_item("default:goldblock", {
	description = "Gold Block",
	tiles = {"default_gold_block.png^mobs_cobweb.png"},
	is_ground_content = false,
	groups = {cracky = 1},
	sounds = default.node_sound_metal_defaults(),
})
minetest.override_item("default:bronzeblock", {
	description = "Bronze Block",
	tiles = {"default_bronze_block.png^mobs_cobweb.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})
minetest.override_item("default:copperblock", {
	description = "Copper Block",
	tiles = {"default_copper_block.png^mobs_cobweb.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})
minetest.override_item("default:steelblock", {
	description = "Steel Block",
	tiles = {"default_steel_block.png^mobs_cobweb.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})
minetest.override_item("default:diamondblock", {
	description = "Diamond Block",
	tiles = {"default_diamond_block.png^default_portal.png^mobs_cobweb.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.override_item("default:stone_with_mese", {
	description = "Mese Ore",
	tiles = {"default_stone.png^default_mineral_mese.png^[colorize:purple:180"},
	groups = {cracky = 1},
	drop = "default:mese_crystal",
	sounds = default.node_sound_stone_defaults(),
})

minetest.override_item("default:mese", {
	description = "Mese Block",
	tiles = {"default_mese_block.png^[colorize:purple:180"},
	paramtype = "light",
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),
	light_source = 3,
})



minetest.override_item("default:brick", {
	description = "Brick Block",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_brick.png^[colorize:black:190"},
	is_ground_content = false,
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.override_item("default:cloud", {
	description = "Cloud",
	tiles = {"default_cloud.png^[colorize:red:190"},
	is_ground_content = false,
	sounds = default.node_sound_defaults(),
	groups = {not_in_creative_inventory = 1},
})


minetest.override_item("default:mese_crystal", {
	description = "Mese Crystal",
	inventory_image = "default_mese_crystal.png^[colorize:purple:180",
})

minetest.override_item("default:mese_crystal_fragment", {
	description = "Mese Crystal Fragment",
	inventory_image = "default_mese_crystal_fragment.png^[colorize:purple:180",
})

minetest.override_item("default:pick_mese", {
	description = "Mese Pickaxe",
	inventory_image = "default_tool_mesepick.png^[colorize:purple:180",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.4, [2]=1.2, [3]=0.60}, uses=20, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
})
minetest.override_item("default:shovel_mese", {
	description = "Mese Shovel",
	inventory_image = "default_tool_meseshovel.png^[colorize:purple:180",
	wield_image = "default_tool_meseshovel.png^[transformR90^[colorize:purple:180",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			crumbly = {times={[1]=1.20, [2]=0.60, [3]=0.30}, uses=20, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.override_item("default:axe_mese", {
	description = "Mese Axe",
	inventory_image = "default_tool_meseaxe.png^[colorize:purple:180",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.20, [2]=1.00, [3]=0.60}, uses=20, maxlevel=3},
		},
		damage_groups = {fleshy=6},
	},
})
minetest.override_item("default:sword_mese", {
	description = "Mese Sword",
	inventory_image = "default_tool_mesesword.png^[colorize:purple:180",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	}
})




--AUTUMN CRAFTS
minetest.register_craft({
	output = "mt_seasons:jackolantern",
	recipe = {
		{"", "", ""},
		{"", "default:torch", ""},
		{"", "mt_seasons:pumpkin", ""},
	}
})

-- pumpkin bread
minetest.register_craftitem("mt_seasons:pumpkin_bread", {
	description = "Pumpkin Bread",
	inventory_image = "farming_pumpkin_bread.png",
	on_use = minetest.item_eat(8)
})

minetest.register_craftitem("mt_seasons:pumpkin_dough", {
	description = "Pumpkin Dough",
	inventory_image = "farming_pumpkin_dough.png",
})

minetest.register_craft({
	output = "mt_seasons:pumpkin_dough",
	type = "shapeless",
	recipe = {"farming:flour", "default:pumpkin_slice", "default:pumpkin_slice"}
})

minetest.register_craft({
	type = "cooking",
	output = "mt_seasons:pumpkin_bread",
	recipe = "mt_seasons:pumpkin_dough",
	cooktime = 10
})
