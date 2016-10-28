-- mods/jt_mods/craftitems.lua
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
minetest.register_craftitem("jt_mods:handle", {
	description = "Handle for Tools",
	inventory_image = "default_stick.png^[colorize:black:150"
})

minetest.register_craftitem("jt_mods:griefer_soul", {
	description = "Griefer Soul",
	inventory_image = "default_coal_lump.png^[colorize:red:120",
})
