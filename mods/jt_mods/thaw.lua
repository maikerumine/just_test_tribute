-- mods/jt_mods/thaw.lua
--Just Test Mods created by maikerumine
--inspired by Andrey "lag01" the creator of the original Just Test server.
-- Minetest 0.4.14 mod: "jt_mods"
-- namespace: jt_mods
--https://github.com/maikerumine

--License:
--~~~~~~~~
--Code:
--(c) Copyright 2016 maikerumine; modified zlib-License
--see "LICENSE.txt" for details.

--Media(if not stated differently):
--(c) Copyright (2014-2016) maikerumine; CC-BY-SA 3.0

-- melt lag_ice around light sources
minetest.register_abm({
	nodenames = {"jt_mods:lag_ice"},
	interval = 30,
	chance = 10,
	action = function(pos, node, active_object_count, active_object_count_wider)
			if node.name == "jt_mods:lag_ice" then
				minetest.set_node(pos, {name="default:water_source"})
			end
			--end
	end,
})
