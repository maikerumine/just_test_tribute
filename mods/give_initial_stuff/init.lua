minetest.register_on_newplayer(function(player)
	--print("on_newplayer")
		minetest.log("action", "Giving initial stuff to player "..player:get_player_name())
		player:get_inventory():add_item('main', 'default:torch 3')
		player:get_inventory():add_item('main', 'default:apple 3')
		player:get_inventory():add_item('main', 'default:pick_wood 1')
		player:get_inventory():add_item('main', 'mt_seasons:jackolantern 1')
		player:get_inventory():add_item('main', 'default:goldblock 1')
		
		

end)

