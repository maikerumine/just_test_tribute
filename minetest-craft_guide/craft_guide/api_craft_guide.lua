--[[

Craft Guide for Minetest

Copyright (c) 2012 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-craft_guide
License: BSD-3-Clause https://raw.github.com/cornernote/minetest-craft_guide/master/LICENSE

CRAFT GUIDE API

]]--



-- expose object to other modules
craft_guide = {}

-- fast fix to "unknown items". not even reading code, just find and replace.
craft_guide.set_stack=function(inv, listname, index, stack)
    if type(stack)=="string" then
        if stack=="group:wood" then
            stack="default:wood"
        elseif stack=="group:stone" then
            stack="default:cobble"
        elseif stack=="group:sand" then
            stack="default:sand"
        elseif stack=="group:stick" then
            stack="default:stick"
        elseif stack=="group:wool" then
            stack="default:wool"
        elseif stack=="group:dye,basecolor_black" then
            stack="default:cobble"
        elseif stack=="group:mesecon_conductor_craftable" then
            stack="mesecons:wire_00000000_off"
        elseif stack=="" then
            stack=""
        end
    end
    inv:set_stack(listname, index, stack)
end


-- define api variables
craft_guide.crafts = {}


-- log
craft_guide.log = function(message)
	--if not craft_guide.DEBUG then return end
	minetest.log("action", "[CraftGuide] "..message)
end


-- register_craft
craft_guide.register_craft = function(options)
	if  options.output == nil then
		return
	end
	local itemstack = ItemStack(options.output)
	if itemstack:is_empty() then
		return
	end
	--craft_guide.log("registered craft for - "..itemstack:get_name())
	if craft_guide.crafts[itemstack:get_name()]==nil then
		craft_guide.crafts[itemstack:get_name()] = {}
	end
	table.insert(craft_guide.crafts[itemstack:get_name()],options)
end


-- get_craft_guide_formspec
craft_guide.get_craft_guide_formspec = function(meta, search, page, alternate)
	if search == nil then 
		search = meta:get_string("search")
	end
	if page == nil then 
		page = craft_guide.get_current_page(meta) 
	end
	if alternate == nil then 
		alternate = craft_guide.get_current_alternate(meta) 
	end
	local inv = meta:get_inventory()
	local size = inv:get_size("main")
	local start = (page-1) * (5*14) + 1
	local pages = math.floor((size-1) / (5*14) + 1)
	local alternates = 0
	local stack = inv:get_stack("output",1)
	local crafts = craft_guide.crafts[stack:get_name()]
	if crafts ~= nil then
		alternates = #crafts
	end
	local formspec = "size[14,10;]"
		.."list[current_name;main;0,0;14,5;"..tostring(start).."]"

		.."label[0,5;--== Learn to Craft ==--]"
		.."label[0,5.4;Drag any item to the Output box to see the]"
		.."label[0,5.8;craft. Save your favorite items in Bookmarks.]"

		.."field[6,5.4;2,1;craft_guide_search_box;;"..tostring(search).."]"
		.."button[7.5,5.1;1.2,1;craft_guide_search_button;Search]"

		.."label[9,5.2;page "..tostring(page).." of "..tostring(pages).."]"
		.."button[11,5;1.5,1;craft_guide_prev;<<]"
		.."button[12.5,5;1.5,1;craft_guide_next;>>]"

		.."label[0,6.5;Output]"
		.."list[current_name;output;0,7;1,1;]"

		.."label[2,6.5;Inventory Craft]"
		.."list[current_name;build;2,7;3,3;]"

		.."label[6,6.5;Cook]"
		.."list[current_name;cook;6,7;1,1;]"
		.."label[6,8.5;Fuel]"
		.."list[current_name;fuel;6,9;1,1;]"

		.."label[8,6.5;Bookmarks]"
		.."list[current_name;bookmark;8,7;6,3;]"

		.."label[12,6.1;Bin ->]"
		.."list[current_name;bin;13,6;1,1;]"
	if alternates > 1 then
		formspec = formspec
			.."label[0,8.6;recipe "..tostring(alternate).." of "..tostring(alternates).."]"
			.."button[0,9;2,1;alternate;Alternate]"
	end
	return formspec
end


-- on_construct
craft_guide.on_construct = function(pos)
	local meta = minetest.env:get_meta(pos)
	local inv = meta:get_inventory()
	inv:set_size("output", 1)
	inv:set_size("build", 3*3)
	inv:set_size("cook", 1)
	inv:set_size("fuel", 1)
	inv:set_size("bookmark", 6*3)
	inv:set_size("bin", 1)
	craft_guide.create_inventory(inv)
	meta:set_string("formspec",craft_guide.get_craft_guide_formspec(meta))
end


-- on_receive_fields
craft_guide.on_receive_fields = function(pos, formname, fields, player)
	local meta = minetest.env:get_meta(pos);

	local inv = meta:get_inventory()
	local size = inv:get_size("main",1)
	local stack = inv:get_stack("output",1)
	local crafts = craft_guide.crafts[stack:get_name()]
	local alternate = craft_guide.get_current_alternate(meta)
	local alternates = 0
	if crafts ~= nil then
		alternates = #crafts
	end

	local page = craft_guide.get_current_page(meta)
	local pages = math.floor((size-1) / (5*14) + 1)

	local search
	
	-- search
	search = fields.craft_guide_search_box
	meta:set_string("search", search)
	if fields.craft_guide_search_button then
		page = 1
	end
    if player and player:is_player() then
        minetest.log('action', 'CraftGuide formspec by player '..player:get_player_name())
    else
        minetest.log('action', 'CraftGuide formspec without player')
    end

	-- change page
	if fields.craft_guide_prev then
		page = page - 1
	end
	if fields.craft_guide_next then
		page = page + 1
	end
	if page < 1 then
		page = 1
	end
	if page > pages then
		page = pages
	end

	-- get an alternate recipe
	if fields.alternate then
		alternate = alternate+1
		craft_guide.update_recipe(meta, player, stack, alternate)
	end
	if alternate > alternates then
		alternate = 1
	end

	-- update the formspec
	craft_guide.create_inventory(inv, search)
	meta:set_string("formspec",craft_guide.get_craft_guide_formspec(meta, search, page, alternate))
end


-- get_current_page
craft_guide.get_current_page = function(meta)
	local formspec = meta:get_string("formspec")
	local page = string.match(formspec, "label%[[%d.]+,[%d.]+;page (%d+) of [%d.]+%]")
	page = tonumber(page) or 1
	return page
end


-- get_current_alternate
craft_guide.get_current_alternate = function(meta)
	local formspec = meta:get_string("formspec")
	local alternate = string.match(formspec, "label%[[%d.]+,[%d.]+;recipe (%d+) of [%d.]+%]")
	alternate = tonumber(alternate) or 1
	return alternate
end


-- update_recipe
craft_guide.update_recipe = function(meta, player, stack, alternate)
	local inv = meta:get_inventory()
	for i=0,inv:get_size("build"),1 do
		craft_guide.set_stack(inv, "build", i, nil)
	end
	craft_guide.set_stack(inv, "cook", 1, nil)
	craft_guide.set_stack(inv, "fuel", 1, nil)

	if stack==nil then return end
    if type(stack)=="string" then
        craft_guide.log("Request for item by string name :| - "..stack)
    end
    if stack:get_name()=="" then
        craft_guide.log("Request for item with empty name :|")
        return 
    end
	craft_guide.set_stack(inv, "output", 1, stack:get_name())

	alternate = tonumber(alternate) or 1
	craft_guide.log(player:get_player_name().." requests recipe "..alternate.." for "..stack:get_name())
	local crafts = craft_guide.crafts[stack:get_name()]
	
	if crafts == nil then
		minetest.chat_send_player(player:get_player_name(), "no recipe available for "..stack:get_name())
		meta:set_string("formspec",craft_guide.get_craft_guide_formspec(meta))
		return
	end
	if alternate < 1 or alternate > #crafts then
		alternate = 1
	end
	local craft = crafts[alternate]
	
	-- show me the unknown items
	-- craft_guide.log(dump(craft))
	--minetest.chat_send_player(player:get_player_name(), "recipe for "..stack:get_name()..": "..dump(craft))
	
	local itemstack = ItemStack(craft.output)
	craft_guide.set_stack(inv, "output", 1, itemstack)

	-- cook
	if craft.type == "cooking" then
		craft_guide.set_stack(inv, "cook", 1, craft.recipe)
		meta:set_string("formspec",craft_guide.get_craft_guide_formspec(meta))
		return
	end
	-- fuel
	if craft.type == "fuel" then
		craft_guide.set_stack(inv, "fuel", 1, craft.recipe)
		meta:set_string("formspec",craft_guide.get_craft_guide_formspec(meta))
		return
	end
	-- build (shaped or shapeless)
	if craft.recipe[1] then
		if (type(craft.recipe[1]) == "string") then
			craft_guide.set_stack(inv, "build", 1, craft.recipe[1])
		else
			if craft.recipe[1][1] then
				craft_guide.set_stack(inv, "build", 1, craft.recipe[1][1])
			end
			if craft.recipe[1][2] then
				craft_guide.set_stack(inv, "build", 2, craft.recipe[1][2])
			end
			if craft.recipe[1][3] then
				craft_guide.set_stack(inv, "build", 3, craft.recipe[1][3])
			end
		end
	end
	if craft.recipe[2] then
		if (type(craft.recipe[2]) == "string") then
			craft_guide.set_stack(inv, "build", 2, craft.recipe[2])
		else
			if craft.recipe[2][1] then
				craft_guide.set_stack(inv, "build", 4, craft.recipe[2][1])
			end
			if craft.recipe[2][2] then
				craft_guide.set_stack(inv, "build", 5, craft.recipe[2][2])
			end
			if craft.recipe[2][3] then
				craft_guide.set_stack(inv, "build", 6, craft.recipe[2][3])
			end
		end
	end
	if craft.recipe[3] then
		if (type(craft.recipe[3]) == "string") then
			craft_guide.set_stack(inv, "build", 3, craft.recipe[3])
		else
			if craft.recipe[3][1] then
				craft_guide.set_stack(inv, "build", 7, craft.recipe[3][1])
			end
			if craft.recipe[3][2] then
				craft_guide.set_stack(inv, "build", 8, craft.recipe[3][2])
			end
			if craft.recipe[3][3] then
				craft_guide.set_stack(inv, "build", 9, craft.recipe[3][3])
			end
		end
	end
	if craft.recipe[4] then
		if (type(craft.recipe[4]) == "string") then
			craft_guide.set_stack(inv, "build", 4, craft.recipe[4])
		end
	end
	if craft.recipe[5] then
		if (type(craft.recipe[5]) == "string") then
			craft_guide.set_stack(inv, "build", 5, craft.recipe[5])
		end
	end
	if craft.recipe[6] then
		if (type(craft.recipe[6]) == "string") then
			craft_guide.set_stack(inv, "build", 6, craft.recipe[6])
		end
	end
	if craft.recipe[7] then
		if (type(craft.recipe[7]) == "string") then
			craft_guide.set_stack(inv, "build", 7, craft.recipe[7])
		end
	end
	if craft.recipe[8] then
		if (type(craft.recipe[8]) == "string") then
			craft_guide.set_stack(inv, "build", 8, craft.recipe[8])
		end
	end
	if craft.recipe[9] then
		if (type(craft.recipe[9]) == "string") then
			craft_guide.set_stack(inv, "build", 9, craft.recipe[9])
		end
	end
	meta:set_string("formspec",craft_guide.get_craft_guide_formspec(meta))
end


-- create_inventory
craft_guide.create_inventory = function(inv, search)
	local craft_guide_list = {}
	for name,def in pairs(minetest.registered_items) do
		-- local craft_recipe = minetest.get_craft_recipe(name);
		-- if craft_recipe.items ~= nil then
		local craft = craft_guide.crafts[name];
		if craft ~= nil then
			if (not def.groups.not_in_craft_guide or def.groups.not_in_craft_guide == 0)
					--and (not def.groups.not_in_creative_inventory or def.groups.not_in_creative_inventory == 0)
					and def.description and def.description ~= "" then
				if search then
					if string.find(def.name, search, 1, true) or string.find(def.description, search, 1, true) then
						table.insert(craft_guide_list, name)
					end
				else
					table.insert(craft_guide_list, name)
				end
			end
		end
	end

	table.sort(craft_guide_list)
	for i=0,inv:get_size("main"),1 do
		craft_guide.set_stack(inv, "main", i, nil)
	end
	inv:set_size("main", #craft_guide_list)
	for _,itemstring in ipairs(craft_guide_list) do
		inv:add_item("main", ItemStack(itemstring))
	end
end


-- allow_metadata_inventory_move
craft_guide.allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)

	local meta = minetest.env:get_meta(pos)
	local inv = meta:get_inventory()
	if from_list == "output" and to_list == "bin" then
        craft_guide.update_recipe(meta, player, inv:get_stack(from_list, from_index))
		craft_guide.set_stack(inv, from_list,from_index,nil)
	elseif from_list == "output" or to_list == "output" then
		craft_guide.update_recipe(meta, player, inv:get_stack(from_list, from_index))
	elseif from_list == "bookmarks" and to_list == "bookmarks" then
		return count
	elseif from_list == "bookmark" and to_list == "bin" then
		craft_guide.set_stack(inv, from_list,from_index,nil)
	elseif to_list == "bookmark" then
        if inv:get_size("from_list") > from_index then
            craft_guide.set_stack(inv, to_list, to_index, inv:get_stack(from_list, from_index):get_name())
        end
	end
	return 0
end


-- allow_metadata_inventory_put
craft_guide.allow_metadata_inventory_put = function(pos, listname, index, stack, player)
	return 0
end


-- allow_metadata_inventory_take
craft_guide.allow_metadata_inventory_take = function(pos, listname, index, stack, player)
	return 0
end

