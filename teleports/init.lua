teleports = {}
teleports.teleports = {}
teleports.lastplayername =""
teleports.filename = minetest.get_worldpath() .. "/teleports.txt"

function teleports:save()
    local datastring = minetest.serialize(self.teleports)
    if not datastring then
        return
    end
    local file, err = io.open(self.filename, "w")
    if err then
        return
    end
    file:write(datastring)
    file:close()
end
function teleports:load()
    local file, err = io.open(self.filename, "r")
    if err then
        self.teleports = {}
        return
    end
    self.teleports = minetest.deserialize(file:read("*all"))
    if type(self.teleports) ~= "table" then
        self.teleports = {}
    end
    file:close()
end
function teleports:find_nearby(pos, count)
    local nearby = {}
    for i = #teleports.teleports, 1, -1 do
        local EachTeleport = teleports.teleports[i]
        if not vector.equals(EachTeleport.pos, pos) and vector.distance(EachTeleport.pos, pos) < 260 then
            table.insert(nearby, EachTeleport)
            if #nearby>count then
                break
            end
        end
    end
    return nearby
end
teleports.set_formspec = function(pos)
	local meta = minetest.get_meta(pos)
	local node = minetest.get_node(pos)
    
    local buttons = "";
    for i, EachTeleport in ipairs( teleports:find_nearby(pos, 5) ) do
        buttons = buttons.."button_exit[3,"..(i)..";2,0.5;tp"..i..";GO>"..EachTeleport.pos.x..","..EachTeleport.pos.y..","..EachTeleport.pos.z.."]";
    end
    
	meta:set_string("formspec", "size[8,10;]"
		.."label[0,0;" .. 'Go to available teleports! Use mossy cobble as fuel!' .. "]"
        .."list[current_name;price;0,1;1,1;]"

        ..buttons

		.."button_exit[1,5;2,0.5;cancel;Cancel]"
        .."list[current_player;main;0,6;8,4;]")
end
teleports.on_receive_fields = function(pos, formname, fields, player)
    local meta = minetest.env:get_meta(pos);
	local inv = meta:get_inventory();
    local price = {name="default:mossycobble", count=1, wear=0, metadata=""}
    if fields.tp1 or fields.tp2 or fields.tp3 or fields.tp4 or fields.tp5 or fields.tp6 then
        if inv:contains_item("price", price) then
            inv:remove_item("price", price);
            local available = teleports:find_nearby(pos, 5)
            if player ~= nil and player:is_player() then
                if fields.tp1 and #available>0 then
                    player:setpos({x=available[1].pos.x,y=available[1].pos.y+0.5,z=available[1].pos.z})
                    teleports.lastplayername = player:get_player_name()
                elseif fields.tp2 and #available>1 then
                    player:setpos({x=available[2].pos.x,y=available[2].pos.y+0.5,z=available[2].pos.z})
                    teleports.lastplayername = player:get_player_name()
                elseif fields.tp3 and #available>2 then
                    player:setpos({x=available[3].pos.x,y=available[3].pos.y+0.5,z=available[3].pos.z})
                    teleports.lastplayername = player:get_player_name()
                elseif fields.tp4 and #available>3 then
                    player:setpos({x=available[3].pos.x,y=available[3].pos.y+0.5,z=available[3].pos.z})
                    teleports.lastplayername = player:get_player_name()
                elseif fields.tp5 and #available>4 then
                    player:setpos({x=available[5].pos.x,y=available[5].pos.y+0.5,z=available[5].pos.z})
                    teleports.lastplayername = player:get_player_name()
                elseif fields.tp6 and #available>5 then
                    player:setpos({x=available[6].pos.x,y=available[6].pos.y+0.5,z=available[6].pos.z})
                    teleports.lastplayername = player:get_player_name()
                end
            end
            
            teleports.set_formspec(pos)
        end
    end
end
teleports.allow_metadata_inventory_put = function(pos, listname, index, stack, player)
    if listname=="price" and stack:get_name()=="default:mossycobble" then
        return 99
    else
        return 0
    end
end
teleports.allow_metadata_inventory_take = function(pos, listname, index, stack, player)
	return 0
end

teleports:load()


minetest.register_node("teleports:teleport", {
	description = "Teleport",
	drawtype = "glasslike",
	tiles = {"teleports_teleport_top.png"},
	is_ground_content = false,
	light_source = LIGHT_MAX,
	groups = {cracky=1, level=3},
	drop = 'default:diamond',
	sounds = default.node_sound_stone_defaults(),
    after_place_node = function(pos, placer)
        if placer and placer:is_player() then
            local meta = minetest.env:get_meta(pos)
            local inv = meta:get_inventory()
            inv:set_size("price", 1)
            local initialcharge = {name="default:mossycobble", count=30, wear=0, metadata=""}
            inv:add_item("price", initialcharge)
            teleports.set_formspec(pos)
            table.insert(teleports.teleports, {pos=vector.round(pos)} )
            teleports:save()
        end
    end,
    on_destruct = function(pos)
        for i, EachTeleport in ipairs(teleports.teleports) do
            if vector.equals(EachTeleport.pos, pos) then
                table.remove(teleports.teleports, i)
                teleports:save()
            end
        end
    end,
    on_receive_fields = teleports.on_receive_fields,
    allow_metadata_inventory_put = teleports.allow_metadata_inventory_put,
    allow_metadata_inventory_take = teleports.allow_metadata_inventory_take,
})


--redefine diamond
minetest.register_node(":default:diamondblock", {
	description = "Diamond Block",
	tiles = {"default_diamond_block.png"},
	is_ground_content = true,
	groups = {cracky=1,level=3},
	sounds = default.node_sound_stone_defaults(),
	on_place = function(itemstack, placer, pointed_thing)
		local stack = ItemStack("default:diamondblock")
		local pos = pointed_thing.above
		if
			minetest.get_node({x=pos.x+1,y=pos.y,z=pos.z}).name=="default:diamondblock" and
			minetest.get_node({x=pos.x+1,y=pos.y,z=pos.z+1}).name=="default:diamondblock" and
			minetest.get_node({x=pos.x+1,y=pos.y,z=pos.z-1}).name=="default:diamondblock" and
			minetest.get_node({x=pos.x-1,y=pos.y,z=pos.z}).name=="default:diamondblock" and
			minetest.get_node({x=pos.x-1,y=pos.y,z=pos.z+1}).name=="default:diamondblock" and
			minetest.get_node({x=pos.x-1,y=pos.y,z=pos.z-1}).name=="default:diamondblock" and
			minetest.get_node({x=pos.x,y=pos.y,z=pos.z+1}).name=="default:diamondblock" and
			minetest.get_node({x=pos.x,y=pos.y,z=pos.z-1}).name=="default:diamondblock"
		then
			stack = ItemStack("teleports:teleport")
		end
		local ret = minetest.item_place(stack, placer, pointed_thing)
		if ret==nil then
			return itemstack
		else
			return ItemStack("default:diamondblock "..itemstack:get_count()-(1-ret:get_count()))
		end
	end,
})

minetest.register_abm({
	nodenames = {"teleports:teleport"},
	interval = 10,
	chance = 1,
	action = function(pos)
		local objectsnear=minetest.get_objects_inside_radius({x=pos.x,y=pos.y+0.5,z=pos.z}, 0.52);
		if #objectsnear>0 then
			local player = objectsnear[1];
			if player:is_player() and player:get_player_name()~=teleports.lastplayername then
				local positions = teleports:find_nearby(pos, 10)
				if #positions>0 then
					local key = math.random(1, #positions)
                    local pos2 = positions[key].pos
                    teleports.lastplayername = player:get_player_name()
                    if math.random(1, 100) > 5 then
                        player:setpos({x=pos2.x,y=pos2.y+0.5,z=pos2.z})
                    else
                        player:setpos({x=pos2.x-5+math.random(1, 10),y=pos2.y+3,z=pos2.z-5+math.random(1, 10)})
                    end
				end
            else
                teleports.lastplayername = ""
			end
		end
	end,
})

