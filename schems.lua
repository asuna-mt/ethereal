
local path = minetest.get_modpath("ethereal") .. "/schematics/"
local dpath = minetest.get_modpath("default") .. "/schematics/"


-- load schematic tables
dofile(path .. "orange_tree.lua")
dofile(path .. "banana_tree.lua")
dofile(path .. "bamboo_tree.lua")
dofile(path .. "birch_tree.lua")
dofile(path .. "bush.lua")
dofile(path .. "waterlily.lua")
dofile(path .. "volcanom.lua")
dofile(path .. "volcanol.lua")
dofile(path .. "frosttrees.lua")
dofile(path .. "palmtree.lua")
dofile(path .. "pinetree.lua")
dofile(path .. "yellowtree.lua")
dofile(path .. "mushroomone.lua")
dofile(path .. "willow.lua")
dofile(path .. "bigtree.lua")
dofile(path .. "redwood_tree.lua")
dofile(path .. "redwood_small_tree.lua")
dofile(path .. "vinetree.lua")
dofile(path .. "sakura.lua")
dofile(path .. "igloo.lua")
dofile(path .. "lemon_tree.lua")
dofile(path .. "olive_tree.lua")
dofile(path .. "basandra_bush.lua")


-- helper function
local add_schem = function(a, b, c, d, e, f, g, h, i, j, k, l)

	-- if not 1 then biome disabled, don't add
	if g ~= 1 then return end

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = a,
		sidelen = 80,
		fill_ratio = b,
		biomes = c,
		y_min = d,
		y_max = e,
		schematic = f,
		flags = "place_center_x, place_center_z",
		replacements = h,
		spawn_by = i,
		num_spawn_by = j,
		rotation = k or "random",
		place_offset_y = l,
	})
end

-- Special grass in jumble biome which must be place before schematics
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_rainforest_litter"},
	sidelen = 8,
	noise_params = {
		offset = -0.3125,
		scale = -1.25,
		spread = {x = 150, y = 100, z = 150},
		seed = 330,
		octaves = 3,
		persist = 0.95
	},
	biomes = {"jumble"},
	y_max = 31000,
	y_min = 1,
	decoration = "default:dirt_with_grass",
	place_offset_y = -1,
	flags = "force_placement"
})

-- igloo
--[[add_schem("default:snowblock", 0.0005, {"glacier"}, 3, 50,
	ethereal.igloo, ethereal.glacier, nil, "default:snowblock", 8, "random")]]

minetest.register_decoration({
	name = "ethereal:small_sakura_tree",
	deco_type = "schematic",
	place_on = "ethereal:bamboo_dirt",
	sidelen = 80,
	fill_ratio = 0.00275,
	biomes = {"sakura"},
	y_min = 5,
	y_max = 31000,
	schematic = path.."cherry_tree_1.mts",
	flags = "place_center_x,place_center_z",
	rotation = "random",
})

minetest.register_decoration({
	name = "ethereal:large_sakura_tree",
	deco_type = "schematic",
	place_on = "ethereal:bamboo_dirt",
	sidelen = 80,
	fill_ratio = 0.000285,
	biomes = {"sakura"},
	y_min = 5,
	y_max = 31000,
	schematic = path.."cherry_tree_2.mts",
	flags = "place_center_x,place_center_z",
	replacements = {
		["cherry:cherry_tree"] = "ethereal:sakura_trunk",
		["cherry:cherry_leaves"] = "ethereal:sakura_leaves",
	},
	rotation = "random",
})

local did_sakura = minetest.get_decoration_id('ethereal:large_sakura_tree')
minetest.set_gen_notify('decoration',{ did_sakura })
did_sakura = 'decoration#' .. did_sakura

minetest.register_on_generated(function(minp, maxp)
	if maxp.y > 4 then
		--
		-- Sakura Tree - fix light
		--
		local gennotify = minetest.get_mapgen_object('gennotify')
		for _, pos in ipairs(gennotify[did_sakura] or {}) do
			minetest.after(0.2,function() minetest.fix_light(pos:offset(-9, -1, -9), pos:offset(9, 20, 9)) end)
		end
	end
end)

minetest.register_abm({
	label = "Sakura petals",
	nodenames = {"ethereal:sakura_leaves"},
	interval = 6,
	chance = 25,
	catch_up = false,
	action = function(pos)
		minetest.add_particlespawner({
			amount = 1,
			time = 1,
			minpos = {x = pos.x, y = pos.y, z = pos.z},
			maxpos = {x = pos.x, y = pos.y, z = pos.z},
			minvel = {x = -0.75, y = -0.4, z = -0.75},
			maxvel = {x = 0.75, y = -0.2, z = 0.75},
			minacc = {x = -0.2, y = -0.4, z = -0.2},
			maxacc = {x = 0.2, y = -0.1, z = 0.2},
			minexptime = 8,
			maxexptime = 10,
			minsize = 1.5,
			maxsize = 1.75,
			texture = "cherry_leaves_particul.png",
			collisiondetection = true,
			collision_removal = true,
			vertical = false,
		})
	end,
})

-- sakura tree
add_schem({"ethereal:bamboo_dirt"}, 0.001, {"sakura"}, 7, 31000,
	ethereal.sakura_tree, ethereal.sakura, nil,
	"ethereal:bamboo_dirt", 6)

-- redwood tree
add_schem({"default:dirt_with_dry_grass"}, 0.000625, {"mesa"}, 6, 31000,
	ethereal.redwood_tree, ethereal.mesa, nil,
	"default:dirt_with_dry_grass", 8)

-- banana tree
--[[add_schem({"ethereal:grove_dirt"}, 0.004, {"grove"}, 1, 100,
	ethereal.bananatree, ethereal.grove)]]

-- grove trees
for i,tree in ipairs({
	ethereal.bananatree,
	ethereal.orangetree,
	ethereal.lemontree,
}) do
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 16,
		place_on = {"ethereal:grove_dirt"},
		noise_params = {
			offset = -0.005,
			scale = 0.01125,
			spread = {x = 100, y = 20, z = 100},
			seed = 8888 - i,
			octaves = 1,
			persistence = 0.75,
			lacunarity = 0.9,
		},
		y_max = 31000,
		y_min = 5,
		biomes = {"grove"},
		schematic = tree,
	})
end

-- healing tree
--[[add_schem({"default:dirt_with_snow","default:ice","ethereal:crystal_grass"}, 0.01, {"taiga","frost","frost_floatland"}, 120, 140,
	ethereal.yellowtree, ethereal.alpine, nil, "default:dirt_with_snow", 8)]]

minetest.register_decoration({
	deco_type = "schematic",
	sidelen = 16,
	place_on = {"group:soil"},
	noise_params = {
		offset = -0.005,
		scale = 0.00875,
		spread = {x = 100, y = 20, z = 100},
		seed = 76,
		octaves = 1,
		persistence = 0.75,
		lacunarity = 0.9,
	},
	y_max = 31000,
	y_min = 48,
	biomes = {
		"frost",
		"taiga",
	},
	schematic = ethereal.yellowtree,
	flags = "place_center_x,place_center_z",
})

-- crystal frost tree
add_schem({"ethereal:crystal_dirt"}, 0.01, {"frost", "frost_floatland"}, 1, 1750,
	ethereal.frosttrees, ethereal.frost, nil,
	"ethereal:crystal_dirt", 8)

-- giant mushroom
add_schem("ethereal:mushroom_dirt", 0.02, {"mushroom"}, 1, 31000,
	ethereal.mushroomone, ethereal.mushroom, nil,
	"ethereal:mushroom_dirt", 8)

add_schem({"default:dirt_with_rainforest_litter"}, 0.000525, {"jumble"}, 1, 31000,
	ethereal.mushroomone, ethereal.jumble, nil,
	"default:dirt_with_rainforest_litter", 8)

-- small lava crater
add_schem("ethereal:fiery_dirt", 0.01, {"fiery"}, 1, 100,
	ethereal.volcanom, ethereal.fiery, nil, "ethereal:fiery_dirt", 8)

-- large lava crater
add_schem("ethereal:fiery_dirt", 0.003, {"fiery"}, 1, 100,
	ethereal.volcanol, ethereal.fiery, nil, "ethereal:fiery_dirt", 8, "random")

-- basandra bush
add_schem("ethereal:fiery_dirt", 0.03, {"fiery"}, 1, 100,
	ethereal.basandrabush, ethereal.fiery)

-- default jungle tree
add_schem({"ethereal:jungle_dirt", "default:dirt_with_rainforest_litter"},
	0.08, {"junglee"}, 1, 31000, dpath .. "jungle_tree.mts", ethereal.junglee)

-- special silver sand terrain for grayness which must be placed before trees
minetest.register_decoration({
	name = node,
	deco_type = "simple",
	sidelen = 16,
	place_on = {"ethereal:gray_dirt"},
	noise_params = {
		offset = -0.25,
		scale = 3,
		spread = {x = 100, y = 100, z = 100},
		seed = 666,
		octaves = 3,
		persist = 0.6,
		lacunarity = 1.2,
	},
	y_max = 31000,
	y_min = 1,
	biomes = {"grayness"},
	decoration = "default:silver_sand",
	place_offset_y = -1,
	flags = "force_placement",
})

-- willow tree
add_schem({"ethereal:gray_dirt"}, 0.015, {"grayness"}, 1, 31000,
	ethereal.willow, ethereal.grayness, nil,
	"ethereal:gray_dirt", 6)

-- small pine tree for shore elevation
add_schem({"ethereal:cold_dirt", "default:dirt_with_coniferous_litter"},
	0.0025, {"coniferous_forest"}, 3, 9, ethereal.pinetree, ethereal.snowy)

-- small pine tree for lower elevation
add_schem({"ethereal:cold_dirt", "default:dirt_with_coniferous_litter"},
	0.03, {"coniferous_forest"}, 10, 48, ethereal.pinetree, ethereal.snowy)

-- default large pine tree for lower elevation
add_schem({"ethereal:cold_dirt", "default:dirt_with_coniferous_litter"},
	0.01, {"coniferous_forest"}, 10, 48, dpath .. "pine_tree.mts", ethereal.snowy)

-- small pine for higher elevation
add_schem({"default:dirt_with_snow"}, 0.03, {"taiga"}, 48, 31000,
	ethereal.pinetree, ethereal.alpine)

-- default large pine for higher elevation
add_schem({"default:dirt_with_snow"}, 0.01, {"taiga"}, 48, 31000,
	dpath .. "pine_tree.mts", ethereal.alpine)

-- default apple tree
add_schem({"default:dirt_with_rainforest_litter"}, 0.001, {"jumble"}, 1, 31000,
	dpath .. "apple_tree.mts", ethereal.grassy, nil,
	"default:dirt_with_rainforest_litter", 6)

-- gaunt trees
add_schem({"default:dirt_with_grass"}, 0.000275, {"jumble"}, 1, 31000,
	path.."gaunt_tree_1.mts", ethereal.jumble, nil,
	{"default:dirt_with_grass"}, 5, nil, 1)

add_schem({"default:dirt_with_grass"}, 0.0005, {"jumble"}, 1, 31000,
	path.."gaunt_tree_2.mts", ethereal.jumble, nil,
	{"default:dirt_with_grass"}, 5, nil, 1)

add_schem({"default:dirt_with_grass"}, 0.0005, {"jumble"}, 1, 31000,
	path.."gaunt_tree_3.mts", ethereal.jumble, nil,
	{"default:dirt_with_grass"}, 5, nil, 1)

-- deciduous forest trees
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	place_offset_y = 0,
	sidelen = 16,
	fill_ratio = 0.0175,
	biomes = {"deciduous_forest"},
	y_max = 31000,
	y_min = 1,
	schematic = path.."meadow_tree_1.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	place_offset_y = 0,
	sidelen = 16,
	fill_ratio = 0.0025,
	biomes = {"deciduous_forest"},
	y_max = 31000,
	y_min = 1,
	schematic = path.."meadow_tree_2.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	place_offset_y = 0,
	sidelen = 16,
	fill_ratio = 0.00275,
	biomes = {"deciduous_forest"},
	y_max = 31000,
	y_min = 1,
	schematic = dpath.."apple_tree.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

-- big old tree
add_schem({"default:dirt_with_grass","default:dirt_with_rainforest_litter"}, 0.00225, {"jumble"}, 1, 31000,
	path.."overgrown_tree.mts", ethereal.jumble, nil,
	"default:dirt_with_rainforest_litter", 6, nil, 1)

add_schem({"default:dirt_with_grass","default:dirt_with_rainforest_litter"}, 0.00275, {"jumble"}, 1, 31000,
	ethereal.bigtree, ethereal.jumble, nil,
	"default:dirt_with_rainforest_litter", 6, nil, 1)

-- default aspen tree
add_schem({"default:dirt_with_grass"}, 0.0025, {"grassytwo"}, 1, 50,
	dpath .. "aspen_tree.mts", ethereal.grassy)

-- birch tree
add_schem({"default:dirt_with_grass"}, 0.0025, {"grassytwo"}, 51, 31000,
	ethereal.birchtree, ethereal.grassytwo)

-- orange tree
add_schem({"ethereal:prairie_dirt"}, 0.01, {"prairie"}, 1, 100,
	ethereal.orangetree, ethereal.prairie)

-- default acacia tree
--[[add_schem({"default:dry_dirt_with_dry_grass",
	"default:dirt_with_dry_grass"}, 0.004, {"savanna"}, 1, 100,
	dpath .. "acacia_tree.mts", ethereal.savanna)]]

-- palm tree
add_schem("default:sand", 0.0025, {"desert_ocean", "plains_ocean", "sandclay",
	"sandstone_ocean", "mesa_ocean", "grove_ocean", "deciduous_forest_ocean"}, 1, 1,
	ethereal.palmtree, 0)

-- bamboo tree
add_schem({"ethereal:bamboo_dirt"}, 0.0025, {"sakura"}, 1, 31000,
	ethereal.bambootree, ethereal.sakura)

-- bush
add_schem({"ethereal:bamboo_dirt"}, 0.08, {"bamboo"}, 1, 100, ethereal.bush,
	ethereal.bamboo)

-- vine tree
add_schem({"default:dirt_with_grass"}, 0.0175, {"swamp"}, 1, 31000,
	ethereal.vinetree, ethereal.swamp)

-- lemon tree
add_schem({"ethereal:grove_dirt"}, 0.002, {"mediterranean"}, 5, 50,
	ethereal.lemontree, ethereal.mediterranean)

-- olive tree
add_schem({"ethereal:grove_dirt"}, 0.002, {"mediterranean"}, 5, 35,
	ethereal.olivetree, ethereal.mediterranean)


-- default large cactus
if ethereal.desert == 1 then

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {
			"default:desert_sand",
			"default:sand",
		},
		sidelen = 80,
		noise_params = {
			offset = -0.0001,
			scale = 0.0005,
			spread = {x = 100, y = 100, z = 100},
			seed = 230,
			octaves = 1,
			persist = 0.6
		},
		biomes = {
			"desert",
			"sandstone",
		},
		y_min = 5,
		y_max = 31000,
		schematic = dpath .. "large_cactus.mts",
		flags = "place_center_x",
		rotation = "random",
	})
end


-- default bush
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass", "default:dirt_with_snow"},
	sidelen = 16,
	noise_params = {
		offset = -0.004,
		scale = 0.01,
		spread = {x = 100, y = 100, z = 100},
		seed = 137,
		octaves = 3,
		persist = 0.7,
	},
	biomes = {"deciduous_forest", "grassytwo"},
	y_min = 1,
	y_max = 31000,
	schematic = dpath .. "bush.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random"
})

-- extra bushes for jumble biome
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_rainforest_litter"},
	spawn_by = "default:dirt_with_rainforest_litter",
	num_spawn_by = 3,
	sidelen = 16,
	noise_params = {
		offset = 0.0125,
		scale = 0.01,
		spread = {x = 100, y = 100, z = 100},
		seed = 34343,
		octaves = 2,
		persist = 0.6,
	},
	biomes = {"jumble"},
	y_min = 1,
	y_max = 31000,
	schematic = dpath .. "bush.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random"
})

-- default tropical bush
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"ethereal:grove_dirt", "default:dirt_with_rainforest_litter"},
	replacements = {["default:bush_leaves"] = "default:jungleleaves"},
	--sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.01,
		spread = {x = 100, y = 100, z = 100},
		seed = 137,
		octaves = 3,
		persist = 0.5
	},
	biomes = {"grove", "junglee"},
	y_min = 1,
	y_max = 31000,
	schematic = dpath .. "bush.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random"
})


-- default acacia bush
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {
		"default:dirt_with_dry_grass",
		"default:dry_dirt_with_dry_grass",
		"naturalbiomes:savannalitter"
	},
	sidelen = 16,
	noise_params = {
		offset = -0.00525,
		scale = 0.0125,
		spread = {x = 7, y = 7, z = 7},
		seed = 90155,
		octaves = 2,
		persist = 0.8,
		lacunarity = 1.5,
	},
	biomes = {"mesa","savanna"},
	y_min = 1,
	y_max = 31000,
	schematic = dpath .. "acacia_bush.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random"
})


-- default pine bush
if minetest.registered_nodes["default:pine_bush"] then

	minetest.register_decoration({
		name = "default:pine_bush",
		deco_type = "schematic",
		place_on = {"default:dirt_with_snow"},
		sidelen = 16,
		noise_params = {
			offset = -0.004,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 137,
			octaves = 3,
			persist = 0.7,
		},
		biomes = {"taiga"},
		y_max = 31000,
		y_min = 4,
		schematic = dpath .. "pine_bush.mts",
		flags = "place_center_x, place_center_z"
	})
end


-- default blueberry bush
if minetest.registered_nodes["default:blueberry_bush_leaves"] then

	minetest.register_decoration({
		name = "default:blueberry_bush",
		deco_type = "schematic",
		place_on = {
			"default:dirt_with_coniferous_litter", "default:dirt_with_snow", "ethereal:grove_dirt"},
		sidelen = 16,
		fill_ratio = 0.00075,
		biomes = {"coniferous_forest", "taiga", "grove"},
		y_max = 31000,
		y_min = 1,
		place_offset_y = 1,
		schematic = dpath .. "blueberry_bush.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random"
	})
end


-- place waterlily in beach areas
local sandy_biomes = {}
local desert_biomes = {
	desert = true,
	sandstone = true,
	desert_shore = true,
	sandstone_shore = true,
	desert_below = true,
	sandstone_below = true,
}
for biome,def in pairs(asuna.biomes) do
	if def.shore == "default:sand" and
		(def.ocean == "temperate" or def.ocean == "tropical") and
		not desert_biomes[biome]
	then
		table.insert(sandy_biomes,biome)
	end
end

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:sand"},
	sidelen = 16,
	noise_params = {
		offset = -0.12,
		scale = 0.3,
		spread = {x = 200, y = 200, z = 200},
		seed = 33,
		octaves = 3,
		persist = 0.7
	},
	biomes = sandy_biomes,
	y_min = 0,
	y_max = 0,
	schematic = ethereal.waterlily,
	rotation = "random"
})


-- coral reef
if ethereal.reefs == 1 then

	-- override corals so crystal shovel can pick them up intact
	minetest.override_item("default:coral_skeleton", {groups = {crumbly = 3}})
	minetest.override_item("default:coral_orange", {groups = {crumbly = 3}})
	minetest.override_item("default:coral_brown", {groups = {crumbly = 3}})

	--[[minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		noise_params = {
			offset = -0.15,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 7013,
			octaves = 3,
			persist = 1,
		},
		biomes = {"desert_ocean", "grove_ocean"},
		y_min = -8,
		y_max = -2,
		schematic = path .. "corals.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random"
	})]]
end


-- tree logs
if ethereal.logs == 1 then

if ethereal.grassy == 1 or ethereal.prairie == 1 then
minetest.register_decoration({
		name = "default:apple_log",
		deco_type = "schematic",
		place_on = {"default:dirt_with_grass", "ethereal:prairie_dirt"},
		place_offset_y = 1,
		sidelen = 16,
		fill_ratio = 0.001,
		biomes = {"deciduous_forest", "jumble", "swamp", "prairie"},
		y_max = 100,
		y_min = 1,
		schematic = dpath .. "apple_log.mts",
		flags = "place_center_x",
		rotation = "random",
		spawn_by = {"default:dirt_with_grass", "ethereal:prairie_dirt"},
		num_spawn_by = 8
	})
end

if ethereal.junglee == 1 then
	minetest.register_decoration({
		name = "default:jungle_log",
		deco_type = "schematic",
		place_on = {"default:dirt_with_rainforest_litter"},
		place_offset_y = 1,
		sidelen = 80,
		fill_ratio = 0.005,
		biomes = {"junglee"},
		y_max = 100,
		y_min = 1,
		schematic = dpath .. "jungle_log.mts",
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "default:dirt_with_rainforest_litter",
		num_spawn_by = 8
	})
end

if ethereal.snowy == 1 then
	minetest.register_decoration({
		name = "default:pine_log",
		deco_type = "schematic",
		place_on = {"default:dirt_with_snow", "default:dirt_with_coniferous_litter"},
		place_offset_y = 1,
		sidelen = 80,
		fill_ratio = 0.0018,
		biomes = {"taiga", "coniferous_forest"},
		y_max = 100,
		y_min = 4,
		schematic = dpath .. "pine_log.mts",
		flags = "place_center_x",
		rotation = "random",
		spawn_by = {"default:dirt_with_snow", "default:dirt_with_coniferous_litter"},
		num_spawn_by = 8
	})
end

if ethereal.savanna == 1 then
	minetest.register_decoration({
		name = "default:acacia_log",
		deco_type = "schematic",
		place_on = {"default:dry_dirt_with_dry_grass"},
		place_offset_y = 1,
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.001,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"savanna"},
		y_max = 100,
		y_min = 1,
		schematic = dpath .. "acacia_log.mts",
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "default:dry_dirt_with_dry_grass",
		num_spawn_by = 8
	})
end

if ethereal.plains == 1 then
	minetest.register_decoration({
		name = "ethereal:scorched_log",
		deco_type = "schematic",
		place_on = {"ethereal:dry_dirt"},
		place_offset_y = 1,
		sidelen = 80,
		fill_ratio = 0.0018,
		biomes = {"plains"},
		y_max = 100,
		y_min = 4,

		schematic = {
			size = {x = 3, y = 1, z = 1},
			data = {
				{name = "ethereal:scorched_tree", param1 = 201, param2 = 16},
				{name = "ethereal:scorched_tree", param1 = 255, param2 = 16},
				{name = "ethereal:scorched_tree", param1 = 255, param2 = 16}
			}
		},
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "ethereal:dry_dirt",
		num_spawn_by = 8
	})
end

if ethereal.grove == 1 then
	minetest.register_decoration({
		name = "ethereal:banana_log",
		deco_type = "schematic",
		place_on = {"ethereal:grove_dirt"},
		place_offset_y = 1,
		sidelen = 80,
		fill_ratio = 0.0018,
		biomes = {"grove"},
		y_max = 100,
		y_min = 4,

		schematic = {
			size = {x = 3, y = 1, z = 1},
			data = {
				{name = "ethereal:banana_trunk", param1 = 255, param2 = 16},
				{name = "ethereal:banana_trunk", param1 = 255, param2 = 16},
				{name = "ethereal:banana_trunk", param1 = 201, param2 = 16}
			}
		},
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "ethereal:grove_dirt",
		num_spawn_by = 8
	})
end

end

