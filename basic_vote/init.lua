-- basic vote by rnd, 2015

local basic_vote = {};

-- SETTINGS ----------------------------------------------------------------------

-- DEFINE VOTE TYPES

basic_vote.types = { -- [type] = { description , votes_needed , timeout, command, help_description}
[1] = {"ban %s for 2 minutes" , -3 , 30, "ban", "Ban player for 2 minutes"},                -- -3 means strictly more than 3 players need to vote ( so 4 or more)
[2] = {"remove interact of %s" , 0.5, 120, "remove_interact", "Remove 'interact' privilege from player"}, -- 0.5 means at least 50% need to vote
[3] = {"give interact to %s" , 0.5 , 120, "give_interact", "Give 'interact' privilege to player"},
[4] = {"kill %s" , -3 , 30, "kill", "Kill player"},
[5] = {"poison %s" , -3 , 30, "poison", "Poison player"},
[6] = {"teleport %s to vote starter" , -3 , 30, "teleport", "Teleport player to you"},
[7] = {"change name color of %s",-2,30,"name color","Change name of player"},
[8] = {"mutelate %s",-2,30,"mutelate", "Mute and kill player when talking"},
[9] = {"unmutelate",-2,30,"unmutelate","Undo effects of mutelate"},
[10] = {"ask",1.0,30,"ask","put a question up for voting"}
};
basic_vote.modreq = 2; -- more that this number of moderators from "anticheat" mod must vote for mod to succeed

-- needed for poison vote
local vote_poison_state = {};
basic_vote_poison = function(name)
	
	local player = minetest.get_player_by_name(name);
	
	if not vote_poison_state[name] then
		vote_poison_state[name] = 60;
	end
	
	vote_poison_state[name] = vote_poison_state[name] - 1;
	if vote_poison_state[name]<=0 then 
		vote_poison_state[name] = nil; return;
	end
	
	if player then
		if player:get_hp()>0 then 
			player:set_hp(player:get_hp()-4);
		end
	end
	
	minetest.after(2, function() basic_vote_poison(name) end)

end

basic_vote.kicklist = {};
basic_vote.talklist = {};
basic_vote.huds = {};

-- for hud votes

local hud_definition =
{
	hud_elem_type = "image",
	scale = {x=-50,y=-50},
	text = "default_stone.png",
	size = { x=50, y=50 },
	offset = { x=0, y=0},
}


-- DEFINE WHAT HAPPENS WHEN VOTE SUCCEEDS
basic_vote.execute = function(type, name, reason) 

	if type == 1 then
		local ip = tostring(minetest.get_player_ip(name));
		basic_vote.kicklist[ip] = minetest.get_gametime(); -- remembers start time
		minetest.kick_player(name, reason)
			
	elseif type == 2 then
	
		local privs = core.get_player_privs(name);privs.interact = false
		core.set_player_privs(name, privs);	minetest.auth_reload()
		
	elseif type == 3 then
	
		local privs = core.get_player_privs(name);privs.interact = true;
		core.set_player_privs(name, privs);	minetest.auth_reload()
	
	elseif type == 4 then
	
		local player = minetest.get_player_by_name(name); if not player then return end
		player:set_hp(0);
		
	elseif type == 5 then
		
		local player = minetest.get_player_by_name(name); if not player then return end
		if not vote_poison_state[name] then
			basic_vote_poison(name);
		end

	elseif type == 6 then
		
		local player = minetest.get_player_by_name(name); if not player then return end
		local vname = basic_vote.vote.voter; local vplayer = minetest.get_player_by_name(vname);
		if not vplayer then return end
		player:setpos(vplayer:getpos());
		
	elseif type == 7 then
		
		local player = minetest.get_player_by_name(name); if not player then return end
		player:set_nametag_attributes({color = basic_vote.vote.reason});
		
	elseif type == 8 then
		local player = minetest.get_player_by_name(name); if not player then return end
		basic_vote.talklist[name]=1;
		
	elseif type == 9 then
		local player = minetest.get_player_by_name(name); if not player then return end
		basic_vote.talklist[name]=nil;
	
	elseif type == 10 then
		--basic_vote.huds[name]=player:hud_add(hud_definition);
		
	end

end

-- for ban vote
minetest.register_on_prejoinplayer(
	function(name, ip)
		local name;
		if basic_vote.kicklist[ip] then 
			
			local t = minetest.get_gametime();
			t=t-basic_vote.kicklist[ip];
			if t>120 then 
				basic_vote.kicklist[ip] = nil;
			else
				return "You have been temporarily banned from the server."
			end
		end
		
	end
)

-- for talking votes

minetest.register_on_chat_message(
	function(name, message)
		
		
		if basic_vote.talklist[name] then
			if basic_vote.talklist[name] == 1 then -- kill
				local player = minetest.get_player_by_name(name);
				if not player then return end
				if not player:get_inventory():is_empty("main") then
					local p = player:getpos();
					p.x=math.floor(p.x);p.y=math.floor(p.y);p.z=math.floor(p.z);	
					minetest.chat_send_all("<" .. name .. "> please come get my bones at " .. minetest.pos_to_string(p))
				end
				player:set_hp(0);			
				return true
			end
		end

	end
)





-- END OF SETTINGS ---------------------------------------------------------------

basic_vote.votes = 0; -- vote count
basic_vote.modscore = 0; -- how many moderators voted - need 3 for vote to succeed
basic_vote.voters = {}; -- who voted already
basic_vote.state = 0; -- 0 no vote, 1 vote in progress,2 timeout
basic_vote.vote = {time = 0,type = 0, name = "", reason = "", votes_needed = 0, timeout = 0, }; -- description of current vote


basic_vote.requirements = {[0]=0}
basic_vote.vote_desc=""
for i=1,#basic_vote.types do
	basic_vote.vote_desc = basic_vote.vote_desc .. "Type " .. i .. " (" ..basic_vote.types[i][4].. "): ".. basic_vote.types[i][5].."\n"
end

local function get_description(vote)
	local type_str = string.format(basic_vote.types[basic_vote.vote.type][1], basic_vote.vote.name)
	local timeout = math.max(0, vote.timeout - os.difftime(os.time(), vote.time_start))
	if vote.reason == nil or vote.reason == "" then
		return string.format("## VOTE by %s to %s. Timeout in %ds.", vote.voter, type_str, timeout)
	else
		return string.format("## VOTE by %s to %s with reason: '%s'. Timeout in %ds.", vote.voter, type_str, vote.reason, timeout)
	end
end

-- starts a new vote
minetest.register_chatcommand("vote", { 
	privs = {
		interact = true
	},
	params = "[[<type> <name> [<reason>]] | types]",
	description = "Start a vote. '/vote types' for a list of types, '/vote' without arguments to see current voting progress",
	func = function(name, param)
		
		if basic_vote.state~=0 then 
			minetest.chat_send_player(name,"Vote already in progress:") 
			minetest.chat_send_player(name,get_description(basic_vote.vote));
			return 
		elseif param == "" then
			minetest.chat_send_player(name,"No vote in progress.")
			return
		end
		local player = minetest.get_player_by_name(name);
		
		-- split string param into parameters
		local paramt = string.split(param, " ") 
		for i = #paramt+1,3 do paramt[i]="" end
		
		
		if paramt[1] == "types" then minetest.chat_send_player(name, basic_vote.vote_desc) return end
		
		basic_vote.vote.time = minetest.get_gametime();
		basic_vote.vote.type = tonumber(paramt[1]);
		-- check for text-based types
		-- if basic_vote.vote.type == nil then
			-- for i=1,#basic_vote.types do
				-- if paramt[1] == basic_vote.types[i][4] then
					-- basic_vote.vote.type = i
				-- end
			-- end
		-- end
		
		if not basic_vote.types[basic_vote.vote.type] then 
			minetest.chat_send_player(name,"Error: Invalid syntax or type. Use '/help vote' for help.")
			return
		end
		
		-- if not basic_vote.vote.type then minetest.chat_send_player(name,"Error: Invalid syntax or type. Use '/help vote' for help.") return end

		basic_vote.vote.name=paramt[2] or "an unknown player";
		basic_vote.vote.voter = name;
		basic_vote.vote.reason = string.match(param, "%w+ [%w_-]+ (.+)")
		basic_vote.vote.votes_needed =  basic_vote.types[ basic_vote.vote.type ][2]; 
		basic_vote.vote.timeout = basic_vote.types[ basic_vote.vote.type ][3];
		basic_vote.vote.time_start = os.time();
		
		
		--check if target valid player
		if basic_vote.vote.name == "" then
			minetest.chat_send_player(name,"Error: No player specified.")
			return
		elseif not minetest.get_player_by_name(basic_vote.vote.name) and basic_vote.vote.type~= 1 then
			minetest.chat_send_player(name,"Error: The specified player is currently not connected.")
			return
		end
		
		-- check anticheat db
		local ip = tostring(minetest.get_player_ip(basic_vote.vote.name));
		if anticheatdb and anticheatdb[ip] then -- #anticheat mod: makes detected cheater more succeptible to voting
			if anticheatsettings.moderators[name] then -- moderator must call vote
				basic_vote.vote.votes_needed=0; -- just need 1 vote
				name = "an anonymous player"; -- so cheater does not see who voted - anonymous vote
			end
		end
		
		basic_vote.votes = 0; basic_vote.modscore = 0; basic_vote.voters = {};
		
		local type_str = string.format(basic_vote.types[basic_vote.vote.type][1], basic_vote.vote.name)

		if basic_vote.vote.reason == nil or basic_vote.vote.reason == "" then
			minetest.chat_send_all(string.format("## VOTE started (by %s to %s).\nSay '/y' to vote 'yes'. Timeout in %ds.", name, type_str, basic_vote.vote.timeout))
		else
			minetest.chat_send_all(string.format("## VOTE started (by %s to %s) with reason: '%s'.\nSay '/y' to vote 'yes'. Timeout in %ds.", name, type_str, basic_vote.vote.reason, basic_vote.vote.timeout))
		end

		basic_vote.state = 1; minetest.after(basic_vote.vote.timeout, function() 
			if basic_vote.state == 1 then basic_vote.state = 2;basic_vote.update(); end
		end)
	end
	}
)

-- check if enough votes for vote to succeed or fail vote if timeout
basic_vote.update = function()
	local players=minetest.get_connected_players();
	local count = #players;

	local votes_needed;
	
	if basic_vote.vote.votes_needed>0 then
		votes_needed = basic_vote.vote.votes_needed*count; -- percent of all players
		if basic_vote.vote.votes_needed>=0.5 then -- more serious vote, to prevent ppl voting serious stuff with few players on server, at least 6 votes needed
			if votes_needed<6 then votes_needed = 6 end
		end
		
	else
		votes_needed = -basic_vote.vote.votes_needed; -- number instead
	end
	
	if basic_vote.state == 2 then -- timeout
		minetest.chat_send_all("## VOTE failed. ".. basic_vote.votes .." voted (needed more than ".. votes_needed ..").");
		basic_vote.state = 0;basic_vote.vote = {time = 0,type = 0, name = "", reason = ""}; return 
	end
	if basic_vote.state~=1 then return end -- no vote in progress
	
	-- check if enough votes
	
	if basic_vote.modscore> basic_vote.modreq then -- enough moderators voted for vote to succeed
		basic_vote.votes = votes_needed+1;
	end
	
	if basic_vote.votes>votes_needed then  -- enough voters
		minetest.chat_send_all("## VOTE succeded. "..basic_vote.votes .." voted.");
		local type = basic_vote.vote.type;
                basic_vote.execute(basic_vote.vote.type,basic_vote.vote.name, basic_vote.vote.reason)
		basic_vote.state = 0;basic_vote.vote = {time = 0,type = 0, name = "", reason = ""};
		
	end
end

local cast_vote = function (name,param)
	if basic_vote.state~=1 then
		-- vote not in progress
		minetest.chat_send_player(name,"Error: No vote in progress.");
		return
	end
		local ip = tostring(minetest.get_player_ip(name));
		if basic_vote.voters[ip] then
			minetest.chat_send_player(name,"Error: You already voted.");
			return
		else
			-- mark as already voted
			basic_vote.voters[ip]=true
		end
		basic_vote.votes = basic_vote.votes+1;
		if anticheatsettings and anticheatsettings.moderators[name] then -- moderator from anticheat mod
			basic_vote.modscore=basic_vote.modscore+1;
		end
		local privs = core.get_player_privs(name);if privs.kick then basic_vote.votes = 100; end
		basic_vote.update(); minetest.chat_send_player(name,"Vote received.");
end

minetest.register_chatcommand("y", { 
	privs = {
		interact = true
	},
	params = "",
	description = "Vote 'Yes.' in the current vote (see vote command)",
	func = function(name, param)
		cast_vote(name,param)
	end
	}
)
