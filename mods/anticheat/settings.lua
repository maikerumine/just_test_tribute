-- ANTI CHEAT by rnd
-- Copyright 2016 rnd
-- includes modified/bugfixed spectator mod by jp

-------------------------------------------------------------------------
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
-------------------------------------------------------------------------


-- SETTINGS --------------------------------------------------------------
anticheatsettings.CHEAT_TIMESTEP = 15; -- check all players 
anticheatsettings.CHECK_AGAIN = 15; -- after player found in bad position check again after this to make sure its not lag, this should be larger than expected lag in seconds

-- moderators list, those players can use cheat debug and will see full cheat message
anticheatsettings.moderators = {
["rnd"]=true,
["sasha2"]=true,
["maikerumine"]=true,
["sorcerykid"]=true,
["Zorg"]=true,
["AspireMint"]=true,
["843jdc"]=true,
["Fixer"] = true,
}
-- END OF SETTINGS --------------------------------------------------------