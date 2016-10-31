-- boneworld by rnd, 2016

-- for more interesting bone gameplay:

-- you no longer get extra bones if you pick bones from player with same ip address (no suicide bone farming)
-- each player has experience points (xp)
-- when you die you loose 20% of your xp, half of that is stored in bones
-- (when you kill other player you get 10% of his xp)
-- if you pick up bones you get xp stored in bones
-- if you pick up other player bones you get 20% of average of your and bone owner xp award in extra bones (for example if you have 10 xp and you pick noob bone will get 2 bones instead of normally 1)

local version = "10/22/16"

local worldpath = minetest.get_worldpath();
--os.execute( "mkdir "..worldpath.. "\\boneworld") 
minetest.mkdir(worldpath .. "\\boneworld") -- directory used to save xp data

boneworld = {};
boneworld.xp = {}; -- [name] = bonexp, bone collect xp
boneworld.digxp = {}; --  [name] = xp, mining xp

boneworld.protect = {}; -- [name] = {timer, position}: time of last dig in unprotected area, position

-- those players get special dig xp when they join
boneworld.vipdig = {["abba"]=1000000} 


--boneworld.killxp = {}; -- xp obtained through kills

boneworld.wastedxp = 0; -- xp thats stored in bones and not yet reclaimed


local share_bones_time = tonumber(minetest.setting_get("share_bones_time")) or 1200
--local share_bones_time = tonumber(minetest.setting_get("share_bones_time")) or 20;
local share_bones_time_early = tonumber(minetest.setting_get("share_bones_time_early")) or share_bones_time / 4


local function is_owner(pos, name)
	local owner = minetest.get_meta(pos):get_string("owner")
	if owner == "" or owner == name or minetest.check_player_privs(name, "protection_bypass") then
		return true
	end
	return false
end


local on_timer = function(pos, elapsed)
	local meta = minetest.get_meta(pos)
	local time = meta:get_int("time")+elapsed; 
	if time >= share_bones_time then
		
		meta:set_string("infotext", meta:get_string("owner").."'s old bones (died ".. meta:get_string("date") .."), bone xp " ..math.floor(meta:get_float("xp")*100)/100);
		meta:set_string("owner", "")
		
	else
		
		if meta:get_int("active") == 0 then -- store data in bones, 1x
			meta:set_int("active",1);
			local owner = meta:get_string("owner");
			meta:set_string("date",os.date("%x"));
			meta:set_string("owner_orig",owner);
			meta:set_string("ip", tostring(minetest.get_player_ip(owner)));
			if not minetest.get_player_by_name(owner) then -- mob bones
				boneworld.xp[owner] = 0.1 -- 0.1th of noob player xp in mobs bone
				time=0.9*share_bones_time; -- 10x shorter old bone time
			else
				boneworld.xp[owner] = boneworld.xp[owner] or 1;
				time = 0;
			end
			
			if boneworld.xp[owner]<1 then
				meta:set_float("xp", 0.01) -- mobs or bones with 0 xp
			else			
				meta:set_float("xp", 0.1); -- player bones give 0.1 xp, same as 10 mob bones
			end
			
			boneworld.wastedxp  = boneworld.wastedxp + meta:get_float("xp"); 
			meta:set_string("infotext"," Here lies " .. owner  .. ", bone xp " .. math.floor(meta:get_float("xp")*100)/100);
		end
	
	
		meta:set_int("time", time)
		return true
	end
end

local on_punch = function(pos, node, player)
	if(not is_owner(pos, player:get_player_name())) then
		return
	end
	
	if(minetest.get_meta(pos):get_string("infotext") == "") then
		return
	end
	
	local inv = minetest.get_meta(pos):get_inventory()
	local player_inv = player:get_inventory()
	local has_space = true
	
	for i=1,inv:get_size("main") do
		local stk = inv:get_stack("main", i)
		if player_inv:room_for_item("main", stk) then
			inv:set_stack("main", i, nil)
			player_inv:add_item("main", stk)
		else
			has_space = false
			break
		end
	end
	
	-- remove bones if player emptied them
	if has_space then
		local meta = minetest.get_meta(pos);
		local active  = meta:get_int("active") == 1;
		local puncher = player:get_player_name();
		
		-- award extra bones/xp if you collect bones from different ip player
		--debug
		if active and meta:get_string("ip")~= tostring(minetest.get_player_ip(puncher)) then
			local xp = meta:get_float("xp");if xp==0 then xp = 0.01 end
			-- average of owners xp (at time of death) and puncher xp will be awarded as extra bones
			-- with every 10 more xp one bone
			
			local count;
			if boneworld.xp[puncher]>100 then -- dont give more bones when bone xp exceeds 100
				count = 1 + 0.1*100;
			else
				count = 1+0.1*boneworld.xp[puncher];
			end
			
			count = math.floor(count);
			minetest.chat_send_player(puncher, "you find " .. count .. " bones in the corpse.");
			
			if player_inv:room_for_item("main", ItemStack("bones:bones "..count)) then
				player_inv:add_item("main", ItemStack("bones:bones "..count))
			else
				minetest.add_item(pos,ItemStack("bones:bones "..count))
			end
		
			-- add xp from bones to player who retrieved bones;
			
			boneworld.xp[puncher] = boneworld.xp[puncher] + meta:get_float("xp");
			boneworld.wastedxp = boneworld.wastedxp - meta:get_float("xp");
		end
		
		
		minetest.remove_node(pos)
	end
end


-- load xp
minetest.register_on_joinplayer(
	function(player)
		local name = player:get_player_name();
		if not boneworld.xp[name] then -- load xp
			local filename = worldpath .. "\\boneworld\\" .. name..".xp";
			local f = io.open(filename, "r");
			if not f then -- file does not yet exist
				boneworld.xp[name] = 1; 
				boneworld.digxp[name] = 0; 
			else
				local str = f:read("*a") or 1;
				local words = {};
				for w in str:gmatch("%S+") do 
					words[#words+1]=w 
				end
				boneworld.xp[name] = tonumber(words[1] or 1);
				boneworld.digxp[name] = tonumber(words[2] or 0);
				f:close();
			end
		end
	
		if boneworld.vipdig[name] then
			if boneworld.digxp[name]<boneworld.vipdig[name] then
				boneworld.digxp[name] = boneworld.vipdig[name];
			end
		end
		
	end
)

-- save xp
minetest.register_on_leaveplayer(
		function(player)
		local name = player:get_player_name();
		local bonexp = boneworld.xp[name] or 1;
		local digxp = boneworld.digxp[name] or 0;
		--debug
		if bonexp > 2 or digxp>1 then -- save xp for serious players only
			local filename = worldpath .. "\\boneworld\\" .. name..".xp";
			
			local f = io.open(filename, "w");
			if not f then return end
			f:write(bonexp .. " " .. digxp);
			f:close();
		else
			-- dont save, player didnt do anything
		end
	end

)

minetest.register_on_dieplayer( -- -1 bone xp each time you die; otherwise no motivation to be careful
	function(player)
		local name = player:get_player_name();
		local xp = boneworld.xp[name] or 1;
		if xp>2 then 
			xp=xp-1 
		else
			xp = 1;
		end
		boneworld.xp[name]=xp;
	end
)


local tweak_bones = function()
	local name = "bones:bones";
	local table = minetest.registered_nodes[name];
	--table.on_construct = on_construct;
	table.on_punch = on_punch;
	table.on_timer = on_timer;
	minetest.register_node(":"..name, table);
end

minetest.after(0,tweak_bones);

minetest.register_chatcommand("xp", {
	description = "xp name - show bone collecting experience of target player " .. version,
	privs = {
		interact = true
	},
	func = function(name, param)
		
		local msg;
		if param == "" then 
			local xp = math.floor((boneworld.xp[name])*100)/100;
			local digxp = math.floor((boneworld.digxp[name])*100)/100;
			--local killxp = math.floor((boneworld.killxp[name])*100)/100;
			msg  = "xp name - show experience of target player"
			.."\n# "..name .. " has " .. xp .. " bone collecting experience, ".. digxp .. " digging experience"
			.. " (can dig to ".. math.floor(200+50*math.sqrt(digxp)) .. ")"
			.. "\nTotal xp stored in bones in world is " .. math.floor(boneworld.wastedxp*100)/100;
		else
			local xp = math.floor((boneworld.xp[param] or 1)*100)/100;
			local digxp = math.floor((boneworld.digxp[param] or 0)*100)/100;
			--local killxp = math.floor((boneworld.killxp[name])*100)/100;
			msg  = "xp name - show experience of target player (10.04.16)"
			.."\n# "..param .. " has " .. xp .. " bone collecting experience, ".. digxp .. " digging experience";

		end 
		minetest.chat_send_player(name, msg);
	end
})


-- limit digging to above -(200+xp*5)
local old_is_protected = minetest.is_protected
function minetest.is_protected(pos, name)
	
	local is_protected_new = old_is_protected(pos, name);
	if pos.y>-200 or name == "" then 
		
	else
		--to do : digxp here!!
		local digxp = boneworld.digxp[name] or 0;
		
		local maxdepth = 200+50*math.sqrt(digxp);
		if pos.y<-maxdepth then
			minetest.chat_send_player(name, "You can only dig above -"..math.floor(maxdepth) .. ". Get more dig experience to dig deeper");
			local player = minetest.get_player_by_name(name); if not player then return true end
			if pos.y<-maxdepth-5 then player:setpos({x=0,y=1,z=0}) end
			is_protected_new = true
		end
	end
	
	if not is_protected_new then -- remember time, pos of last dig in unprotected area
		local t1 = minetest.get_gametime();
		local t0;
		local protect_data  = boneworld.protect[name];
		if not protect_data then
			boneworld.protect[name] = {t=t1, pos=pos}; 
			t0 = t1;
		else
			t0 = boneworld.protect[name].t;
		end
		
		if t1-t0>10 then -- "time" to remember new time, pos
			boneworld.protect[name].t = t1;
			boneworld.protect[name].pos = pos;
		end
	else -- tried to dig in protected area, teleport to last good position
		
		local player = minetest.get_player_by_name(name); if not player then return true end
		local protect_data  = boneworld.protect[name];
		local tpos;
		if not protect_data then -- safety check
			boneworld.protect[name] = {t=minetest.get_gametime(), pos=pos}; 
			tpos =  pos
		else
			tpos  = boneworld.protect[name].pos;
		end
		

		player:setpos({x=tpos.x,y=tpos.y+1,z=tpos.z});
	end
	
	return is_protected_new;
end

-- mining xp

-- how much mining xp digging minerals yields
boneworld.mineralxp = {
["default:stone"] = 0.01,
["default:stone_with_coal"] = 0.03,
["default:stone_with_iron"] = 0.1,
["default:stone_with_copper"] = 0.1,
["default:stone_with_gold"] = 0.2,
["default:stone_with_mese"] = 0.5,
["default:stone_with_diamond"] = 1,
}


local after_dig_node = function(pos, oldnode, oldmetadata, digger)
	local nodename = oldnode.name;
	local name = digger:get_player_name();
	local digxp = boneworld.mineralxp[nodename] or 0; digxp = digxp*0.1; -- bonus xp
	local xp  = boneworld.digxp[name] or 0;
	xp = xp + digxp;
	boneworld.digxp[name] = xp;
	
	-- extra reward with small probability
	if xp<100 or nodename == "default:stone" or digxp == 0 then return end
	
	local P; 
	if xp>10000 then 
		P=0.5
	else
		P = (xp/10000+0.0001)*0.5;
	end
	
	if math.random(1/P) == 1 then
		P=1;
	end
	
	if P==1 then
		
		local player_inv = digger:get_inventory()
		local stk = ItemStack(nodename);
		if player_inv:room_for_item("main", stk) then
			--minetest.chat_send_player(name, "Congratulations! You found extra " .. nodename)
			player_inv:add_item("main", stk)
		end
	end
	
	--minetest.chat_send_all(name .. " digged " .. nodename .. " for " .. digxp .. " mining xp ")
end

local set_after_dig_node = function(name)
	local tabl = minetest.registered_nodes[name];
	if not tabl then return end
	minetest.override_item(name, {after_dig_node = after_dig_node})
end

minetest.after(0, 
	function() 
		set_after_dig_node("default:stone");
		set_after_dig_node("default:stone_with_iron");
		set_after_dig_node("default:stone_with_copper");
		set_after_dig_node("default:stone_with_coal");
		set_after_dig_node("default:stone_with_gold");
		set_after_dig_node("default:stone_with_mese");
		set_after_dig_node("default:stone_with_diamond");
	end
)