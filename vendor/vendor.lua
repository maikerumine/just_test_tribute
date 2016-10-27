---
--vendor
--Copyright (C) 2012 Bad_Command
--Rewrited by Andrej
--
--This library is free software; you can redistribute it and/or
--modify it under the terms of the GNU Lesser General Public
--License as published by the Free Software Foundation; either
--version 2.1 of the License, or (at your option) any later version.
--
--This program is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--GNU General Public License for more details.
--
--You should have received a copy of the GNU Lesser General Public
--License along with this library; if not, write to the Free Software
--Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
---

vendor.set_formspec = function(pos, player)
	local meta = minetest.get_meta(pos)
	local node = minetest.get_node(pos)

	local description = minetest.registered_nodes[node.name].description;
	local number = meta:get_int("number")
	local cost = meta:get_int("cost")

	meta:set_string("formspec", "size[8,7;]"
		.."label[0,0;" .. description .. "]"

        .."list[current_name;item;0,1;1,1;]"
		.."field[1.3,1.3;1,1;number;Count:;" .. number .. "]"

        .."list[current_name;gold;0,2;1,1;]"
		.."field[1.3,2.3;1,1;cost;Price:;" .. cost .. "]"

		.."button[3,2;2,0.5;save;OK]"
        .."list[current_player;main;0,3;8,4;]")
end

vendor.on_receive_fields_owner = function(pos, formname, fields, sender)
    local node = minetest.get_node(pos)
	local meta = minetest.get_meta(pos)

	local number = tonumber(fields.number)
	local cost = tonumber(fields.cost)
    local inv_self = meta:get_inventory()

    local itemstack = inv_self:get_stack("item",1)
    local itemname=""
	
	if not( number == nil or number < 1 or number > 99) then
        meta:set_int("number", number)
	end
    
	if not( cost == nil or cost < 1 or cost > 99) then
		meta:set_int("cost", cost)
	end
    
    if( itemstack and itemstack:get_name() ) then
        itemname=itemstack:get_name()
    end
	meta:set_string("itemname", itemname)
    
    vendor.set_formspec(pos, sender)
end

vendor.on_receive_fields_customer = function(pos, formname, fields, sender)
    if not fields.save then
        return
    end
    
	local node = minetest.get_node(pos)
	local meta = minetest.get_meta(pos)
    local number = meta:get_int("number")
    local cost = meta:get_int("cost")
    local itemname=meta:get_string("itemname")
    local buysell =  "sell"
	if ( node.name == "vendor:depositor" ) then	
		buysell = "buy"
	end
	
	if ( number == nil or number < 1 or number > 99) then
		return
	end
	if ( cost == nil or cost < 1 or cost > 99) then
		return
	end
	if ( itemname == nil or itemname=="") then
		return
	end
    
    local chest = minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z})
    if chest.name=="default:chest_locked" and sender and sender:is_player() then
        local chest_meta = minetest.get_meta({x=pos.x,y=pos.y-1,z=pos.z})
        local chest_inv = chest_meta:get_inventory()
        local player_inv = sender:get_inventory()
        if ( chest_meta:get_string("owner") == meta:get_string("owner") and chest_inv ~= nil and player_inv ~= nil ) then
            
            local stack = {name=itemname, count=number, wear=0, metadata=""} 
            local price = {name="default:gold_ingot", count=cost, wear=0, metadata=""}
            if buysell == "sell" then
                if chest_inv:contains_item("main", stack) and player_inv:contains_item("main", price) and
                   chest_inv:room_for_item("main", price) and player_inv:room_for_item("main", stack) then
                   player_inv:remove_item("main", price)
                   stack = chest_inv:remove_item("main", stack)
                   chest_inv:add_item("main", price)
                   player_inv:add_item("main", stack)
                   minetest.chat_send_player(sender:get_player_name(), "You bought item.")
                   vendor.sound_vend(pos)
                elseif chest_inv:contains_item("main", stack) and player_inv:contains_item("main", price) then
                    minetest.chat_send_player(sender:get_player_name(), "No room in inventory!")
                else
                    minetest.chat_send_player(sender:get_player_name(), "Not enough materials!")
                end
            else
                if chest_inv:contains_item("main", price) and player_inv:contains_item("main", stack) and
                   chest_inv:room_for_item("main", stack) and player_inv:room_for_item("main", price) then
                   stack = player_inv:remove_item("main", stack)
                   chest_inv:remove_item("main", price)
                   chest_inv:add_item("main", stack)
                   player_inv:add_item("main", price)
                   minetest.chat_send_player(sender:get_player_name(), "You sold item.")
                   vendor.sound_vend(pos)
                elseif chest_inv:contains_item("main", price) and player_inv:contains_item("main", stack) then
                    minetest.chat_send_player(sender:get_player_name(), "No room in inventory!")
                else
                    minetest.chat_send_player(sender:get_player_name(), "Not enough materials!")
                end
            end
        else
            minetest.chat_send_player(sender:get_player_name(), "Wrong chest!")
        end
    else
        if sender and sender:is_player() then
            minetest.chat_send_player(sender:get_player_name(), "Place chest under machine!")
        end
    end

    
    --do transaction here
    
end

vendor.after_place_node = function(pos, placer)
    local node = minetest.get_node(pos)
	local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local description = minetest.registered_nodes[node.name].description;
    local player_name = placer:get_player_name()
    inv:set_size("item", 1)
    inv:set_size("gold", 1)
    
    inv:set_stack( "gold", 1, "default:gold_ingot" )

	meta:set_string("infotext", player_name.." - "..description)
    meta:set_int("number", 1)
    meta:set_int("cost", 1)
	meta:set_string("itemname", "")

	meta:set_string("owner", placer:get_player_name() or "")
    
    vendor.set_formspec(pos, placer)
end

vendor.can_dig = function(pos, player)
    local chest = minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z})
    local meta_chest = minetest.get_meta({x=pos.x,y=pos.y-1,z=pos.z});
    if chest.name=="default:chest_locked" then
         if player and player:is_player() then
            local owner_chest = meta_chest:get_string("owner")
            local name = player:get_player_name()
            if name == owner_chest then
                return true --chest owner can dig shop
            end
         end
         return false
    else
        return true --if no chest, enyone can dig this shop
    end
end

vendor.on_receive_fields = function(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local owner = meta:get_string("owner")
    
	if sender:get_player_name() == owner then
		vendor.on_receive_fields_owner(pos, formname, fields, sender)
    else
        vendor.on_receive_fields_customer(pos, formname, fields, sender)
	end
end

vendor.sound_vend = function(pos) 
	minetest.sound_play("vendor_vend", {pos = pos, gain = 1.0, max_hear_distance = 5,})
end


vendor.allow_metadata_inventory_put = function(pos, listname, index, stack, player)
    if listname=="item" then
        local meta = minetest.get_meta(pos);
        local owner = meta:get_string("owner")
        local name = player:get_player_name()
        if name == owner then
            local inv = meta:get_inventory()
            if stack==nil then
                inv:set_stack( "item", 1, nil )
            else
                inv:set_stack( "item", 1, stack:get_name() )
            end
        end
    end
	return 0
end

vendor.allow_metadata_inventory_take = function(pos, listname, index, stack, player)
	return 0
end

vendor.allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
	return 0
end
