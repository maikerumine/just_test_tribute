--minetest.register_on_joinplayer(function(player)
    --minetest.setting_set("time_speed", 2.635431918)
--end)
--minetest.register_on_shutdown(function(player)
--    minetest.setting_set("time_speed", 72)
--end)

-- Disable clouds and enable them again when player leaves the game. (Experimental)
minetest.register_on_joinplayer(function(player)
    minetest.setting_set("enable_clouds", 0)
end)
minetest.register_on_shutdown(function(player)
    minetest.setting_set("enable_clouds", 1)
end)

local skytextures = {
	"black.png",
	"black.png",
	"black.png",
	"black.png",	
	"black.png",
	"black.png",
}

--[[
local skytextures = {
		"farming_pumpkin_top.png",
		"farming_pumpkin_top.png",
		"farming_pumpkin_side.png",
		"farming_pumpkin_side.png",
		"farming_pumpkin_side.png",
		"farming_pumpkin_face_off.png",
}
]]
--Sky textures
minetest.register_on_joinplayer(function(player)
	minetest.after(0, function()
		--player:set_sky({r=0, g=0, b=0, a=0},"skybox", skytextures)
		--player:set_sky({r=219, g=168, b=117},"skybox", skytextures)
		player:set_sky({r=219, g=8, b=7},"skybox", skytextures)
		--player:set_sky({r=80, g=8, b=37},"skybox", skytextures)
	end)
end)


--[[
		minetest.after(0.1,function()
			player:set_sky({r=219, g=168, b=117},"plain",{})
		end)
		]]