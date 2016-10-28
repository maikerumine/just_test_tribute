
--[[
	Big thanks to PainterlyPack.net for allowing me to use these textures
]]


-- pumpkin
minetest.register_node("default:pumpkin", {
	description = "Pumpkin",
	tiles = {
		"farming_pumpkin_top.png",
		"farming_pumpkin_top.png",
		"farming_pumpkin_side.png"
	},
	groups = {
		choppy = 1, oddly_breakable_by_hand = 1,
		flammable = 2, plant = 1
	},
	drop = {
		items = {
			{items = {'default:pumpkin_slice 9'}, rarity = 1},
		}
	},
	sounds = default.node_sound_wood_defaults(),
})

-- pumpkin slice
minetest.register_craftitem("default:pumpkin_slice", {
	description ="Pumpkin Slice",
	inventory_image = "farming_pumpkin_slice.png",
	--[[
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "default:pumpkin_1")
	end,
	]]
	on_use = minetest.item_eat(2),
})

minetest.register_craft({
	output = "default:pumpkin",
	recipe = {
		{"default:pumpkin_slice", "default:pumpkin_slice", "default:pumpkin_slice"},
		{"default:pumpkin_slice", "default:pumpkin_slice", "default:pumpkin_slice"},
		{"default:pumpkin_slice", "default:pumpkin_slice", "default:pumpkin_slice"},
	}
})

minetest.register_craft({
	output = "default:pumpkin_slice 9",
	recipe = {
		{"", "default:pumpkin", ""},
	}
})

-- jack 'o lantern
minetest.register_node("default:jackolantern", {
	description = "Jack 'O Lantern",
	tiles = {
		"farming_pumpkin_top.png",
		"farming_pumpkin_top.png",
		"farming_pumpkin_side.png",
		"farming_pumpkin_side.png",
		"farming_pumpkin_side.png",
		"farming_pumpkin_face_off.png"
	},
	paramtype2 = "facedir",
	groups = {choppy = 1, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_punch = function(pos, node, puncher)
		node.name = "default:jackolantern_on"
		minetest.swap_node(pos, node)
	end,
})

minetest.register_node("default:jackolantern_on", {
	tiles = {
		"farming_pumpkin_top.png",
		"farming_pumpkin_top.png",
		"farming_pumpkin_side.png",
		"farming_pumpkin_side.png",
		"farming_pumpkin_side.png",
		"farming_pumpkin_face_on.png"
	},
	light_source = default.LIGHT_MAX - 1,
	paramtype2 = "facedir",
	groups = {choppy = 1, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	drop = "default:jackolantern",
	on_punch = function(pos, node, puncher)
		node.name = "default:jackolantern"
		minetest.swap_node(pos, node)
	end,
})

minetest.register_craft({
	output = "default:jackolantern",
	recipe = {
		{"", "", ""},
		{"", "default:torch", ""},
		{"", "default:pumpkin", ""},
	}
})

-- pumpkin bread
minetest.register_craftitem("default:pumpkin_bread", {
	description = "Pumpkin Bread",
	inventory_image = "farming_pumpkin_bread.png",
	on_use = minetest.item_eat(8)
})

minetest.register_craftitem("default:pumpkin_dough", {
	description = "Pumpkin Dough",
	inventory_image = "farming_pumpkin_dough.png",
})

minetest.register_craft({
	output = "default:pumpkin_dough",
	type = "shapeless",
	recipe = {"farming:flour", "default:pumpkin_slice", "default:pumpkin_slice"}
})

minetest.register_craft({
	type = "cooking",
	output = "default:pumpkin_bread",
	recipe = "default:pumpkin_dough",
	cooktime = 10
})

-- pumpkin definition
local crop_def = {
	drawtype = "plantlike",
	tiles = {"farming_pumpkin_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = "",
	--selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults()
}

-- stage 1
minetest.register_node("default:pumpkin_1", table.copy(crop_def))

-- stage 2
crop_def.tiles = {"farming_pumpkin_2.png"}
minetest.register_node("default:pumpkin_2", table.copy(crop_def))

-- stage 3
crop_def.tiles = {"farming_pumpkin_3.png"}
minetest.register_node("default:pumpkin_3", table.copy(crop_def))

-- stage 4
crop_def.tiles = {"farming_pumpkin_4.png"}
minetest.register_node("default:pumpkin_4", table.copy(crop_def))

-- stage 5
crop_def.tiles = {"farming_pumpkin_5.png"}
minetest.register_node("default:pumpkin_5", table.copy(crop_def))

-- stage 6
crop_def.tiles = {"farming_pumpkin_6.png"}
minetest.register_node("default:pumpkin_6", table.copy(crop_def))

-- stage 7
crop_def.tiles = {"farming_pumpkin_7.png"}
minetest.register_node("default:pumpkin_7", table.copy(crop_def))

-- stage 8 (final)
crop_def.tiles = {"farming_pumpkin_8.png"}
crop_def.groups.growing = 0
crop_def.drop = {
	items = {
		{items = {'default:pumpkin_slice 9'}, rarity = 1},
	}
}
minetest.register_node("default:pumpkin_8", table.copy(crop_def))
