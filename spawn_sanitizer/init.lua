-- Minetest 0.4 mod: spawn_sanitizer
-- Bones are eventually removed from spawn.
--
-- See README.txt for licensing and other information.

spawn_sanitizer = {}
spawn_sanitizer.cleaned=false
spawn_sanitizer.timer=0

minetest.registered_nodes["bones:bones"].groups = {dig_immediate=3}
local facedir_for_bones = 4
--[[
minetest.register_abm({
	nodenames = {"bones:bones"},
	interval = 600,
	chance = 1,
	action = function(pos)
		local owner = minetest.get_meta(pos):get_string("owner")
		if owner=="" then
			local node=minetest.get_node(pos)
			local nodeinventory = minetest.get_meta(pos):get_inventory()
			if  node.param2 ~= facedir_for_bones then
				if nodeinventory:is_empty("main") then
					node.param2=facedir_for_bones
					minetest.swap_node(pos, node)
				end
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"bones:bones"},
	interval = 1200,
	chance = 6,
	action = function(pos)
		if pos.x>-80 and pos.x<80 and pos.z>-80 and pos.z<80 and pos.y>-45 then
			local owner = minetest.get_meta(pos):get_string("owner")
			if owner=="" then
				local node=minetest.get_node(pos)
				local nodeinventory = minetest.get_meta(pos):get_inventory()
				if  node.param2 ~= facedir_for_bones then
					if not nodeinventory:is_empty("main") then
						nodeinventory:remove_item("main", "default:pick_wood")
						nodeinventory:remove_item("main", "default:torch")
						nodeinventory:remove_item("main", "default:apple")
						nodeinventory:remove_item("main", "default:cobble")
						nodeinventory:remove_item("main", "default:furnace")
						nodeinventory:remove_item("main", "stairs:stair_cobble")
						nodeinventory:remove_item("main", "stairs:slab_cobble")
						nodeinventory:remove_item("main", "bones:bones")
					end
				end
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"bones:bones"},
	interval = 3000,
	chance = 8,
	action = function(pos)
		if pos.x>-40 and pos.x<40 and pos.z>-40 and pos.z<40 and pos.y>-45 then
			local owner = minetest.get_meta(pos):get_string("owner")
			if owner=="" then
				local node=minetest.get_node(pos)
				local nodeinventory = minetest.get_meta(pos):get_inventory()
				if  node.param2 == facedir_for_bones then
					if nodeinventory:is_empty("main") then
						minetest.remove_node(pos)
					end
				end
			end
		end
	end,
})
]]
minetest.after(75, function(dtime)

	if spawn_sanitizer.cleaned==true then
		return
	end

	local positions1 = minetest.find_nodes_in_area(
		{x=-20, y=-4, z=-20},
		{x=20, y=1, z=20},
		{"air", "default:water_flowing", "default:water_source"})
	for _, pos in ipairs(positions1) do
		minetest.set_node(pos, {name="default:cobble"})
	end
	local positions2 = minetest.find_nodes_in_area(
		{x=-21, y=0, z=-21},
		{x=21, y=0, z=21},
		{"air", "default:water_flowing", "default:water_source"})
	for _, pos in ipairs(positions2) do
		minetest.set_node(pos, {name="default:cobble"})
	end
	local positions3 = minetest.find_nodes_in_area(
		{x=-22, y=-1, z=-22},
		{x=22, y=-1, z=22},
		{"air", "default:water_flowing", "default:water_source"})
	for _, pos in ipairs(positions3) do
		minetest.set_node(pos, {name="default:cobble"})
	end
	local positions4 = minetest.find_nodes_in_area(
		{x=-23, y=-2, z=-23},
		{x=23, y=-2, z=23},
		{"air", "default:water_flowing", "default:water_source"})
	for _, pos in ipairs(positions4) do
		minetest.set_node(pos, {name="default:cobble"})
	end
	local positions5 = minetest.find_nodes_in_area(
		{x=-24, y=-3, z=-24},
		{x=24, y=-3, z=24},
		{"air", "default:water_flowing", "default:water_source"})
	for _, pos in ipairs(positions5) do
		minetest.set_node(pos, {name="default:cobble"})
	end

	local positions6 = minetest.find_nodes_in_area(
		{x=-19, y=2, z=-19},
		{x=19, y=70, z=19},
		{"default:cobble", "default:stone", "default:water_source", "default:lava_source"})
	for _, pos in ipairs(positions6) do
		minetest.set_node(pos, {name="air"})
	end

	local positions7 = minetest.find_nodes_in_area(
		{x=-20, y= 1, z=-20},
		{x=20, y=50, z=20},
		{"default:furnace"})
	for _, pos in ipairs(positions7) do
		minetest.set_node(pos, {name="air"})
	end

	local positions8 = minetest.find_nodes_in_area(
		{x=-3, y=-3, z=-3},
		{x=3, y=0, z=3},
		{"default:cobble"})
	for _, pos in ipairs(positions8) do
		minetest.set_node(pos, {name="air"})
	end

	local positions9 = minetest.find_nodes_in_area(
		{x=-2, y=1, z=-2},
		{x=2, y=2, z=2},
		{"default:tree"})
	for _, pos in ipairs(positions9) do
		minetest.set_node(pos, {name="air"})
	end

	local positions10 = minetest.find_nodes_in_area(
		{x=-20, y=1, z=-20},
		{x=20, y=20, z=20},
		{"default:ice"})
	for _, pos in ipairs(positions10) do
		minetest.set_node(pos, {name="air"})
	end

	local positions11 = minetest.find_nodes_in_area(
		{x=-20, y=-2, z=-20},
		{x=20, y=20, z=20},
		{"default:chest_locked"})
	for _, pos in ipairs(positions11) do
		minetest.set_node(pos, {name="air"})
	end

	local positions12 = minetest.find_nodes_in_area(
		{x=-20, y=-10, z=-20},
		{x=20, y=20, z=20},
		{"default:jungletree"})
	for _, pos in ipairs(positions12) do
		minetest.set_node(pos, {name="air"})
	end

	local positions13 = minetest.find_nodes_in_area(
		{x=-20, y=-10, z=-20},
		{x=20, y=20, z=20},
		{"vendor:vendor"})
	for _, pos in ipairs(positions13) do
		minetest.set_node(pos, {name="air"})
	end

	local positions14 = minetest.find_nodes_in_area(
		{x=-20, y=-10, z=-20},
		{x=20, y=20, z=20},
		{"vendor:depositor"})
	for _, pos in ipairs(positions14) do
		minetest.set_node(pos, {name="air"})
	end

	local positions15 = minetest.find_nodes_in_area(
		{x=-20, y=-20, z=-20},
		{x=20, y=20, z=20},
		{"doors:door_steel_t_1"})
	for _, pos in ipairs(positions15) do
		minetest.set_node(pos, {name="air"})
	end

	local positions16 = minetest.find_nodes_in_area(
		{x=-20, y=-20, z=-20},
		{x=20, y=20, z=20},
		{"doors:door_steel_b_1"})
	for _, pos in ipairs(positions16) do
		minetest.set_node(pos, {name="air"})
	end

	local positions17 = minetest.find_nodes_in_area(
		{x=-20, y=-20, z=-20},
		{x=20, y=20, z=20},
		{"doors:door_steel_t_2"})
	for _, pos in ipairs(positions17) do
		minetest.set_node(pos, {name="air"})
	end

	local positions18 = minetest.find_nodes_in_area(
		{x=-20, y=-20, z=-20},
		{x=20, y=20, z=20},
		{"doors:door_steel_b_2"})
	for _, pos in ipairs(positions18) do
		minetest.set_node(pos, {name="air"})
	end

--[[
	local positions18 = minetest.find_nodes_in_area(
		{x=-20, y=1, z=-20},
		{x=20, y=20, z=20},
		{"bones:bones"})
	for _, pos in ipairs(positions18) do
		minetest.set_node(pos, {name="air"})
	end
]]
	for z1=-27, -16 do
		minetest.set_node({x=37, y=2, z=z1}, {name="default:rail"})
        minetest.set_node({x=37, y=1, z=z1}, {name="default:stonebrick"})
	end
	for z1=16, 29 do
		minetest.set_node({x=37, y=2, z=z1}, {name="default:rail"})
        minetest.set_node({x=37, y=1, z=z1}, {name="default:stonebrick"})
	end
	for z1=-15, 15 do
		minetest.set_node({x=37, y=2, z=z1}, {name="carts:brakerail"})
        minetest.set_node({x=37, y=1, z=z1}, {name="default:stonebrick"})
	end
	for x1=36, 17, -1 do
		minetest.set_node({x=x1, y=2, z=-27}, {name="default:rail"})
		minetest.set_node({x=x1, y=2, z=29}, {name="default:rail"})
        minetest.set_node({x=x1, y=1, z=-27}, {name="default:stonebrick"})
        minetest.set_node({x=x1, y=1, z=29}, {name="default:stonebrick"})
	end
	for x1=16, 2, -1 do
		minetest.set_node({x=x1, y=2, z=-27}, {name="carts:powerrail"})
		minetest.set_node({x=x1, y=2, z=29}, {name="carts:powerrail"})
        minetest.set_node({x=x1, y=1, z=-27}, {name="default:stonebrick"})
        minetest.set_node({x=x1, y=1, z=29}, {name="default:stonebrick"})
	end
	for z1=-26, -17 do
		minetest.set_node({x=2, y=2, z=z1}, {name="default:rail"})
        minetest.set_node({x=2, y=1, z=z1}, {name="default:stonebrick"})
	end
	for z1=17, 28 do
		minetest.set_node({x=2, y=2, z=z1}, {name="default:rail"})
        minetest.set_node({x=2, y=1, z=z1}, {name="default:stonebrick"})
	end
	for z1=-17, 17 do
		minetest.set_node({x=3, y=2, z=z1}, {name="default:rail"})
        minetest.set_node({x=3, y=1, z=z1}, {name="default:stonebrick"})
	end
	minetest.add_entity({x=3, y=2, z=0}, "carts:cart")

	if not spawn_sanitizer.cleaned then
		spawn_sanitizer.cleaned=true
		minetest.log("action", "Spawn sanitized!")
	end
end)

-- no more protection blocks at spawn!
local old_node_place = minetest.item_place
function minetest.item_place(itemstack, placer, pointed_thing)
	if itemstack:get_definition().type == "node" then
		local ok=true
		if itemstack:get_name() == "protector:protect" then
			local pos = pointed_thing.above
			if not placer or not placer.get_player_name then return false end
			if pos.x>-27 and pos.x<27 and pos.z>-27 and pos.z<27 then
				minetest.chat_send_player(placer:get_player_name(), "Spawn belongs to all")
				if minetest.get_player_privs(placer:get_player_name()).delprotect then
					ok=true
				else
					ok=false
				end
			end
		end
		if ok == true then
			return old_node_place(itemstack, placer, pointed_thing)
		else
			return
		end
	end
	return old_node_place(itemstack, placer, pointed_thing)
end
-- no more gravel blocks at spawn!
local old_node_place = minetest.item_place
function minetest.item_place(itemstack, placer, pointed_thing)
	if itemstack:get_definition().type == "node" then
		local ok=true
		if itemstack:get_name() == "default:gravel" then
			local pos = pointed_thing.above
			if not placer or not placer.get_player_name then return false end
			if pos.x>-27 and pos.x<27 and pos.z>-27 and pos.z<27 then
				minetest.chat_send_player(placer:get_player_name(), "Gravel is for TNT not building.")
				if minetest.get_player_privs(placer:get_player_name()).delprotect then
					ok=true
				else
					ok=false
				end
			end
		end
		if ok == true then
			return old_node_place(itemstack, placer, pointed_thing)
		else
			return
		end
	end
	return old_node_place(itemstack, placer, pointed_thing)
end
-- no more sand blocks at spawn!
local old_node_place = minetest.item_place
function minetest.item_place(itemstack, placer, pointed_thing)
	if itemstack:get_definition().type == "node" then
		local ok=true
		if itemstack:get_name() == "default:sand" then
			local pos = pointed_thing.above
			if not placer or not placer.get_player_name then return false end
			if pos.x>-27 and pos.x<27 and pos.z>-27 and pos.z<27 then
				minetest.chat_send_player(placer:get_player_name(), "NOPE!!!  You cannot place sand here!")
				if minetest.get_player_privs(placer:get_player_name()).delprotect then
					ok=true
				else
					ok=false
				end
			end
		end
		if ok == true then
			return old_node_place(itemstack, placer, pointed_thing)
		else
			return
		end
	end
	return old_node_place(itemstack, placer, pointed_thing)
end


-- punish for lava at spawn, by TNT!
local old_bucket_lava_on_place=minetest.registered_craftitems["bucket:bucket_lava"].on_place
minetest.registered_craftitems["bucket:bucket_lava"].on_place=function(itemstack, placer, pointed_thing)
	local pos = pointed_thing.above
    if pos.x>-35 and pos.x<35 and pos.y>56 and pos.z>-35 and pos.z<35 then
        minetest.log("action", "Player warned for placing lava!")
        minetest.set_node({x=pos.x, y=pos.y-1, z=pos.z}, {name="tnt:tnt_burning"})
        boom({x=pos.x, y=pos.y-1, z=pos.z}, math.random(1, 3))
        minetest.sound_play("tnt_ignite", {pos=pos})
    end
	return old_bucket_lava_on_place(itemstack, placer, pointed_thing)
end
