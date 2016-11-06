--mt_seasons v0.2
--maikerumine
--made forMinetest Game
--License for code lgpl-2.1
-- See README.txt for licensing and other information.

mt_seasons = {}

--init nodes
dofile(minetest.get_modpath("mt_seasons").."/nodes.lua")
dofile(minetest.get_modpath("mt_seasons").."/config.lua")

--season selector (EDIT THE CONF FILE)
if mt_seasons.SETTING == 1 then
dofile(minetest.get_modpath("mt_seasons").."/spring.lua")
end

if mt_seasons.SETTING == 2 then
dofile(minetest.get_modpath("mt_seasons").."/summer.lua")
end

if mt_seasons.SETTING == 3 then
dofile(minetest.get_modpath("mt_seasons").."/autumn.lua")
end

if mt_seasons.SETTING == 4 then
dofile(minetest.get_modpath("mt_seasons").."/winter.lua")
end

if mt_seasons.SETTING == 5 then
dofile(minetest.get_modpath("mt_seasons").."/fire_world.lua")
dofile(minetest.get_modpath("mt_seasons").."/sky.lua")
end

if mt_seasons.SETTING == 6 then
dofile(minetest.get_modpath("mt_seasons").."/mapgen.lua")
end

if mt_seasons.SETTING == 7 then
dofile(minetest.get_modpath("mt_seasons").."/christmas.lua")
end

if mt_seasons.SETTING == 8 then
dofile(minetest.get_modpath("mt_seasons").."/cobbleworld.lua")
end

if mt_seasons.SETTING == 9 then
dofile(minetest.get_modpath("mt_seasons").."/mapgen_snow_stone_ice.lua")
end

-- GARBAGE CODE
--[[
--local season =  tonumber(minetest.setting_getbool("season_set")) --or 2

--dofile(minetest.get_modpath("mt_seasons").."/autumn.lua")
--dofile(minetest.get_modpath("mt_seasons").."/winter.lua")
--dofile(minetest.get_modpath("mt_seasons").."/fire_world.lua")

--dofile(minetest.get_modpath("mt_seasons").."/sky.lua")
--dofile(minetest.get_modpath("mt_seasons").."/mapgen.lua")  --makes all stone world


if minetest.setting_getbool("season_set")  == 1 then
dofile(minetest.get_modpath("mt_seasons").."/spring.lua") else
--return
end

if minetest.setting_getbool("season_set") == 2 then
dofile(minetest.get_modpath("mt_seasons").."/summer.lua") else
--return
end

if minetest.setting_getbool("season_set") == 3 then
dofile(minetest.get_modpath("mt_seasons").."/autumn.lua") else
--return
end

if minetest.setting_getbool("season_set") == 4 then
dofile(minetest.get_modpath("mt_seasons").."/winter.lua") --else
return
end
]]
