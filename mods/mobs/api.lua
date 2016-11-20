--Andrey makes small modifications for performance and my world needs

mobs = {}
function mobs:register_mob(name, def)
	minetest.register_entity(name, {
		hp_max = def.hp_max,
		physical = true,
		collisionbox = def.collisionbox,
		visual = def.visual,
		visual_size = def.visual_size,
		mesh = def.mesh,
		textures = def.textures,
		makes_footstep_sound = def.makes_footstep_sound,
		view_range = def.view_range,
		walk_velocity = def.walk_velocity,
		run_velocity = def.run_velocity,
		damage = def.damage,
		light_damage = def.light_damage,
		water_damage = def.water_damage,
		lava_damage = def.lava_damage,
		disable_fall_damage = def.disable_fall_damage,
		drops = def.drops,
		bone_drops = def.bone_drops,
		armor = def.armor,
		drawtype = def.drawtype,
		on_rightclick = def.on_rightclick,
		type = def.type,
		attack_type = def.attack_type,
		arrow = def.arrow,
		shoot_interval = def.shoot_interval,
		sounds = def.sounds,
		animation = def.animation,
		follow = def.follow,
		jump = def.jump or true,
		timer = 0,
		env_damage_timer = 0, -- only if state = "attack"
		depressed=false,
		attack = {player=nil, dist=nil},
		state = "stand",
		v_start = false,
		old_y = nil,
		lifetimer = def.lifetimer,
		tamed = false,
		food_location = nil,
		path_blocked_count =0,
		--full_name = def.full_name,
		
		--bone_drop ={def.min,def.max},
		--bone_drop.min = 0,
		--bone_drop.max = 2,		
		
		set_velocity = function(self, v)
			local yaw = self.object:getyaw()
			if self.drawtype == "side" then
				yaw = yaw+(math.pi/2)
			end
			local x = math.sin(yaw) * -v
			local z = math.cos(yaw) * v
			if yaw~=yaw then
				minetest.log("error", "mob at wrong position!!!"..yaw)
			end
			self.object:setvelocity({x=x, y=self.object:getvelocity().y, z=z})
		end,
		
		get_velocity = function(self)
			local v = self.object:getvelocity()
			return (v.x^2 + v.z^2)^(0.5)
		end,
		
		set_animation = function(self, type)
			if not self.animation then
				return
			end
			if not self.animation.current then
				self.animation.current = ""
			end
			if type == "stand" and self.animation.current ~= "stand" then
				if
					self.animation.stand_start
					and self.animation.stand_end
					and self.animation.speed_normal
				then
					self.object:set_animation(
						{x=self.animation.stand_start,y=self.animation.stand_end},
						self.animation.speed_normal, 0
					)
					self.animation.current = "stand"
				end
			elseif type == "walk" and self.animation.current ~= "walk"  then
				if
					self.animation.walk_start
					and self.animation.walk_end
					and self.animation.speed_normal
				then
					self.object:set_animation(
						{x=self.animation.walk_start,y=self.animation.walk_end},
						self.animation.speed_normal, 0
					)
					self.animation.current = "walk"
				end
			elseif type == "run" and self.animation.current ~= "run"  then
				if
					self.animation.run_start
					and self.animation.run_end
					and self.animation.speed_run
				then
					self.object:set_animation(
						{x=self.animation.run_start,y=self.animation.run_end},
						self.animation.speed_run, 0
					)
					self.animation.current = "run"
				end
			elseif type == "punch" and self.animation.current ~= "punch"  then
				if
					self.animation.punch_start
					and self.animation.punch_end
					and self.animation.speed_normal
				then
					self.object:set_animation(
						{x=self.animation.punch_start,y=self.animation.punch_end},
						self.animation.speed_normal, 0
					)
					self.animation.current = "punch"
				end
			end
		end,
		
		on_step = function(self, dtime)
			--alredy checked at creation time
			-- if self.type == "monster" and minetest.setting_getbool("only_peaceful_mobs") then
				-- self.object:remove()
				-- return
			-- end
			
			if self.object:get_hp() == 0 then
				self.object:remove()
				return
			end
			
			local pos = self.object:getpos()
			
			self.lifetimer = self.lifetimer - dtime
			if self.lifetimer <= 0 and not self.tamed then
				if self.state=="attack" and 
					not self.depressed and
					self.attack.player and 
					self.attack.player:is_player()
				then
					local p = self.attack.player:getpos()
					local dist = ((p.x-pos.x)^2 + (p.y-pos.y)^2 + (p.z-pos.z)^2)^0.5
					if dist < (self.view_range+3) then
						self.depressed=true
						self.lifetimer=30
					else
						self.object:remove()
						return
					end
				else
					self.object:remove()
					return
				end
			end
			
			--just gravity
			self.object:setacceleration({x=0, y=-10, z=0})
			
			if self.disable_fall_damage and self.object:getvelocity().y == 0 then
				if not self.old_y then
					self.old_y = pos.y
				else
					local d = self.old_y - pos.y
					if d > 5 then
						local damage = d-5
						self.object:set_hp(self.object:get_hp()-damage)
						if self.object:get_hp() == 0 then
							self.object:remove()
							return
						end
					end
					self.old_y = pos.y
				end
			end
			
			self.timer = self.timer+dtime
			if self.state ~= "attack" then
				if self.timer < 1 then
					return
				end
				self.timer = 0
			end
			
			if self.sounds and self.sounds.random and math.random(1, 400) <= 1 then
				minetest.sound_play(self.sounds.random, {object = self.object})
			end
			
			local do_env_damage = function(self)
				local n = minetest.get_node(pos)
				
				if self.light_damage and self.light_damage ~= 0
					and pos.y>0
					and minetest.get_node_light(pos)
					and minetest.get_node_light(pos) > 4
					and minetest.get_timeofday() > 0.2
					and minetest.get_timeofday() < 0.8
				then
					self.object:set_hp(self.object:get_hp()-self.light_damage)
					if self.object:get_hp() == 0 then
						self.object:remove()
						return
					end
				end
				
				if self.water_damage and self.water_damage ~= 0 and
					minetest.get_item_group(n.name, "water") ~= 0
				then
					self.object:set_hp(self.object:get_hp()-self.water_damage)
					if self.object:get_hp() == 0 then
						self.object:remove()
						return
					end
				end
				
				if self.lava_damage and self.lava_damage ~= 0 and
					minetest.get_item_group(n.name, "lava") ~= 0
				then
					self.object:set_hp(self.object:get_hp()-self.lava_damage)
					if self.object:get_hp() == 0 then
						self.object:remove()
						return
					end
				end
			end
			
			self.env_damage_timer = self.env_damage_timer + dtime
			if self.env_damage_timer > 1 then
				self.env_damage_timer = 0
				do_env_damage(self)
			end
			
			--look around
			if self.state ~= "attack"
				and self.type == "monster" 
				and minetest.setting_getbool("enable_damage") 
				and self.lifetimer>3 
			then
				for _,player in pairs(minetest.get_connected_players()) do
					if math.random(1, 100) > 10 and player and player:is_player() then
						local p = player:getpos()
						local dist = ((p.x-pos.x)^2 + (p.y-pos.y)^2 + (p.z-pos.z)^2)^0.5
						if dist==dist and dist < self.view_range then
							self.state = "attack"
							self.attack.player = player
							--self.attack.dist = dist
							break --any first player seen
						end
					end
				end
			end
			
			if self.follow ~= "" and not self.following then
				for _,player in pairs(minetest.get_connected_players()) do
					local p = player:getpos()
					local dist = ((p.x-pos.x)^2 + (p.y-pos.y)^2 + (p.z-pos.z)^2)^0.5
					if self.view_range and dist < self.view_range then
						self.following = player
					end
				end
			end
			
			if self.following and self.following:is_player() then
				if self.following:get_wielded_item():get_name() ~= self.follow then
					self.following = nil
					self.v_start = false
				else
					local p = self.following:getpos()
					local dist = ((p.x-pos.x)^2 + (p.y-pos.y)^2 + (p.z-pos.z)^2)^0.5
					if dist > self.view_range then
						self.following = nil
						self.v_start = false
					else
						local vec = {x=p.x-pos.x, y=p.y-pos.y, z=p.z-pos.z}
						local vec_x=0
						if vec.x~=0 then vec_x=vec.x else vec_x=0.01 end
						local yaw = math.atan(vec.z/vec_x)+math.pi/2
						if self.drawtype == "side" then
							yaw = yaw+(math.pi/2)
						end
						if p.x > pos.x then
							yaw = yaw+math.pi
						end
						self.object:setyaw(yaw)
						if dist > 2 then
							if not self.v_start then
								self.v_start = true
								self:set_velocity(self.walk_velocity)
							else
								if self.jump and self.get_velocity(self) <= 0.5 and self.object:getvelocity().y == 0 then
									local v = self.object:getvelocity()
									v.y = 5
									self.object:setvelocity(v)
								end
								self:set_velocity(self.walk_velocity)
							end
							self:set_animation("walk")
						else
							self.v_start = false
							self:set_velocity(0)
							self:set_animation("stand")
						end
						return
					end
				end
			end
			
			if self.state == "stand" then
				if math.random(1, 4) == 1 then
					self.object:setyaw(self.object:getyaw()+((math.random(0,360)-180)/180*math.pi))
				end
				if math.random(1, 100) <= 50 then
					self:set_velocity(self.walk_velocity)
					self.state = "walk"
					self:set_animation("walk")
				else
					self:set_velocity(0)
					self:set_animation("stand")
				end
			elseif self.state == "walk" then
				if math.random(1, 100) <= 15 then
						self.object:setyaw(self.object:getyaw()+((math.random(0,360)-180)/180*math.pi))
				elseif self.food_location ~= nil and math.random(1, 100) <= 35 then
					local p = self.food_location
					local vec = {x=p.x-pos.x, y=p.y-pos.y, z=p.z-pos.z}
					local vec_x=0
					if vec.x~=0 then vec_x=vec.x else vec_x=0.01 end
					local yaw = math.atan(vec.z/vec_x)+math.pi/2
					if self.drawtype == "side" then
						yaw = yaw+(math.pi/2)
					end
					if p.x > pos.x then
						yaw = yaw+math.pi
					end
					self.object:setyaw(yaw)
				end
				if self.jump and self.get_velocity(self) <= 0.5 and self.object:getvelocity().y == 0 then
					local v = self.object:getvelocity()
					v.y = 6
					self.object:setvelocity(v)
				end
				if math.random(1, 100) <= 10 then
					self:set_velocity(0)
					self.state = "stand"
					self:set_animation("stand")
				else
					self:set_velocity(self.walk_velocity)
					self:set_animation("walk")
				end
			elseif self.state == "attack" and self.attack_type == "dogfight" then
				if not self.attack.player or not self.attack.player:is_player() then
					self.state = "stand"
					self:set_animation("stand")
					return
				end
				local p = self.attack.player:getpos()
				local dist = ((p.x-pos.x)^2 + (p.y-pos.y)^2 + (p.z-pos.z)^2)^0.5
				if dist > (self.view_range+2) or self.attack.player:get_hp() <= 0 then
					self.state = "stand"
					self.v_start = false
					self:set_velocity(0)
					self.attack = {player=nil, dist=nil}
					self:set_animation("stand")
					return
				else
					self.attack.dist = dist
				end
				
				local vec = {x=p.x-pos.x, y=p.y-pos.y, z=p.z-pos.z}
				local vec_x=0
				if vec.x~=0 then vec_x=vec.x else vec_x=0.01 end
				local yaw = math.atan(vec.z/vec_x)+math.pi/2
				if self.drawtype == "side" then
					yaw = yaw+(math.pi/2)
				end
				if p.x > pos.x then
					yaw = yaw+math.pi
				end

				self.object:setyaw(yaw)
				if self.attack.dist > 2 then
					if self.jump and self.get_velocity(self) <= 0.5 and self.object:getvelocity().y == 0 then
						local v = self.object:getvelocity()
						v.y = 6
						self.object:setvelocity(v)
						self:set_velocity(self.walk_velocity)
					else
						self:set_velocity(self.run_velocity)
						self:set_animation("run")
					end
				else
					self:set_velocity(0)
					self:set_animation("punch")
					self.v_start = false
					if self.timer > 1 then
						self.timer = 0
						if self.sounds and self.sounds.attack and math.random(1, 100) <= 30  then
							minetest.sound_play(self.sounds.attack, {object = self.object})
						end
						self.attack.player:punch(self.object, 1.0,  {
							full_punch_interval=1.0,
							damage_groups = {fleshy=self.damage}
						}, vec)
					end
				end
			elseif self.state == "attack" and self.attack_type == "shoot" then
				if not self.attack.player or not self.attack.player:is_player() then
					self.state = "stand"
					self:set_animation("stand")
					return
				end
				local s = self.object:getpos()
				local p = self.attack.player:getpos()
				local dist = ((p.x-s.x)^2 + (p.y-s.y)^2 + (p.z-s.z)^2)^0.5
				if dist > self.view_range or self.attack.player:get_hp() <= 0 then
					self.state = "stand"
					self.v_start = false
					self:set_velocity(0)
					self.attack = {player=nil, dist=nil}
					self:set_animation("stand")
					return
				else
					self.attack.dist = dist
				end
				
				local vec = {x=p.x-s.x, y=p.y-s.y, z=p.z-s.z}
				local vec_x=0
				if vec.x~=0 then vec_x=vec.x else vec_x=0.01 end
				local yaw = math.atan(vec.z/vec_x)+math.pi/2
				if self.drawtype == "side" then
					yaw = yaw+(math.pi/2)
				end
				if p.x > s.x then
					yaw = yaw+math.pi
				end
				self.object:setyaw(yaw)
				self:set_velocity(0)
				
				if self.timer > self.shoot_interval and math.random(1, 100) <= 60 then
					self.timer = 0
					
					self:set_animation("punch")
					
					if self.sounds and self.sounds.attack then
						minetest.sound_play(self.sounds.attack, {object = self.object})
					end
					
					local p = self.object:getpos()
					p.y = p.y + (self.collisionbox[2]+self.collisionbox[5])/2
					local obj = minetest.add_entity(p, self.arrow)
					local amount = (vec.x^2+vec.y^2+vec.z^2)^0.5
					local v = obj:get_luaentity().velocity
					vec.y = vec.y+1
					vec.x = vec.x*v/amount
					vec.y = vec.y*v/amount
					vec.z = vec.z*v/amount
					obj:setvelocity(vec)
				end
			end
		end,
		
		on_activate = function(self, staticdata, dtime_s)
			self.object:set_armor_groups({fleshy=self.armor})
			self.object:setacceleration({x=0, y=-10, z=0})
			self.state = "stand"
			self.object:setvelocity({x=0, y=self.object:getvelocity().y, z=0})
			self.object:setyaw(math.random(1, 360)/180*math.pi)
			if self.type == "monster" and minetest.setting_getbool("only_peaceful_mobs") then
				self.object:remove()
				return
			end
			
			-- walk approximate direction
			local s = self.object:getpos()
			if s == s then
				for _,player in pairs(minetest.get_connected_players()) do
					if math.random(1, 100) < 80 and player and player:is_player() then
						local p = player:getpos()
						local dist = ((p.x-s.x)^2 + (p.y-s.y)^2 + (p.z-s.z)^2)^0.5
						if dist==dist and dist < 120 then
							self.food_location = {x=p.x, y=p.y, z=p.z}
							break --any first player seen
						end
					end
				end
			end
			
			--remove monster, there already is plenty of them
			if self.food_location==nil then
				self.object:remove()
				return
			end
			
			if staticdata then
				local tmp = minetest.deserialize(staticdata)
				if tmp and tmp.lifetimer then
					self.lifetimer = tmp.lifetimer - dtime_s
				end
				if tmp and tmp.tamed then
					self.tamed = tmp.tamed
				end
				-- minetest.log("action", "Recreating mob")
			end
			self.lifetimer = self.lifetimer - dtime_s
			
			if self.lifetimer <= 0 and not self.tamed then
				self.object:remove()
				return
			end
		end,
		
		get_staticdata = function(self)
			local tmp = {
				-- lifetimer = 0,	--dont save it please....
				lifetimer = self.lifetimer,
				tamed = self.tamed,
			}
			return minetest.serialize(tmp)
		end,
	--[[
-08-10 16:42:26: ERROR[Main]: ServerError: Lua: Runtime error from mod 'mobs' in callback luaentity_Punch(): D:\MTSERVER\bin\..\mods\mobs/api.lua:569: attempt to perform arithmetic on field 'path_blocked_count' (a nil value)
2016-08-10 16:42:26: ERROR[Main]: stack traceback:
2016-08-10 16:42:26: ERROR[Main]: 	D:\MTSERVER\bin\..\mods\mobs/api.lua:569: in function <D:\MTSERVER\bin\..\mods\mobs/api.lua:524>


]]	
	
	--BONES ON PUNCH
          on_punch = function(self, hitter)
                --mob killed
             if self.object:get_hp() <= 0 then
                if hitter and hitter:is_player() and hitter:get_inventory() then
                   for _,drop in ipairs(self.drops) do
                      if math.random(1, drop.chance) == 1 then
                         hitter:get_inventory():add_item("main", ItemStack(drop.name.." "..math.random(drop.min, drop.max)))
                      end
                   end
                        --mob bones, like player bones
                        if math.random(1, 3) == 1 and self.path_blocked_count < 1 then --mob was free, not in cage or something
                            local pos = self.object:getpos()
                            local nn = minetest.get_node(pos).name
                            local spaceforbones=nil
                            if nn=="air" or nn=="default:water_flowing" or nn=="default:water_source" or nn=="default:lava_source" or nn=="default:lava_flowing" then
                                spaceforbones=pos
                                minetest.add_node(spaceforbones, {name="bones:bones"} )
                                local meta = minetest.get_meta(spaceforbones)
                                local inv = meta:get_inventory()
                                inv:set_size("main", 8*4)
				
				--here is where things are broke
                                for _,bone_drop in ipairs(self.bone_drops) do
                                    if math.random(1, bone_drop.chance) == 1 then
                                        local stack = ItemStack(bone_drop.name.." "..math.random(bone_drop.min, bone_drop.max))
                                        if inv:room_for_item("main", stack) then
                                            inv:add_item("main", stack)
                                        end
                                    end
                                end

                                meta:set_string("formspec", "size[8,9;]"..
                                        "list[current_name;main;0,0;8,4;]"..
                                        "list[current_player;main;0,5;8,4;]")
                                	--SHOW TIME AT DEATH AND WHO KILLED
					local time = os.date("*t");
					meta:set_string("infotext", self.name.." was slain".." at ".. time.year .. "/".. time.month .. "/" .. time.day .. ", " ..time.hour.. ":".. time.min .." by: ("..hitter:get_player_name()..")"); --new
					meta:set_string("owner", self.name)  --new
                                --meta:set_string("infotext", self.name.."'s fresh bones")  --lua:570: attempt to concatenate field 'full_name' (a nil value)  --old
                                --meta:set_string("owner", "Monster ")  --old
                                meta:set_int("bonetime_counter", 0)
                                local timer  = minetest.get_node_timer(spaceforbones)
                                timer:start(1)
                            end
                        end
                   minetest.log("action", "Killed mob "..name.." by "..hitter:get_player_name())
                end
                self.object:remove()
                return
             elseif self.object:get_hp() == 4 or self.object:get_hp() == 6 or self.object:get_hp() == 10 then
                    self.path_blocked_count = self.path_blocked_count - 1;
                self.state="walk"
             else
                self.v_start=true
                if hitter and hitter:is_player() and hitter:get_wielded_item() then
                   local tool=hitter:get_wielded_item()
                   tool:add_wear(100)
                   hitter:set_wielded_item( tool )
                end
             end
          end,	
		
		
		
		
		
		
		
		--orig--V
		--[[
		on_punch = function(self, hitter)
			if self.object:get_hp() <= 0 then
				if hitter and hitter:is_player() and hitter:get_inventory() then
					for _,drop in ipairs(self.drops) do
						if math.random(1, drop.chance) == 1 then
							hitter:get_inventory():add_item("main", ItemStack(drop.name.." "..math.random(drop.min, drop.max)))
						end
					end
					minetest.log("action", "Killed mob "..name.." by "..hitter:get_player_name())
				end
				self.object:remove()
				return
			elseif self.object:get_hp() == 4 or self.object:get_hp() == 6 or self.object:get_hp() == 10 then
				self.state="walk"
			else
				self.v_start=true
				if hitter and hitter:is_player() and hitter:get_wielded_item() then
					local tool=hitter:get_wielded_item()
					tool:add_wear(100)
					hitter:set_wielded_item( tool )
				end
			end
		end,
		]]
		--orig--^
		
	})
end

mobs.spawning_mobs = {}
function mobs:register_spawn(name, nodes, max_light, min_light, chance, active_object_count, max_height, min_height, spawn_func)
	mobs.spawning_mobs[name] = true
	minetest.register_abm({
		nodenames = nodes,
		neighbors = {"air"},
		interval = 10,
		chance = chance,
		action = function(pos, node, _, active_object_count_wider)
			if active_object_count_wider > active_object_count then
				return
			end
			if not mobs.spawning_mobs[name] then
				return
			end
			local pos2={x=pos.x, y=pos.y+2, z=pos.z} --was +2
			if minetest.get_node(pos2).name ~= "air" then
				return
			elseif minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name ~= "air" then  --was +1
				return
			elseif not minetest.get_node_light(pos2) then
				return
			elseif minetest.get_node_light(pos2) > max_light then
				return
			elseif minetest.get_node_light(pos2) < min_light then
				return
			elseif pos.y > max_height then
				return
			elseif pos.y < min_height then
				return
			end
			
			if spawn_func and not spawn_func(pos, node) then
				return
			end
			
			if minetest.setting_getbool("display_mob_spawn") then
				minetest.chat_send_all("[mobs] Add "..name.." at "..minetest.pos_to_string(pos))
			end
			minetest.log("action", "Adding mob "..name.." on block "..nodes.." at "..pos.x..", "..(pos.y+1)..", "..pos.z)
			minetest.add_entity({x=pos.x, y=pos.y+2, z=pos.z}, name)  --was +1 fixed water dwellers
		end
	})
end

--for Andrey world usage
mobs.spawning_mobs_near = {}
function mobs:register_spawn_near(name, nodes, max_light, min_light, tries)
	mobs.spawning_mobs_near[name] = true

	local timer = 0
	minetest.register_globalstep(function(dtime)
		timer = timer + dtime;
		if timer >= 30 then
			for _,player in pairs(minetest.get_connected_players()) do
				if math.random(1, 100) > 10 and player and player:is_player() then
					local pos_player = player:getpos()
					local add_mob=true
					if pos_player.x>-1500 and pos_player.x<1500 and pos_player.z>-1500 and pos_player.z<1500 and pos_player.y>-80 then
					--if pos_player.x>-500 and pos_player.x<500 and pos_player.z>-500 and pos_player.z<500 and pos_player.y>-80 then
						add_mob=false
					end
					
					if add_mob then
						local positions = minetest.find_nodes_in_area(
						{x=pos_player.x-10, y=pos_player.y-7, z=pos_player.z-10},
						{x=pos_player.x+10, y=pos_player.y+4, z=pos_player.z+10},
						"air")
						for i=1, tries do
							if #positions>1 and add_mob then
								local pos = positions[math.random(1, #positions-1)]
								for i=1, 7 do
									if minetest.get_node({x=pos.x, y=pos.y, z=pos.z}).name == "air" then
										pos={x=pos.x, y=pos.y-1, z=pos.z}
									end
								end
								local pos2={x=pos.x, y=pos.y+2, z=pos.z}
								
								if minetest.get_node(pos).name ~= nodes then
									add_mob=false
								elseif minetest.get_node(pos2).name ~= "air" then
									add_mob=false
								elseif not minetest.get_node_light(pos2) then
									add_mob=false
								elseif minetest.get_node_light(pos2) > max_light then
									add_mob=false
								elseif minetest.get_node_light(pos2) < min_light then
									add_mob=false
								end
								
								if add_mob then
									minetest.log("action", "Adding mob "..name.." at "..pos.x..", "..(pos.y+1)..", "..pos.z)
									minetest.add_entity({x=pos.x, y=pos.y+1, z=pos.z}, name)
									add_mob=false
								end
							end
						end
					end
				end
			end
			timer=0
		end
	end)
end

function mobs:register_arrow(name, def)
	minetest.register_entity(name, {
		physical = false,
		visual = def.visual,
		visual_size = def.visual_size,
		textures = def.textures,
		velocity = def.velocity,
		hit_player = def.hit_player,
		hit_node = def.hit_node,
		
		on_step = function(self, dtime)
			local pos = self.object:getpos()
			if minetest.get_node(self.object:getpos()).name ~= "air" then
				self.hit_node(self, pos, node)
				self.object:remove()
				return
			end
			pos.y = pos.y-1
			for _,player in pairs(minetest.get_objects_inside_radius(pos, 1)) do
				if player:is_player() then
					self.hit_player(self, player)
					self.object:remove()
					return
				end
			end
		end
	})
end
-- compatibility function for old entities to new modpack entities
-- compatibility function for old entities to new modpack entities
function mobs:alias_mob(old_name, new_name)

	-- spawn egg
	minetest.register_alias(old_name, new_name)

	-- entity
	minetest.register_entity(":" .. old_name, {

		physical = false,

		on_step = function(self)

			local pos = self.object:getpos()

			minetest.add_entity(pos, new_name)

			self.object:remove()
		end
	})
end

  --[[      on_punch = function(self, hitter)
                    --mob killed
                 if self.object:get_hp() <= 0 then
                    if hitter and hitter:is_player() and hitter:get_inventory() then
                       for _,drop in ipairs(self.drops) do
                          if math.random(1, drop.chance) == 1 then
                             hitter:get_inventory():add_item("main", ItemStack(drop.name.." "..math.random(drop.min, drop.max)))
                          end
                       end
                            --mob bones, like player bones
                            if math.random(1, 3) == 1 and self.path_blocked_count < 1 then --mob was free, not in cage or something
                                local pos = self.object:getpos()
                                local nn = minetest.get_node(pos).name
                                local spaceforbones=nil
                                if nn=="air" or nn=="default:water_flowing" or nn=="default:water_source" or nn=="default:lava_source" or nn=="default:lava_flowing" then
                                    spaceforbones=pos
                                    minetest.add_node(spaceforbones, {name="bones:bones"} )
                                    local meta = minetest.get_meta(spaceforbones)
                                    local inv = meta:get_inventory()
                                    inv:set_size("main", 8*4)

                                    for _,bone_drop in ipairs(self.bone_drops) do
                                        if math.random(1, bone_drop.chance) == 1 then
                                            local stack = ItemStack(bone_drop.name.." "..math.random(bone_drop.min, bone_drop.max))
                                            if inv:room_for_item("main", stack) then
                                                inv:add_item("main", stack)
                                            end
                                        end
                                    end

                                    meta:set_string("formspec", "size[8,9;]"..
                                            "list[current_name;main;0,0;8,4;]"..
                                            "list[current_player;main;0,5;8,4;]")
                                    meta:set_string("infotext", self.full_name.."'s fresh bones")
                                    meta:set_string("owner", "Stone monster")
                                    meta:set_int("bonetime_counter", 0)
                                    local timer  = minetest.get_node_timer(spaceforbones)
                                    timer:start(10)
                                end
                            end
                       minetest.log("action", "Killed mob "..name.." by "..hitter:get_player_name())
                    end
                    self.object:remove()
                    return
                 elseif self.object:get_hp() == 4 or self.object:get_hp() == 6 or self.object:get_hp() == 10 then
                        self.path_blocked_count = self.path_blocked_count - 1;
                    self.state="walk"
                 else
                    self.v_start=true
                    if hitter and hitter:is_player() and hitter:get_wielded_item() then
                       local tool=hitter:get_wielded_item()
                       tool:add_wear(100)
                       hitter:set_wielded_item( tool )
                    end
                 end
              end,]]
	      
	      
	      
	      
	      --[[
	      
	      
	      	--BREAK maikerumine bones code
if enable_mob_bones == true then
--if self.object:get_hp() <= 0 then
if self.health <= 0 then
if hitter and hitter:is_player() and hitter:get_inventory()
then
--mob bones, like player bones added by Andrei modified by maikerumine
if math.random(1, 1) == 1 then
local pos = self.object:getpos()
local nn = minetest.get_node(pos).name
local spaceforbones=nil
if nn=="air" or nn=="default:water_flowing" or nn=="default:water_source" or nn=="default:lava_source" or nn=="default:lava_flowing" or nn=="default:snow" then
spaceforbones=pos
--minetest.add_node(spaceforbones, {name="bones:bones"} )
minetest.add_node(spaceforbones, {name="esmobs:bones"} )
local meta = minetest.get_meta(spaceforbones)
local inv = meta:get_inventory()
inv:set_size("main", 8*4)
--DROPS FILL BONE
for _,drop in ipairs(self.drops) do
if math.random(1, drop.chance) == 1 then
local stack = ItemStack(drop.name.." "..math.random(drop.min, drop.max))
if inv:room_for_item("main", stack) then
inv:add_item("main", stack)
end
end
end
meta:set_string("formspec", "size[8,9;]"..
"list[current_name;main;0,0;8,4;]"..
"list[current_player;main;0,5;8,4;]")
--BEGIN TIME STRING
local time = os.date("*t");--this keeps the bones meta to turn old
--CHOOSE OPTION BELOW:
meta:set_string("infotext", self.name.." was slain".." at ".. time.year .. "/".. time.month .. "/" .. time.day .. ", " ..time.hour.. ":".. time.min .." by: ("..hitter:get_player_name()..")"); --SHOW TIME AT DEATH AND WHO KILLED
-- meta:set_string("infotext", self.name.."'s fresh bones") --SHOW NO TIME AT BONE EXPIRE
--CHOOSE OPTION BELOW:
-- meta:set_string( "owner", "Extreme Survival Mob R.I.P.") --SET OWNER FOR TIMER
meta:set_string("owner") --SET NO OWNER NO TIMER
meta:set_int("bonetime_counter", 0)
local timer = minetest.get_node_timer(spaceforbones)
timer:start(10)
end
end
minetest.log("action", "Killed mob "..name.." by "..hitter:get_player_name())
end
self.object:remove()
return
elseif self.object:get_hp() == 1 or self.object:get_hp() == 1 or self.object:get_hp() == 2 then
self.state="run"
else
self.v_start=true
-- if hitter and hitter:is_player() and hitter:get_wielded_item() then
--local tool=hitter:get_wielded_item()
--tool:add_wear(100)
--hitter:set_wielded_item( tool )
-- end
end
end
--BREAK




]]
