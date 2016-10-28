-- ANTI CHEAT by rnd
-- Copyright 2016 rnd
-- includes modified/bugfixed spectator mod by jp

-------------------------------------------------------------------------
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
-------------------------------------------------------------------------
local cheat = {};
local version = "10/27/2016";

anticheatsettings = {};
dofile(minetest.get_modpath("anticheat").."/settings.lua")

local CHEAT_TIMESTEP = anticheatsettings.CHEAT_TIMESTEP;
local CHECK_AGAIN = anticheatsettings.CHECK_AGAIN;
cheat.moderators = anticheatsettings.moderators;


anticheatdb = {}; -- data about detected cheaters

cheat.suspect = "";
cheat.players = {}; -- temporary cheat detection db
cheat.message = "";
cheat.debuglist = {}; -- [name]=true -- who gets to see debug msgs

cheat.scan_timer = 0; -- global scan of players
cheat.stat_timer = 0; -- used to collect stats

cheat.nodelist = {};
cheat.watcher = {}; -- list of watchers

cheat.timestep = CHEAT_TIMESTEP;
-- list of forbidden nodes
cheat.nodelist = {["default:stone"] = false, ["default:cobble"]= false, ["default:dirt"] = false, ["default:sand"]=false,["default:tree"]= false};


local punish_cheat = function(name)
	
	local player = minetest.get_player_by_name(name); 
	local ip = tostring(minetest.get_player_ip(name));
	
	if not player then return end
	local text=""; local logtext = "";
	
	if cheat.players[name].cheattype == 1 then
		text = "#anticheat: ".. name .. " was caught walking inside wall";
		logtext = os.date("%H:%M.%S").." #anticheat: ".. name .. " was caught walking inside wall at " .. minetest.pos_to_string(cheat.players[name].cheatpos);
		player:set_hp(0);
	elseif cheat.players[name].cheattype == 2 then
		logtext= os.date("%H:%M.%S").." #anticheat: ".. name .. " was caught flying at " .. minetest.pos_to_string(cheat.players[name].cheatpos);
		if cheat.players[name].cheatpos.y>5 then -- only above height 5 it directly damages flyer
			text = "#anticheat: ".. name .. " was caught flying";
			--player:set_hp(0);
		end
	end
	
	if text~="" then
		minetest.chat_send_all(text);
	end	
	
	if logtext~="" then
		minetest.log("action", logtext);
		cheat.message = logtext;
		
		anticheatdb[ip] = {name = name, msg = logtext};

		cheat.players[name].count=0; -- reset counter
		cheat.players[name].cheattype = 0;
	
		for name,_ in pairs(cheat.moderators) do -- display full message to moderators
			minetest.chat_send_player(name,logtext);
		end
	end
end


-- check position more closely

-- uncomment when obfuscating:
--dofile(minetest.get_modpath("anticheat").."/anticheat_source.lua")


local ie = minetest.request_insecure_environment() or _G;

local anticheat_routines = ie.loadfile(minetest.get_modpath("anticheat").."/anticheat_routines.bin")
check_noclip, check_fly, check_player = anticheat_routines(minetest,cheat,CHECK_AGAIN,punish_cheat);
	

minetest.register_globalstep(function(dtime)
	
	cheat.scan_timer = cheat.scan_timer + dtime
	
	
	-- GENERAL SCAN OF ALL PLAYERS
	if cheat.scan_timer>cheat.timestep then	
		
		
		cheat.stat_timer = cheat.stat_timer + cheat.timestep; 
		-- dig xp stats every 2 minutes
		if boneworld and cheat.stat_timer>120 then
			cheat.stat_timer = 0;
			local players = minetest.get_connected_players();
			for _,player in pairs(players) do
				local pname = player:get_player_name();
				if cheat.players[pname].stats.state == 1 then -- only if dig xp loaded to prevent anomalous stats
					if boneworld.digxp[pname] then
						local deltadig = cheat.players[pname].stats.digxp;
						cheat.players[pname].stats.digxp = boneworld.digxp[pname];
						deltadig = boneworld.digxp[pname]-deltadig;
						cheat.players[pname].stats.deltadig = deltadig;
						
						if deltadig>cheat.players[pname].stats.maxdeltadig then
							cheat.players[pname].stats.maxdeltadig = deltadig;
						end
						
						if deltadig>2 then -- unnaturally high deltadig
							local ip = tostring(minetest.get_player_ip(pname));
							local logtext = os.date("%H:%M.%S") .. " #anticheat: " .. pname .. " (ip " .. ip .. ") is mining resources too fast, deltadig " .. deltadig;
							anticheatdb[ip] = {name = pname, msg = logtext};
							minetest.log("action", logtext);
						end
						
					end
				end
			end
		end
		
		
		cheat.timestep = CHEAT_TIMESTEP + (2*math.random()-1)*2; -- randomize step so its unpredictable
		cheat.scan_timer=0;
		--local t = minetest.get_gametime();
		local players = minetest.get_connected_players();
		
		for _,player in pairs(players) do
			check_player(player);
		end
		
		for name,_ in pairs(cheat.debuglist) do -- show suspects in debug
			for _,player in pairs(players) do
				local pname = player:get_player_name();
				if cheat.players[pname].count>0 then
					minetest.chat_send_player(name, "name " .. pname .. ", cheat pos " .. minetest.pos_to_string(cheat.players[pname].cheatpos) .. " last clear pos " .. minetest.pos_to_string(cheat.players[pname].clearpos) .. " cheat type " .. cheat.players[pname].cheattype .. " cheatcount " .. cheat.players[pname].count );
				end
			end
		end
		
		
	end
end)

-- long range dig check

local check_can_dig = function(pos, digger) 
	
	local p = digger:getpos();
	if p.y<0 then p.y=p.y+2 else p.y=p.y+1 end -- head position
	local dist = math.max(math.abs(p.x-pos.x),math.abs(p.y-pos.y),math.abs(p.z-pos.z));

	
	if dist>6 then -- here 5
		dist = math.floor(dist*100)/100;
		local pname = digger:get_player_name();
		local logtext = os.date("%H:%M.%S") .. "#anticheat: long range dig " .. pname ..", distance " .. dist .. ", pos " .. minetest.pos_to_string(pos);
		for name,_ in pairs(cheat.debuglist) do -- show to all watchers
			minetest.chat_send_player(name,logtext)

		end
		local ip = tostring(minetest.get_player_ip(pname));
		anticheatdb[ip] = {name = pname, msg = logtext};
		return false
	end
	
	return true
end

local set_check_can_dig = function(name)
	local tabl = minetest.registered_nodes[name];
	if not tabl then return end
	tabl.can_dig = check_can_dig;
	minetest.override_item(name, {can_dig = check_can_dig})
	--minetest.register_node(":"..name, tabl);
end

minetest.after(0, 
	function() 
		set_check_can_dig("default:stone");
		set_check_can_dig("default:stone_with_iron");
		set_check_can_dig("default:stone_with_copper");
		set_check_can_dig("default:stone_with_coal");
		set_check_can_dig("default:stone_with_gold");
		set_check_can_dig("default:stone_with_mese");
		set_check_can_dig("default:stone_with_diamond");
	end
)




-- DISABLED: lot of false positives
-- collects misc stats on players

-- minetest.register_on_cheat(
	-- function(player, c)
		-- local name = player:get_player_name(); if name == nil then return end
		-- local stats = cheat.players[name].stats; 
		-- if not stats[c.type] then stats[c.type] = 0 end
		-- stats[c.type]=stats[c.type]+1;
	-- end
-- )



local watchers = {}; -- for each player a list of watchers
minetest.register_on_joinplayer(function(player) -- init stuff on player join
	local name = player:get_player_name(); if name == nil then return end 
	local pos = player:getpos();
	
	if cheat.players[name] == nil then
		cheat.players[name]={count=0,cheatpos = pos, clearpos = pos, lastpos = pos, cheattype = 0}; -- type 0: none, 1 noclip, 2 fly
	end
	
	if cheat.players[name] and cheat.players[name].stats == nil then
		cheat.players[name].stats = {maxdeltadig=0,deltadig = 0,digxp = 0, state = 0}; -- various statistics about player: max dig xp increase in 2 minutes, current dig xp increase
	
		minetest.after(5, -- load digxp after boneworld loads it
		function() 
			if boneworld and boneworld.xp then
				cheat.players[name].stats.digxp = boneworld.digxp[name] or 0;
				cheat.players[name].stats.state = 1;
			end
		end
	)
	
	end
	--state 0 = stats not loaded yet
	
	
	watchers[name] = {}; -- for spectator mod
	
	local ip = tostring(minetest.get_player_ip(name));
	local msg = "";
	
	-- check anticheat db
	--check ip
	if anticheatdb[ip] then 
		msg = "#anticheat: welcome back detected cheater, ip = " .. ip .. ", name " .. anticheatdb[ip].name .. ", new name = " .. name;
	end;
	--check names
	for ip,v in pairs(anticheatdb) do
		if v.name == name then 
			msg = "#anticheat: welcome back detected cheater, ip = " .. ip .. ", name = newname =  " .. v.name;
			break;
		end
	end
	
	if msg~="" then
		for name,_ in pairs(cheat.moderators) do 
			minetest.chat_send_player(name,msg);
		end
	end
	
end)

minetest.register_chatcommand("cchk", { -- see cheat report
	privs = {
		interact = true
	},
	func = function(name, param)
		local privs = minetest.get_player_privs(name).privs;
		if not cheat.moderators[name] and not privs then return end

		local player = minetest.get_player_by_name(param);
		if not player then return end
		check_player(player);
		
		
		local players = minetest.get_connected_players();		
		for name,_ in pairs(cheat.debuglist) do -- show suspects in debug
			for _,player in pairs(players) do
				local pname = player:get_player_name();
				if cheat.players[pname].count>0 then
					minetest.chat_send_player(name, "name " .. pname .. ", cheat pos " .. minetest.pos_to_string(cheat.players[pname].cheatpos) .. " last clear pos " .. minetest.pos_to_string(cheat.players[pname].clearpos) .. " cheat type " .. cheat.players[pname].cheattype .. " cheatcount " .. cheat.players[pname].count );
				end
			end
		end
		
		
	end
})


minetest.register_chatcommand("crep", { -- see cheat report
	privs = {
		interact = true
	},
	func = function(name, param)
		local privs = minetest.get_player_privs(name).privs;
		if not cheat.moderators[name] and not privs then return end
		
		if param == "" then 
			minetest.chat_send_player(name,"use: crep type, types: 0(default) cheat report, 1 connected player stats (".. version ..")");
		end
		
		param = tonumber(param) or 0;
		
		if param == 0 then -- show cheat report
			local text = "";
			for ip,v in pairs(anticheatdb) do
				if v and v.name and v.msg then
					text = text .. "ip " .. ip .. " ".. v.msg .. "\n";
				end
			end
			if text ~= "" then
				local form = "size [6,7] textarea[0,0;6.5,8.5;creport;CHEAT REPORT;".. text.."]"
				minetest.show_formspec(name, "anticheatreport", form)
			end
		elseif param == 1 then -- show cheat stats
			local text = "";
			local players = minetest.get_connected_players();
			for _,player in pairs(players) do
				local pname = player:get_player_name();
				local ip = tostring(minetest.get_player_ip(pname));
				
				
				text = text .. "\nname " .. pname .. ", digxp " .. math.floor(1000*cheat.players[pname].stats.digxp)/1000 ..
				", deltadigxp(2min) " .. math.floor(1000*cheat.players[pname].stats.deltadig)/1000 .. ", maxdeltadigxp " .. math.floor(1000*cheat.players[pname].stats.maxdeltadig)/1000; -- .. " ".. string.gsub(dump(cheat.players[pname].stats), "\n", " ");
				if anticheatdb[ip] then text = text .. "    (DETECTED) ip ".. ip .. ", name " .. anticheatdb[ip].name end
			end
			if text ~= "" then
				local form = "size [10,8] textarea[0,0;10.5,9.;creport;CHEAT STATISTICS;".. text.."]"
				minetest.show_formspec(name, "anticheatreport", form)
			end
		end
		-- suspects info
		local players = minetest.get_connected_players();
		for _,player in pairs(players) do
			local pname = player:get_player_name();
			if cheat.players[pname].count>0 then
				minetest.chat_send_player(name, "name " .. pname .. ", cheat pos " .. minetest.pos_to_string(cheat.players[pname].cheatpos) .. " last clear pos " .. minetest.pos_to_string(cheat.players[pname].lastpos) .. " cheat type " .. cheat.players[pname].cheattype .. " cheatcount " .. cheat.players[pname].count );
			end
		end

	end
})

minetest.register_chatcommand("cdebug", { -- toggle cdebug= display of stats on/off for this player
	privs = {
		interact = true
	},
	func = function(name, param)
		local privs = minetest.get_player_privs(name).privs;
		if not cheat.moderators[name] and not privs then return end
		
		if cheat.debuglist[name] == nil then cheat.debuglist[name] = true else cheat.debuglist[name] = nil end;
		
		minetest.chat_send_player(name,"#anticheat: " .. version);
		if cheat.debuglist[name]==true then 
			minetest.chat_send_player(name,"#anticheat: display of debug messages is ON");
		else
			minetest.chat_send_player(name,"#anticheat: display of debug messages is OFF");
		end
	end
})




------------------------------------------------------
-- [Mod] Spectator Mode [git] [spectator_mode]
-- https://github.com/minetest-mods/spectator_mode
-- by jp » Tue Dec 08, 2015 15:34
-- modified/bugfixes by rnd
------------------------------------------------------


local original_pos = {}

local function unwatching(name)
	local watcher = minetest.get_player_by_name(name)
	local privs = minetest.get_player_privs(name)

	if watcher and default.player_attached[name] == true then
		watcher:set_detach()
		
		
		local pos = original_pos[watcher]
		if pos then
			-- setpos seems to be very unreliable
			-- this workaround helps though
			minetest.after(0.1, function()
				watcher:setpos(pos)
			end)
			original_pos[watcher] = nil
		end
		cheat.watcher[name]=nil;
		
		minetest.after(5,
			function()
				default.player_attached[name] = false
				watcher:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
				watcher:set_nametag_attributes({color = {a=255, r=255, g=255, b=255}})

				watcher:hud_set_flags({
					healthbar = true,
					minimap = true,
					breathbar = true,
					hotbar = true,
					wielditem = true,
					crosshair = true
				})

				watcher:set_properties({
					visual_size = {x=1, y=1},
					makes_footstep_sound = true,
					collisionbox = {-0.3, -1, -0.3, 0.3, 1, 0.3}
				})
			end
		)
		-- if not privs.interact and cheat.moderators[name] == true then
			-- privs.interact = true
			-- minetest.set_player_privs(name, privs)
		-- end
		
		
		
	end
end

minetest.register_chatcommand("watch", {
	params = "<to_name>",
	description = "",
	privs = {interact=true},
	func = function(name, param)
		
		local privs = minetest.get_player_privs(name)
		if not cheat.moderators[name] and not privs.kick then return end
		local watcher = minetest.get_player_by_name(name)
		
		
		if param == "" then -- no name given - select a suspect automatically
			local players = minetest.get_connected_players();
			for _,player in pairs(players) do
				local pname = player:get_player_name();
				if cheat.players[pname].count>0 then
					param = pname; 
					cheat.suspect = param;
					break; 
				end
			end
			if param == "" and cheat.suspect~="" then param = cheat.suspect end -- if none found watch last suspect
		end
		
		local target = minetest.get_player_by_name(param);
		
		if not target then return end
		if not cheat.players[param] then return end

		
		local canwatch = false;
		for ip,v in pairs(anticheatdb) do
			if v.name == param then 
				canwatch = true;
				break;
			end
		end
		
		local ip = tostring(minetest.get_player_ip(param));
		if anticheatdb[ip] then canwatch = true end -- can watch since this ip was detected before
	
		
		if canwatch or cheat.players[param].count>0 or param == cheat.suspect or privs.kick then
		else 
			minetest.chat_send_player(name, "ordinary watchers can only watch cheat suspects of detected cheaters");
			return
		end
		
		if target and watcher ~= target then
			if default.player_attached[name] == true then
				unwatching(param)
			else
				original_pos[watcher] = watcher:getpos()
			end
		
			-- show inventory
			local tinv =  target:get_inventory():get_list("main");
			for i,v in pairs(tinv) do tinv[i] = v:to_string(); end
			tinv = dump(tinv);
			local form = "size [6,7] textarea[0,0;6.5,8.5;creport;INVENTORY LIST;".. tinv.."]"
			minetest.show_formspec(name, "watch_inventory", form)
			
			
			default.player_attached[name] = true
			watcher:set_attach(target, "", {x=0, y=-5, z=-20}, {x=0, y=0, z=0})
			watcher:set_eye_offset({x=0, y=-5, z=-20}, {x=0, y=0, z=0})
			watcher:set_nametag_attributes({color = {a=0}})

			watcher:hud_set_flags({
				healthbar = false,
				minimap = false,
				breathbar = false,
				hotbar = false,
				wielditem = false,
				crosshair = false
			})

			watcher:set_properties({
				visual_size = {x=0, y=0},
				makes_footstep_sound = false,
				collisionbox = {0}
			})

			-- privs.interact = nil
			-- minetest.set_player_privs(name, privs)

			cheat.watcher[name]=true;
			watchers[param][name] = true; -- register name as watcher of param
			
			
			return true, "Watching '"..param.."' at "..minetest.pos_to_string(vector.round(target:getpos()))
		end

		return false, "Invalid parameter ('"..param.."')."
	end
})

minetest.register_chatcommand("unwatch", {
	description = "",
	privs = {interact=true},
	func = function(name, param)	
		unwatching(name)
		-- unregister name as watcher
		for pname,val in pairs (watchers) do
			if val[name] then watchers[pname][name] = nil; end
		end
		
	end
})

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	for pname,_ in pairs (watchers[name]) do
		unwatching(pname); -- all watchers do /unwatch
	end
	watchers[name] = nil;
end)