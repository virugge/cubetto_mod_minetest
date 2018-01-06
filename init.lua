-- By virugge

---------------
-- CUBI MESSAGGIO --
---------------

local open = io.open

--Funzione locale per leggere file
local function read_file(path)
	  --Legge il file in R = read mode B = binary mode
	  local file = open(path, "rb") 
	  if not file then return nil end
		 --*a oppure *all legge intero file
	  local content = file:read "*all" 
	  file:close()
	  return content
end

minetest.register_on_joinplayer(function(player)
	minetest.chat_send_all(player:get_player_name().." sei benvenuto!")
end)
minetest.register_on_leaveplayer(function(player)
	minetest.chat_send_all(player:get_player_name().." ha abbandonato il gioco.")
end)


minetest.register_on_player_receive_fields(function(player, formname, fields)
	if fields.exit then
		return
	elseif fields.leggi then
		local path = minetest.get_modpath("cubetto").."/dati.txt"
		local contenuto = read_file(path)
		--print (contenuto)
		minetest.show_formspec(player:get_player_name(), "cubetto:leggi_istruzioni",
		"size[7,7]"..
		"textarea[0.1,0.1;7.4,7;contenuto;;"..contenuto.."]"..
		"button_exit[2.6,6.3;2,1;exit1;Esci]"..
		"bgcolor[#000000DD;false]")
		--print("leggi ok")
		return
	elseif fields.exit1 then return
	end
end)

-- busta rossa
minetest.register_node("cubetto:bustarossa",{
	description = "Busta rossa",
	drawtype="nodebox",
	tiles ={
		"rosso2.png",
		"rosso2.png",
		"rosso2.png",
		"rosso2.png",
		"rosso1.png",
		"rosso1.png",
	},
	--[[tiles ={
		"_up.png",
		"_down.png",
		"_right.png",
		"_left.png",
		"_back.png",
		"_front.png",
	},]]
	inventory_image = "rosso1.png",
	wield_image = "rosso1.png",
	paramtype="light",
	paramtype2 = "facedir",
	walkable = false,
	drop="cubetto:bustarossa",
	buildable_to = false,
	groups = {},
	node_box={
		type = "fixed",
		fixed = {-0.5, -0.5, -0.1, 0.5, 0.5, 0.1},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.1, 0.5, 0.5, 0.1},
	},
	on_rightclick = function(pos, node, player, pointed_thing)
		local meta = minetest.get_meta(pos)
		minetest.show_formspec(player:get_player_name(), "cubetto:istruzioni",
				"size[8,4]" ..
				"label[0,0;Vuoi leggere le istruzioni?]" ..
				"button[2,3;2,1;leggi;SI]"..
				"button_exit[0,3;2,1;exit;NO]")
	end
})

