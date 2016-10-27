--mod: admin tnt for survival server
-- idea by Andrey "lag01"
--coded by maikerumine



minetest.register_node("default:griefer_soul_block", {
	description = "A Block Of Griefer Souls",
	paramtype2 = "facedir",
	place_param2 = 0,
	--tiles = {"admin_tnt_top.png^heart.png", "admin_tnt_bottom.png^default_rail.png^heart.png", "admin_tnt_side.png^default_rail.png"},
	tiles = {"bones_front.png^[colorize:red:120", "bones_front.png^[colorize:red:120", "bones_front.png^[colorize:red:120"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1,dig_immediate=2},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("default:admin_tnt_fake", {
	description = "Fake Admin TNT",
	tiles = {"admin_tnt_top.png", "admin_tnt_bottom.png", "admin_tnt_side.png"},
	groups = {choppy = 2,immortal = 1},
	--drop = 'default:admin_tnt_fake',
	sounds = default.node_sound_wood_defaults(),
	after_place_node = function(pos, puncher)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", puncher:get_player_name() or "")
		meta:set_string("infotext", "Fake TNT (placed by " ..
				meta:get_string("owner") .. ")")
	end,
})

minetest.register_node("default:admin_tnt", {
	description = "ADMIN TNT  Changes to tnt after 12 hour timer.",
	paramtype2 = "facedir",
	place_param2 = 0,
	--tiles = {"admin_tnt_top.png^heart.png", "admin_tnt_bottom.png^default_rail.png^heart.png", "admin_tnt_side.png^default_rail.png"},
	tiles = {"admin_tnt_top.png", "admin_tnt_bottom.png", "admin_tnt_side.png"},
	is_ground_content = false,
	groups = {cracky = 0,choppy = 1},
	drop ='default:admin_tnt_fake',
	sounds = default.node_sound_wood_defaults(),
	
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "ADMIN TNT (placed by " ..
				meta:get_string("owner") .. ")")
				minetest.sound_play("tnt_ignite", {pos=pos})
				minetest.after(60, function()
				minetest.sound_play("tnt_ignite", {pos=pos})
					
				end)
	end,
	
	on_punch = function(pos, node, puncher)
		--if puncher:get_wielded_item():get_name() == "default:mese" then
		if puncher:get_wielded_item():get_name() == "default:griefer_soul_block" then
			minetest.sound_play("tnt_ignite", {pos=pos})
			--minetest.set_node(pos, {name="tnt:tnt_burning"}) --sets to instant explosion
			minetest.set_node(pos, {name="tnt:tnt"})  --sets to regular tnt for controlled demolition
			boom(pos, 0)
		end
	end,

	on_dig = function(pos, node, puncher)
		if puncher:get_wielded_item():get_name() == "default:axe_mese" then
			minetest.sound_play("tnt_ignite", {pos=pos})
			minetest.set_node(pos, {name="tnt:tnt_burning"})
			boom(pos, 0)
			minetest.after(2, function()
			minetest.sound_play("tnt_ignite", {pos=pos})
				minetest.set_node(pos, {name="default:admin_tnt_fake"})
			end)
		end	
	end,
})

minetest.register_node("default:admin_tnt_fast", {
	description = "ADMIN TNT  Changes to tnt after 60 second hour timer",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"admin_tnt_top.png^heart.png", "admin_tnt_bottom.png^default_mineral_copper.png^heart.png", "admin_tnt_side.png^default_rail.png"},
	is_ground_content = false,
	groups = {cracky = 0},
	sounds = default.node_sound_wood_defaults(),
	
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "ADMIN TNT FAST (placed by " ..
				meta:get_string("owner") .. ")")
	end,
	
	on_punch = function(pos, node, puncher)
		if puncher:get_wielded_item():get_name() == "default:griefer_soul_block" then
			minetest.sound_play("tnt_ignite", {pos=pos})
			minetest.set_node(pos, {name="tnt:tnt_burning"})
			--minetest.set_node(pos, {name="tnt:tnt"})
			boom(pos, 0)
		end
	end,
})

minetest.register_abm({
	nodenames = {"default:admin_tnt"},
	interval = 43200,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
	minetest.sound_play("tnt_ignite", {pos=pos})
			if node.name == "default:admin_tnt" then
				minetest.set_node(pos, {name="tnt:tnt_burning"})
				boom(pos, 0)
			end
			--end
	end,
})


minetest.register_abm({
	nodenames = {"default:admin_tnt_fast"},
	interval = 60,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
	minetest.sound_play("tnt_ignite", {pos=pos})
			if node.name == "default:admin_tnt_fast" then
				--minetest.set_node(pos, {name="tnt:tnt_boom"})
				minetest.set_node(pos, {name="tnt:tnt_burning"})
				boom(pos, 0)
			end
			--end
	end,
})

minetest.register_craft({
	output = 'default:griefer_soul_block',
	recipe = {
		{'default:griefer_soul', 'default:griefer_soul', 'default:griefer_soul'},
		{'default:griefer_soul', 'default:griefer_soul', 'default:griefer_soul'},
		{'default:griefer_soul', 'default:griefer_soul', 'default:griefer_soul'},
	}
})

minetest.register_craft({
	output = 'default:admin_tnt',
	recipe = {
		{'default:wood', 'tnt:gunpowder', 'default:wood'},
		{'tnt:gunpowder', 'default:griefer_soul_block', 'tnt:gunpowder'},
		{'default:wood', 'tnt:gunpowder', 'default:wood'},
	}
})
--[[
minetest.register_craft({
	output = 'default:admin_tnt_fast',
	recipe = {
		{'default:copperblock', 'tnt:gunpowder', 'default:copperblock'},
		{'tnt:gunpowder', 'default:griefer_soul_block', 'tnt:gunpowder'},
		{'default:copperblock', 'tnt:gunpowder', 'default:copperblock'},
	}
})
]]
minetest.register_craftitem("default:griefer_soul", {
	description = "Griefer Soul",
	inventory_image = "default_coal_lump.png^[colorize:red:120",
})
