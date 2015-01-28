-- Minetest mod acid by Mg
-- License : GPLv2

-- Groups
immediatly 	= {}	-- Chances: 1 ; Interval: 1
quickly		= {}	-- Chances: 3 ; Interval: 5
slowly		= {}	-- Chances: 10 ; Interval: 60
never		= {}	-- Chances: 0 ; Interval: 1
rarely		= {}	-- Chances: 100; Interval: 2

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


-- Acid is stopped by water only
minetest.register_abm({
	nodenames = {"group:acid"},
	neighbors = {"group:water"},
	interval = 1,
	chance = 2,
	action = function(pos)
		minetest.remove_node(pos)
	end,
})