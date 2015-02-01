-- Minetest mod acid by Mg
-- License : GPLv2

acid = {}
-- Groups
acid.immediately = {}	-- Chances: 1 ; Interval: 1
acid.quickly	 = {}	-- Chances: 3 ; Interval: 5
acid.slowly		 = {}	-- Chances: 10 ; Interval: 60
acid.never		 = {}	-- Chances: 0 ; Interval: 0
acid.rarely		 = {}	-- Chances: 100; Interval: 2

-- Acids
minetest.register_node("acid:flowing", {
	description = "Acid flowing",
	inventory_image = minetest.inventorycube("acid_source.png"),
	drawtype = "flowingliquid",
	tiles = {"acid_source.png"},
	special_tiles = {
		{
			image="acid_flowing_animated.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=18, aspect_h=18, length=3.3}
		},
		{
			image="acid_flowing_animated.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=18, aspect_h=18, length=3.3}
		},
	},
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	liquidtype = "flowing",
	liquid_alternative_flowing = "acid:flowing",
	liquid_alternative_source = "acid:source",
	liquid_viscosity = 6,
	liquid_renewable = false,
	damage_per_second = 7*2,
	post_effect_color = {a=200, r=255, g=255, b=0},
	groups = {liquid=2, not_in_creative_inventory=1, acid=1},
})

minetest.register_node("acid:source", {
	description = "Acid source",
	drawtype = "liquid",
	drop = "acid:source",
	tiles = {
		{name="acid_source_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}}
	},
	special_tiles = {
		{
			name="acid_source_animated.png",
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0},
			backface_culling = false,
		}
	},
	paramtype = "light",
	walkable = true,
	pointable = true,
	diggable = true,
	damage_per_second = 7*2,
	buildable_to = true,
	liquidtype = "source",
	liquid_alternative_flowing = "acid:flowing",
	liquid_alternative_source = "acid:source",
	liquid_viscosity = 6,
	liquid_renewable = false,
})

-- Acid is stopped by water
minetest.register_abm({
	nodenames = {"group:acid","acid:source"},
	neighbors = {"group:water"},
	interval = 1,
	chance = 2,
	action = function(pos)
		minetest.remove_node(pos)
	end,
})

-- Register functions
acid.register_immediate = function(itemstring)
	table.insert(acid.immediately,1,itemstring)
end

acid.register_quick = function(itemstring)
	table.insert(acid.quickly,1,itemstring)
end

acid.register_slow = function(itemstring)
	table.insert(acid.slowly,1,itemstring)
end

acid.register_never = function(itemstring)
	table.insert(acid.never,1,itemstring)
end

acid.register_rare = function(itemstring)
	table.insert(acid.rarely,1,itemstring)
end

acid.found_in_table = function(tablet, itemstring)
	local i = false
	for k,v in ipairs(tablet) do
		if v == itemstring then
			i = true
			break
		end
	end
	return i
end

-- Registrations
acid.register_immediate("group:snappy")
acid.register_immediate("group:flowers")
acid.register_immediate("group:oddly_breakable_by_hand")
acid.register_immediate("group:crumbly")
acid.register_quick("group:inflammable")
acid.register_quick("default:mossycobble")
acid.register_quick("default:cobble")
acid.register_quick("group:choppy")
acid.register_quick("group:stone")
acid.register_quick("group:cracky")
acid.register_never("default:cloud")
acid.register_never("default:glass")
acid.register_never("default:obsidian_glass")

-- ABMs
minetest.register_abm({
	nodenames = acid.immediately,
	neighbors = {"group:acid"},
	interval = 1,
	chance = 1,
	action = function(pos)
		if not acid.found_in_table(acid.never,minetest.get_node(pos).name) then
			minetest.remove_node(pos)
		end
	end,
})

minetest.register_abm({
	nodenames = acid.quickly,
	neighbors = {"group:acid"},
	interval = 5,
	chance = 3,
	action = function(pos)
		if not acid.found_in_table(acid.never,minetest.get_node(pos).name) then
			minetest.remove_node(pos)
		end
	end,
})

minetest.register_abm({
	nodenames = acid.immediately,
	neighbors = {"group:acid"},
	interval = 60,
	chance = 10,
	action = function(pos)
		if not acid.found_in_table(acid.never,minetest.get_node(pos).name) then
			minetest.remove_node(pos)
		end
	end,
})

minetest.register_abm({
	nodenames = acid.immediately,
	neighbors = {"group:acid"},
	interval = 2,
	chance = 100,
	action = function(pos)
		if not acid.found_in_table(acid.never,minetest.get_node(pos).name) then
			minetest.remove_node(pos)
		end
	end,
})
