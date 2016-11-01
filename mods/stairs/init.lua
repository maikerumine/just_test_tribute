stairs = {}
stairs.mod = "redo"

function default.node_sound_wool_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "wool_coat_movement", gain = 1.0}
	table.dug = table.dug or
			{name = "wool_coat_movement", gain = 0.25}
	table.place = table.place or
			{name = "default_place_node", gain = 1.0}
	return table
end

stairs.wood = default.node_sound_wood_defaults()
stairs.dirt = default.node_sound_dirt_defaults()
stairs.stone = default.node_sound_stone_defaults()
stairs.glass = default.node_sound_glass_defaults()
stairs.leaves = default.node_sound_leaves_defaults()
stairs.wool = default.node_sound_wool_defaults() -- Xanadu only
--stairs.wool = stairs.leaves


-- Node will be called stairs:stair_<subname>
function stairs.register_stair(subname, recipeitem, groups, images, description, snds, alpha, light)
	groups.stair = 1
	minetest.register_node(":stairs:stair_" .. subname, {
		description = description,
--		drawtype = "nodebox",
		drawtype = "mesh",
		mesh = "stairs_stair.obj",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		use_texture_alpha = alpha,
		light_source = light,
		--light_source =14,
		groups = groups,
		sounds = snds,
--		node_box = {
--			type = "fixed",
--			fixed = {
--				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
--				{-0.5, 0, 0, 0.5, 0.5, 0.5},
--			},
--		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		on_place = minetest.rotate_node
	})

	-- stair recipes
	minetest.register_craft({
		output = 'stairs:stair_' .. subname .. ' 4', -- was 6
		recipe = {
			{recipeitem, "", ""},
			{recipeitem, recipeitem, ""},
			{recipeitem, recipeitem, recipeitem},
		},
	})

	minetest.register_craft({
		output = 'stairs:stair_' .. subname .. ' 4', -- was 6
		recipe = {
			{"", "", recipeitem},
			{"", recipeitem, recipeitem},
			{recipeitem, recipeitem, recipeitem},
		},
	})

	-- stair to original material recipe
	minetest.register_craft({
		type = "shapeless",
		output = recipeitem .. " 3",
		recipe = {"stairs:stair_" .. subname, "stairs:stair_" .. subname}
	})

end

-- Node will be called stairs:slab_<subname>
function stairs.register_slab(subname, recipeitem, groups, images, description, snds, alpha, light)
	groups.slab = 1
	minetest.register_node(":stairs:slab_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		use_texture_alpha = alpha,
		light_source = light,
		groups = groups,
		sounds = snds,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		on_place = minetest.rotate_node
	})

	-- slab recipe
	minetest.register_craft({
		output = 'stairs:slab_' .. subname .. ' 6',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
		},
	})

	-- slab to original material recipe
	minetest.register_craft({
		type = "shapeless",
		output = recipeitem,
		recipe = {"stairs:slab_" .. subname, "stairs:slab_" .. subname}
	})
end
--
--
--
--
--[[
function register_stair_slab_panel_micro(modname, subname, recipeitem, groups, images, description, drop, light)
	stairsplus:register_all(modname, subname, recipeitem, {
		groups = groups,
		tiles = images,
		description = description,
		drop = drop,
		light_source = light
	})
end
]]
--
-- Node will be called stairs:slab1<subname>
function stairs.register_slab1(subname, recipeitem, groups, images, description, snds, alpha, light)
	groups.slab = 1
	minetest.register_node(":stairs:slab1_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		use_texture_alpha = alpha,
		--light_source =14,
		light_source =light,
		groups = groups,
		sounds = snds,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, (1/16)-0.5, 0.5},
		},
		on_place = minetest.rotate_node
	})

	-- slab recipe
	minetest.register_craft({
		output = 'stairs:slab1_' .. subname .. ' 3',
		recipe = {
			{"stairs:slab_" .. subname},
		},
	})

	-- slab to original material recipe
	minetest.register_craft({
		type = "shapeless",
		--output = recipeitem,
		output = 'stairs:slab_' .. subname .. ' ',
		recipe = {"stairs:slab1_" .. subname, "stairs:slab1_" .. subname,"stairs:slab1_" .. subname},
	})
end

-- Node will be called stairs:corner_<subname>
function stairs.register_corner(subname, recipeitem, groups, images, description, snds, alpha, light)
	minetest.register_node(":stairs:corner_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		use_texture_alpha = alpha,
		light_source = light,
		groups = groups,
		sounds = snds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0, 0.5, 0.5},
			},
		},
		on_place = minetest.rotate_node
	})

	-- corner stair recipe
	minetest.register_craft({
		output = 'stairs:corner_' .. subname .. ' 4',
		recipe = {
			{"", "", ""},
			{"", recipeitem, ""},
			{recipeitem, recipeitem, recipeitem},
		},
	})

	-- corner stair to original material recipe
	minetest.register_craft({
		type = "shapeless",
		output = recipeitem,
		recipe = {"stairs:corner_" .. subname, "stairs:corner_" .. subname}
	})
end

-- Node will be called stairs:invcorner_<subname>
function stairs.register_invcorner(subname, recipeitem, groups, images, description, snds, alpha, light)
	minetest.register_node(":stairs:invcorner_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		use_texture_alpha = alpha,
		light_source = light,
		groups = groups,
		sounds = snds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
				{-0.5, 0, -0.5, 0, 0.5, 0},
			},
		},
		on_place = minetest.rotate_node
	})

	-- inside corner stair recipe
	minetest.register_craft({
		output = 'stairs:invcorner_' .. subname .. ' 6', -- was 8
		recipe = {
			{recipeitem, recipeitem, ""},
			{recipeitem, recipeitem, recipeitem},
			{recipeitem, recipeitem, recipeitem},
		},
	})

	-- inside corner stair to original material recipe
	minetest.register_craft({
		type = "shapeless",
		output = recipeitem .. " 4",
		recipe = {"stairs:invcorner_" .. subname,
		"stairs:invcorner_" .. subname, "stairs:invcorner_" .. subname}
	})
end

-- Node will be called stairs:slope_<subname>
function stairs.register_slope(subname, recipeitem, groups, images, description, snds, alpha,light)
	groups.slab = 1
	minetest.register_node(":stairs:slope_" .. subname, {
		description = description,
		--drawtype = "nodebox",
		drawtype = "mesh",
		mesh = "stairs_slope.obj",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		use_texture_alpha = alpha,
		light_source = light,
		groups = groups,
		sounds = snds,
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		on_place = minetest.rotate_node
	})

	-- slope recipe
	minetest.register_craft({
		output = 'stairs:slope_' .. subname .. ' 6',
		recipe = {
			{recipeitem, "", ""},
			{recipeitem, recipeitem, ""},
		},
	})

	-- slope to original material recipe
	minetest.register_craft({
		type = "shapeless",
		output = recipeitem,
		recipe = {"stairs:slope_" .. subname, "stairs:slope_" .. subname}
	})
end

-- Nodes will be called stairs:{stair,slab}_<subname>
function stairs.register_stair_and_slab(subname, recipeitem, groups, images,
		desc_stair, desc_slab, sounds, alpha,light)
	stairs.register_stair(subname, recipeitem, groups, images, desc_stair, sounds, alpha,light)
	stairs.register_slab(subname, recipeitem, groups, images, desc_slab, sounds, alpha,light)
	stairs.register_slab1(subname, recipeitem, groups, images, desc_slab, sounds, alpha,light)
end

-- Nodes will be called stairs:{stair,slab,corner,invcorner}_<subname>
function stairs.register_all(subname, recipeitem, groups, images, desc, snds, alpha,light)
	local str = " Stair"
	stairs.register_stair(subname, recipeitem, groups, images, str .. desc, snds, alpha,light)
	str = " Slab"
	stairs.register_slab(subname, recipeitem, groups, images, str .. desc, snds, alpha,light)
	str = " Corner"
	stairs.register_corner(subname, recipeitem, groups, images, str .. desc, snds, alpha,light)
	str = " Inverted Corner"
	stairs.register_invcorner(subname, recipeitem, groups, images, str .. desc, snds, alpha,light)
	str = " Slope"
	stairs.register_slope(subname, recipeitem, groups, images, str .. desc, snds, alpha,light)
	str = " Slab1"
	stairs.register_slab1(subname, recipeitem, groups, images, str .. desc, snds, alpha,light)
end

-- Helper

local grp = {}

--= Default Minetest
stairs.register_all("tree", "default:tree",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 3 ,not_in_craft_guide=1},
	{"default_tree_top.png"},
	"Wooden",
	stairs.wood)
	
stairs.register_all("wood", "default:wood",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 3,not_in_craft_guide=1},
	{"default_wood.png"},
	"Wooden",
	stairs.wood)

stairs.register_all("jungletree", "default:jungletree",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 3,not_in_craft_guide=1},
	{"default_jungletree_top.png"},
	"Wooden",
	stairs.wood)
	
stairs.register_all("junglewood", "default:junglewood",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 3,not_in_craft_guide=1},
	{"default_junglewood.png"},
	"Jungle Wood",
	stairs.wood)

stairs.register_all("pine_tree", "default:pine_tree",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 3,not_in_craft_guide=1},
	{"default_pine_tree_top.png"},
	"Wooden",
	stairs.wood)
	
stairs.register_all("pine_wood", "default:pinewood",
	{choppy = 2, oddly_breakable_by_hand = 1, flammable = 3,not_in_craft_guide=1},
	{"default_pine_wood.png"},
	"Pine Wood",
	stairs.wood)

stairs.register_all("acacia_tree", "default:acacia_tree",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 3,not_in_craft_guide=1},
	{"default_acacia_tree_top.png"},
	"Wooden",
	stairs.wood)
	
stairs.register_all("acacia_wood", "default:acacia_wood",
	{choppy = 2, oddly_breakable_by_hand = 1, flammable = 3,not_in_craft_guide=1},
	{"default_acacia_wood.png"},
	"Acacia Wood",
	stairs.wood)

stairs.register_all("aspen_tree", "default:aspen_tree",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 3,not_in_craft_guide=1},
	{"default_aspen_tree_top.png"},
	"Wooden",
	stairs.wood)
	
stairs.register_all("aspen_wood", "default:aspen_wood",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 3,not_in_craft_guide=1},
	{"default_aspen_wood.png"},
	"Aspen Wood",
	stairs.wood)

stairs.register_all("cobble", "default:cobble",
	{cracky = 3},
	{"default_cobble.png"},
	"Cobble",
	stairs.stone)

stairs.register_all("desert_cobble", "default:desert_cobble",
	{cracky = 3,not_in_craft_guide=1},
	{"default_desert_cobble.png"},
	"Desert Cobble", 
	stairs.stone)

stairs.register_stair("cloud", "default:cloud",
	{unbreakable = 1,not_in_craft_guide=1},
	{"default_cloud.png"},
	"Cloud Stair",
	stairs.wool)
--[[
minetest.override_item("stairs:stair_cloud", {
	on_blast = function() end,
})

stairs.register_slab("cloud", "default:cloud",
	{unbreakable = 1},
	{"default_cloud.png"},
	"Cloud Slab",
	stairs.wool)

minetest.override_item("stairs:slab_cloud", {
	on_blast = function() end,
})
]]
stairs.register_all("coal", "default:coalblock",
	{cracky = 3,not_in_craft_guide=1},
	{"default_coal_block.png"},
	"Coal",
	stairs.stone)

stairs.register_all("steelblock", "default:steelblock",
	{cracky = 1, level = 2,not_in_craft_guide=1},
	{"default_steel_block.png"},
	"Steel",
	stairs.stone)

stairs.register_all("copperblock", "default:copperblock",
	{cracky = 1, level = 2,not_in_craft_guide=1},
	{"default_copper_block.png"},
	"Copper",
	stairs.stone)

stairs.register_all("bronzeblock", "default:bronzeblock",
	{cracky = 1, level = 2,not_in_craft_guide=1},
	{"default_bronze_block.png"},
	"Bronze",
	stairs.stone)

stairs.register_all("mese", "default:mese",
	{cracky = 1, level = 2,not_in_craft_guide=1},
	{"default_mese_block.png"},
	"Mese",
	stairs.stone)

stairs.register_all("goldblock", "default:goldblock",
	{cracky = 1,not_in_craft_guide=1},
	{"default_gold_block.png"},
	"Gold",
	stairs.stone)

stairs.register_all("diamondblock", "default:diamondblock",
	{cracky = 1, level = 3,not_in_craft_guide=1},
	{"default_diamond_block.png"},
	"Diamond",
	stairs.stone)

stairs.register_all("stone", "default:stone",
	{cracky=3,stone=1, not_in_craft_guide=1},
	{"default_stone.png"},
	"Stone",
	stairs.stone)

stairs.register_all("desert_stone", "default:desert_stone",
	{cracky = 3,not_in_craft_guide=1},
	{"default_desert_stone.png"},
	"Desert Stone",
	stairs.stone)

stairs.register_all("mossycobble", "default:mossycobble",
	{cracky = 3,not_in_craft_guide=1},
	{"default_mossycobble.png"},
	"Mossy Cobble",
	stairs.stone)

stairs.register_all("brick", "default:brick",
	{cracky = 3,not_in_craft_guide=1},
	{"default_brick.png"},
	"Brick",
	stairs.stone)

stairs.register_all("clay", "default:clay",
	{crumbly = 3,not_in_craft_guide=1},
	{"default_clay.png"},
	"Clay",
	stairs.dirt)	

stairs.register_all("dirt", "default:dirt",
	{crumbly = 3,not_in_craft_guide=1},
	{"default_dirt.png"},
	"Dirt",
	stairs.dirt)		
	
stairs.register_all("sandstone", "default:sandstone",
	{crumbly = 1, cracky = 3,not_in_craft_guide=1},
	{"default_sandstone.png"},
	"Sandstone",
	stairs.stone)

stairs.register_all("glass", "default:glass",
	{cracky = 3, oddly_breakable_by_hand = 3,not_in_craft_guide=1},
	{"default_glass.png"},
	"Glass",
	stairs.glass)

stairs.register_all("obsidian_glass", "default:obsidian_glass",
	{cracky = 2,not_in_craft_guide=1},
	{"default_obsidian_glass.png"},
	"Obsidian Glass",
	stairs.glass)
	
--function stairs.register_all(subname, recipeitem, groups, images, desc, snds, alpha,light)
stairs.register_all("meselamp", "default:meselamp",
	{cracky = 3, oddly_breakable_by_hand = 3,not_in_craft_guide=1},
	{"default_meselamp.png"},
	"Meselamp",
	stairs.glass,
	"0,0,0",
	"14"
	)
	
stairs.register_all("sandstonebrick", "default:sandstonebrick",
	{cracky = 2,not_in_craft_guide=1},
	{"default_sandstone_brick.png"},
	"Sandstone Brick",
	stairs.stone)

stairs.register_stair_and_slab(
	"sandstone_block",
	"default:sandstone_block",
	{cracky = 2},
	{"default_sandstone_block.png"},
	"Sandstone Block Stair",
	"Sandstone Block Slab",
	default.node_sound_stone_defaults()
)

stairs.register_all("obsidian", "default:obsidian",
	{cracky = 1, level = 2,not_in_craft_guide=1},
	{"default_obsidian.png"},
	"Obsidian",
	stairs.stone)

stairs.register_stair_and_slab(
	"obsidian_block",
	"default:obsidian_block",
	{cracky = 1, level = 2},
	{"default_obsidian_block.png"},
	"Obsidian Block Stair",
	"Obsidian Block Slab",
	default.node_sound_stone_defaults()
)

stairs.register_all("stonebrick", "default:stonebrick",
	{cracky = 2,not_in_craft_guide=1},
	{"default_stone_brick.png"},
	"Stone Brick",
	stairs.stone)

	stairs.register_stair_and_slab(
	"stone_block",
	"default:stone_block",
	{cracky = 2},
	{"default_stone_block.png"},
	"Stone Block Stair",
	"Stone Block Slab",
	default.node_sound_stone_defaults()
)

stairs.register_all("desert_stonebrick", "default:desert_stonebrick",
	{cracky = 3,not_in_craft_guide=1},
	{"default_desert_stone_brick.png"},
	"Desert Stone Brick",
	stairs.stone)

stairs.register_stair_and_slab(
	"desert_stone_block",
	"default:desert_stone_block",
	{cracky = 2},
	{"default_desert_stone_block.png"},
	"Desert Stone Block Stair",
	"Desert Stone Block Slab",
	default.node_sound_stone_defaults()
)

stairs.register_all("obsidianbrick", "default:obsidianbrick",
	{cracky = 1, level = 3,not_in_craft_guide=1},
	{"default_obsidian_brick.png"},
	"Obsidian Brick",
	stairs.stone)

local colours = {
	{"black",      "Black",      "#000000b0"},
	{"blue",       "Blue",       "#015dbb70"},
	{"brown",      "Brown",      "#a78c4570"},
	{"cyan",       "Cyan",       "#01ffd870"},
	{"dark_green", "Dark Green", "#005b0770"},
	{"dark_grey",  "Dark Grey",  "#303030b0"},
	{"green",      "Green",      "#61ff0170"},
	{"grey",       "Grey",       "#5b5b5bb0"},
	{"magenta",    "Magenta",    "#ff05bb70"},
	{"orange",     "Orange",     "#ff840170"},
	{"pink",       "Pink",       "#ff65b570"},
	{"red",        "Red",        "#ff000070"},
	{"violet",     "Violet",     "#2000c970"},
	{"white",      "White",      "#abababc0"},
	{"yellow",     "Yellow",     "#e3ff0070"},
}

--= Coloured Blocks Mod
if minetest.get_modpath("cblocks") then

for i = 1, #colours, 1 do

-- wood stair

stairs.register_all(colours[i][1] .. "_wood", "cblocks:wood_" .. colours[i][1],
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 3,not_in_craft_guide=1},
	{"default_wood.png^[colorize:" .. colours[i][3]},
	colours[i][2] .. " Wooden",
	stairs.wood)

stairs.register_all(colours[i][1] .. "_glass", "cblocks:glass_" .. colours[i][1],
	{cracky = 3, oddly_breakable_by_hand = 3,not_in_craft_guide=1},
	{"cblocks.png^[colorize:" .. colours[i][3]},
	colours[i][2] .. " Glass",
	stairs.glass, true)

end --for

end

--= More Ores Mod
if minetest.get_modpath("moreores") then

grp = {cracky = 1, level = 2}

stairs.register_all("tin_block", "moreores:tin_block",
	grp,
	{"moreores_tin_block.png"},
	"Tin",
	stairs.stone)

stairs.register_all("silver_block", "moreores:silver_block",
	grp,
	{"moreores_silver_block.png"},
	"Silver",
	stairs.stone)

stairs.register_all("mithril_block", "moreores:mithril_block",
	grp,
	{"moreores_mithril_block.png"},
	"Mithril",
	stairs.stone)

end

--= Farming Mod
if minetest.get_modpath("farming") then

stairs.register_all("straw", "farming:straw",
	{snappy = 3, flammable = 4,not_in_craft_guide=1},
	{"farming_straw.png"},
	"Straw",
	stairs.leaves)

end

--= Mobs Mod

if mobs and mobs.mod and mobs.mod == "redo" then

grp = {crumbly = 3, flammable = 2,not_in_craft_guide=1}

stairs.register_all("cheeseblock", "mobs:cheeseblock",
	grp,
	{"mobs_cheeseblock.png"},
	"Cheese Block",
	stairs.dirt)

stairs.register_all("honey_block", "mobs:honey_block",
	grp,
	{"mobs_honey_block.png"},
	"Honey Block",
	stairs.dirt)

end

--= Lapis Mod

if minetest.get_modpath("lapis") then

grp = {cracky = 3}

stairs.register_all("lapis_block", "lapis:lapis_block",
	grp,
	{"lapis_block_side.png"},
	"Lapis",
	stairs.stone)

stairs.register_all("lapis_brick", "lapis:lapis_brick",
	grp,
	{"lapis_brick.png"},
	"Lapis Brick",
	stairs.stone)

stairs.register_all("lapis_cobble", "lapis:lapis_cobble",
	grp,
	{"lapis_cobble.png"},
	"Lapis Cobble",
	stairs.stone)

end

--= Homedecor Mod
--[[
if minetest.get_modpath("homedecor") then

local grp = {snappy = 3}

stairs.register_all("shingles_asphalt", "homedecor:shingles_asphalt",
	grp,
	{"homedecor_shingles_asphalt.png"},
	"Asphalt Shingle",
	stairs.leaves)

stairs.register_all("shingles_terracotta", "homedecor:roof_tile_terracotta",
	grp,
	{"homedecor_shingles_terracotta.png"},
	"Terracotta Shingle",
	stairs.leaves)

stairs.register_all("shingles_wood", "homedecor:shingles_wood",
	grp,
	{"homedecor_shingles_wood.png"},
	"Wooden Shingle",
	stairs.leaves)

end
]]
--= Xanadu Mod

if minetest.get_modpath("xanadu") then

grp = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3}

stairs.register_all("stained_wood_white", "xanadu:stained_wood_white",
	grp,
	{"stained_wood_white.png"},
	"White Wooden",
	stairs.wood)

stairs.register_all("stained_wood_red", "xanadu:stained_wood_red",
	grp,
	{"stained_wood_red.png"},
	"Red Wooden",
	stairs.wood)

-- Decorative blocks

grp = {cracky = 3}

stairs.register_all("stone1", "xanadu:stone1",
	grp,
	{"stone1.png"},
	"Decorative Stone 1",
	stairs.stone)

stairs.register_all("stone2", "xanadu:stone2",
	grp,
	{"stone2.png"},
	"Decorative Stone 2",
	stairs.stone)

stairs.register_all("stone3", "xanadu:stone3",
	grp,
	{"stone3.png"},
	"Decorative Stone 3",
	stairs.stone)

stairs.register_all("stone4", "xanadu:stone4",
	grp,
	{"stone4.png"},
	"Decorative Stone 4",
	stairs.stone)

stairs.register_all("stone5", "xanadu:stone5",
	grp,
	{"stone5.png"},
	"Decorative Stone 5",
	stairs.stone)

stairs.register_all("stone6", "xanadu:stone6",
	grp,
	{"stone6.png"},
	"Decorative Stone 6",
	stairs.stone)

stairs.register_all("sandstonebrick4", "xanadu:sandstonebrick4",
	grp,
	{"sandstonebrick4.png"},
	"Decorative Sandstone 4",
	stairs.stone)

stairs.register_slab("desert_cobble1", "xanadu:desert_cobble1",
	grp,
	{"desert_cobble1.png"},
	"Decorative desert cobble 1",
	stairs.stone)

stairs.register_slab("desert_cobble5", "xanadu:desert_cobble5",
	grp,
	{"desert_cobble5.png"},
	"Decorative desert cobble 5",
	stairs.stone)

stairs.register_slab("desert_stone1", "xanadu:desert_stone1",
	grp,
	{"desert_stone1.png"},
	"Decorative desert stone 1",
	stairs.stone)

stairs.register_slab("desert_stone3", "xanadu:desert_stone3",
	grp,
	{"desert_stone3.png"},
	"Decorative desert stone 3",
	stairs.stone)

stairs.register_slab("desert_stone4", "xanadu:desert_stone4",
	grp,
	{"desert_stone4.png"},
	"Decorative desert stone 4",
	stairs.stone)
stairs.register_stair("desert_stone4", "xanadu:desert_stone4",
	grp,
	{"desert_stone4.png"},
	"Decorative desert stone 4",
	stairs.stone)

stairs.register_slab("desert_stone5", "xanadu:desert_stone5",
	grp,
	{"desert_stone5.png"},
	"Decorative desert stone 5",
	stairs.stone)

stairs.register_slab("red1", "xanadu:red1",
	grp,
	{"baked_clay_red1.png"},
	"Decorative baked red clay 1",
	stairs.stone)

stairs.register_all("bred2", "xanadu:red2",
	grp,
	{"baked_clay_red2.png"},
	"Decorative baked red clay 2",
	stairs.stone)

end

--= Baked Clay mod

if minetest.get_modpath("bakedclay") then

for i = 1, #colours, 1 do

stairs.register_all("bakedclay_" .. colours[i][1], "bakedclay:" .. colours[i][1],
	{cracky = 3},
	{"baked_clay_" .. colours[i][1] .. ".png"},
	"Baked Clay " .. colours[i][2],
	stairs.stone)

end -- END for

end

--= Castle Mod

if minetest.get_modpath("castle") then

grp = {cracky = 2}

--stairs.register_all("pavement", "castle:pavement",
--	grp,
--	{"castle_pavement_brick.png"},
--	"Paving",
--	stairs.stone)

stairs.register_all("dungeon_stone", "castle:dungeon_stone",
	grp,
	{"castle_dungeon_stone.png"},
	"Dungeon",
	stairs.stone)

stairs.register_all("stonewall", "castle:stonewall",
	grp,
	{"castle_stonewall.png"},
	"Castle Wall",
	stairs.stone)

end

--= Wool Mod

if minetest.get_modpath("wool") then

for i = 1, #colours, 1 do

stairs.register_all("wool_" .. colours[i][1], "wool:" .. colours[i][1],
	{snappy = 2, choppy = 2, oddly_breakable_by_hand = 3, flammable = 3,not_in_craft_guide=1},
	{"wool_" .. colours[i][1] .. ".png"},
	colours[i][2] .. " Wool",
	stairs.stone)

end -- END for
end


--= Es Mod

if minetest.get_modpath("es") then

grp = {cracky = 3,not_in_craft_guide=1}

--Technic marble / Granite
stairs.register_all("granite", "es:granite",
	grp,
	{"technic_granite.png"},
	"Granite Block",	
	stairs.stone)

stairs.register_all("marble", "es:marble",
	grp,
	{"technic_marble.png"},
	"Marble Block",
	stairs.stone)

stairs.register_all("granite_bricks", "es:granite_bricks",
	grp,
	{"technic_granite_bricks.png"},
	"Granite Bricks Block",
	stairs.stone)
	
stairs.register_all("marble_bricks", "es:marble_bricks",
	grp,
	{"technic_marble_bricks.png"},
	"Marble Bricks Block",
	stairs.stone)
	
--Es Jewels
stairs.register_all("emerald", "es:emeraldblock",
	grp,
	{"emerald_block.png"},
	"Emerald Block",
	stairs.stone)
	
stairs.register_all("ruby", "es:rubyblock",
	grp,
	{"ruby_block.png"},
	"Ruby Block",
	stairs.stone)

stairs.register_all("aikerum", "es:aikerumblock",
	grp,
	{"aikerum_block.png"},
	"Aikerum Block",
	stairs.stone)

stairs.register_all("infinium", "es:infiniumblock",
	grp,
	{"infinium_block.png"},
	"Infinium Block",
	stairs.stone)
	
stairs.register_all("purpellium", "es:purpelliumblock",
	grp,
	{"purpellium_block.png"},
	"Purpellium Block",
	stairs.stone)

stairs.register_all("dirt", "default:dirt",
	{crumbly = 2,oddly_breakable_by_hand=1,not_in_craft_guide=1},
	{"default_dirt.png"},
	"Dirt Block",
	stairs.stone)	
	
stairs.register_all("boneblock", "es:boneblock",
	{crumbly = 2,oddly_breakable_by_hand=1,not_in_craft_guide=1},
	{"bones_front.png"},
	"Bone Block",
	stairs.stone)

stairs.register_all("messymese", "es:messymese",
	{crumbly = 2,oddly_breakable_by_hand=1,not_in_craft_guide=1},
	{"default_clay.png^bubble.png^mese_cook_mese_crystal.png"},
	"messymese",
	stairs.stone)	
	
end

if minetest.get_modpath("quartz") then

grp = {cracky=3, oddly_breakable_by_hand=1,not_in_craft_guide=1}

--Quartz
stairs.register_all("quartzblock", "quartz:block",
	grp,
	{"quartz_block.png"},
	"Quartz Block",	
	stairs.glass)
	
stairs.register_all("quartzpillar", "quartz:pillar",
	grp,
	{"quartz_pillar_top.png", "quartz_pillar_top.png", "quartz_pillar_side.png"},
	"Quartz Pillar",	
	stairs.glass)

stairs.register_all("quartzchiseled","quartz:chiseled",
	grp,
	{"quartz_chiseled.png"},
	"Chiseled Quartz",	
	stairs.glass)	
end

print ("[MOD] Stairs Redo loaded")
