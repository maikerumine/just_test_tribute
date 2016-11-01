dofile(minetest.get_modpath("mobs").."/api.lua")
dofile(minetest.get_modpath("mobs").."/crafting.lua")
--dofile(minetest.get_modpath("mobs").."/mapgen.lua")  --all stone world if you like

--Alias use for removing creatures, ghosts, and zombies
mobs:alias_mob("creatures:zombie_spawner_dummy", "mobs:just_test_griefer")
mobs:alias_mob("creatures:ghost_spawner_dummy", "mobs:just_test_griefer")
minetest.register_alias("creatures:zombie_spawner", "default:dirt")
minetest.register_alias("creatures:ghost_spawner", "default:dirt")
mobs:alias_mob("creatures:zombie", "mobs:just_test_griefer")
mobs:alias_mob("creatures:ghost", "mobs:just_test_griefer")
mobs:alias_mob("mobs:spider", "mobs:just_test_griefer")


dofile(minetest.get_modpath("mobs").."/mob_stone_monster.lua")
dofile(minetest.get_modpath("mobs").."/mob_griefer_ghost.lua")
dofile(minetest.get_modpath("mobs").."/mob_just_test_griefer.lua")
dofile(minetest.get_modpath("mobs").."/mob_jack.lua")
--dofile(minetest.get_modpath("mobs").."/mob_spider.lua")
--dofile(minetest.get_modpath("mobs").."/mob_chicken.lua")
	
if minetest.setting_get("log_mods") then
	minetest.log("action", "Just Test 2 mobs-init loaded")
end
