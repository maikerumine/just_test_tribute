-- melt lag_ice around light sources
minetest.register_abm({
	nodenames = {"default:lag_ice"},
	interval = 30,
	chance = 10,
	action = function(pos, node, active_object_count, active_object_count_wider)
			if node.name == "default:lag_ice" then
				minetest.set_node(pos, {name="default:water_source"})
			end
			--end
	end,
})
