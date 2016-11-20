
--meat
minetest.register_craftitem("mobs:meat", {
	description = "Cooked Meat",
	inventory_image = "mobs_meat.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craftitem("mobs:meat_raw", {
	description = "Raw Meat",
	inventory_image = "mobs_meat_raw.png",
})

minetest.register_craft({
	type = "cooking",
	output = "mobs:meat",
	recipe = "mobs:meat_raw",
})


minetest.register_alias("spidermob:meat", "default:meat")
minetest.register_alias("spidermob:meat_raw", "default:meat_raw")


minetest.register_alias("default:meat_raw", "mobs:meat_raw")
minetest.register_alias("default:meat", "mobs:meat")