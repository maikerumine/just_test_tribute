-- Minetest 0.4 mod: mt_seasons
-- 
-- See README.txt for licensing and other information.

local season =  tonumber(minetest.setting_getbool("season_set")) --or 2

dofile(minetest.get_modpath("mt_seasons").."/autumn.lua")
dofile(minetest.get_modpath("mt_seasons").."/nodes.lua")

--[[
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




minetest.register_alias("default:pumpkin", "mt_seasons:pumpkin")
minetest.register_alias("default:pumpkin_1", "mt_seasons:pumpkin_1")
minetest.register_alias("default:pumpkin_2", "mt_seasons:pumpkin_2")
minetest.register_alias("default:pumpkin_3", "mt_seasons:pumpkin_3")
minetest.register_alias("default:pumpkin_4", "mt_seasons:pumpkin_4")
minetest.register_alias("default:pumpkin_5", "mt_seasons:pumpkin_5")
minetest.register_alias("default:pumpkin_6", "mt_seasons:pumpkin_6")
minetest.register_alias("default:pumpkin_7", "mt_seasons:pumpkin_7")
minetest.register_alias("default:pumpkin_8", "mt_seasons:pumpkin_8")
minetest.register_alias("default:pumpkin_slice", "mt_seasons:pumpkin_slice")
minetest.register_alias("default:pumpkin_bread", "mt_seasons:pumpkin_bread")
minetest.register_alias("default:pumpkin_dough", "mt_seasons:pumpkin_dough")
minetest.register_alias("default:jackolantern", "mt_seasons:jackolantern")
minetest.register_alias("default:jackolantern_on", "mt_seasons:jackolantern_on")
