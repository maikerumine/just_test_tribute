dofile(minetest.get_modpath("mobs").."/api.lua")
dofile(minetest.get_modpath("mobs").."/crafting.lua")
--dofile(minetest.get_modpath("mobs").."/mapgen.lua")



dofile(minetest.get_modpath("mobs").."/mob_stone_monster.lua")
dofile(minetest.get_modpath("mobs").."/mob_griefer_ghost.lua")
dofile(minetest.get_modpath("mobs").."/mob_just_test_griefer.lua")
dofile(minetest.get_modpath("mobs").."/mob_jack.lua")
dofile(minetest.get_modpath("mobs").."/mob_spider.lua")
--dofile(minetest.get_modpath("mobs").."/mob_chicken.lua")
	
if minetest.setting_get("log_mods") then
	minetest.log("action", "Just Test 2 mobs-init loaded")
end
