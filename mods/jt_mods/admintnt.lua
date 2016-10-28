--mod: admin tnt for survival server
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

minetest.register_node("jt_mods:admin_tnt_fake", {
	description = "Fake Admin TNT",
	tiles = {"admin_tnt_top.png", "admin_tnt_bottom.png", "admin_tnt_side.png"},
	groups = {choppy = 2,immortal = 1},
	--drop = 'jt_mods:admin_tnt_fake',
	sounds = default.node_sound_wood_defaults(),
	after_place_node = function(pos, puncher)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", puncher:get_player_name() or "")
		meta:set_string("infotext", "Fake TNT (placed by " ..
				meta:get_string("owner") .. ")")
	end,
})

minetest.register_node("jt_mods:admin_tnt", {
	description = "ADMIN TNT  Changes to tnt after 12 hour timer.",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"admin_tnt_top.png", "admin_tnt_bottom.png", "admin_tnt_side.png"},
	is_ground_content = false,
	groups = {cracky = 0,choppy = 1},
	drop ='jt_mods:admin_tnt_fake',
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
		if puncher:get_wielded_item():get_name() == "jt_mods:griefer_soul_block" then
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
				minetest.set_node(pos, {name="jt_mods:admin_tnt_fake"})
			end)
		end	
	end,
})

minetest.register_node("jt_mods:admin_tnt_fast", {
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
		if puncher:get_wielded_item():get_name() == "jt_mods:griefer_soul_block" then
			minetest.sound_play("tnt_ignite", {pos=pos})
			minetest.set_node(pos, {name="tnt:tnt_burning"})
			--minetest.set_node(pos, {name="tnt:tnt"})
			boom(pos, 0)
		end
	end,
})

minetest.register_abm({
	nodenames = {"jt_mods:admin_tnt"},
	interval = 43200,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
	minetest.sound_play("tnt_ignite", {pos=pos})
			if node.name == "jt_mods:admin_tnt" then
				minetest.set_node(pos, {name="tnt:tnt_burning"})
				boom(pos, 0)
			end
			--end
	end,
})

minetest.register_abm({
	nodenames = {"jt_mods:admin_tnt_fast"},
	interval = 60,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
	minetest.sound_play("tnt_ignite", {pos=pos})
			if node.name == "jt_mods:admin_tnt_fast" then
				--minetest.set_node(pos, {name="tnt:tnt_boom"})
				minetest.set_node(pos, {name="tnt:tnt_burning"})
				boom(pos, 0)
			end
			--end
	end,
})


