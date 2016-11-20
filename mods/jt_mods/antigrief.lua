-- ANTI GRIEF by rnd
-- Copyright 2016 rnd
--Edited by maikerumine for TNT

----------------------------------------------------------------------------
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
----------------------------------------------------------------------------

--TNT only below 150!

function no_tnt_above(name)

	local tnt_on_place=minetest.registered_craftitems[name];--.on_place;
	local tnt_after_place_node = minetest.registered_nodes[name];--.after_place_node;
	--after_place_node = func(pos, placer, itemstack, pointed_thing)
	
	if tnt_on_place and tnt_on_place.on_place then
		tnt_on_place=tnt_on_place.on_place;
		minetest.registered_craftitems[name].on_place=function(itemstack, placer, pointed_thing)
			local pos = pointed_thing.above
			if pos.y>-150 then
				minetest.log("action","ANTI GRIEF " .. placer:get_player_name() .. " tried to place " .. name .. " at " .. minetest.pos_to_string(pos));
				return itemstack
			else
				--return tnt_on_place(itemstack, placer, pointed_thing)
			end
		end
	return;
	end

	if tnt_after_place_node then

		tntafter_place_node=tnt_after_place_node.after_place_node
		
		local table = minetest.registered_nodes[name];
		local table2 = {}
		for i,v in pairs(table) do
			table2[i] = v
		end
		
		table2.after_place_node=function(pos, placer, itemstack, pointed_thing)
			--after_place_node = func(pos, placer, itemstack, pointed_thing)
			local pos = pointed_thing.above
			if pos.y>-150 then
				minetest.log("action","ANTI GRIEF " .. placer:get_player_name() .. " tried to place " .. name .. " at " .. minetest.pos_to_string(pos));
				minetest.set_node(pos, {name = "air"});
				--return itemstack
			end
		end
		
		
		minetest.register_node(":"..name, table2)
		return;
	end 
	
		
	return;
end
	

minetest.after(0,
function ()
 no_tnt_above("tnt:tnt");

end
)



--everamaza code 
minetest.register_privilege("liquid", "Can place liquid source nodes.")
minetest.register_privilege("lava", "Can use liquid igniters.")
minetest.register_privilege("water", "Can use liquid.")


--lava bucket
local old_lava_bucket_place = minetest.registered_items["bucket:bucket_lava"].on_place

minetest.override_item("bucket:bucket_lava", {
	on_place = function(itemstack, placer, pointed_thing)
		if not minetest.check_player_privs(placer:get_player_name(),
				{lava = true}) then
			return itemstack
		else
			return old_lava_bucket_place(itemstack, placer, pointed_thing)
		end
	end,
})


--water bucket
local old_water_bucket_place = minetest.registered_items["bucket:bucket_water"].on_place

minetest.override_item("bucket:bucket_water", {
	on_place = function(itemstack, placer, pointed_thing)
		if not minetest.check_player_privs(placer:get_player_name(),
				{water = true}) then
			return itemstack
		else
			return old_water_bucket_place(itemstack, placer, pointed_thing)
		end
	end,
})

--source blocks
minetest.override_item("default:lava_source", {
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		if not minetest.check_player_privs(placer:get_player_name(),
				{liquid = true, lava = true}) then
			minetest.remove_node(pos)
		end
	end,
})

minetest.override_item("default:water_source", {
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		if not minetest.check_player_privs(placer:get_player_name(),
				{liquid = true}) then
			minetest.remove_node(pos)
		end
	end,
})

minetest.override_item("default:river_water_source", {
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		if not minetest.check_player_privs(placer:get_player_name(),
				{liquid = true}) then
			minetest.remove_node(pos)
		end
	end,
})
