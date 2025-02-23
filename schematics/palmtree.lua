
local _ = {name = "air", param = 0}
local L = {name = "ethereal:palmleaves", param = 255}
local l = {name = "ethereal:palmleaves", param = 191}
local T = {name = "ethereal:palm_trunk", param = 255}
local t = {name = "ethereal:palm_trunk", param = 191}
local M = {name = "ethereal:palm_trunk", param = 255, force_place = true}
local C = {name = "ethereal:coconut", param = 127, prob = 80}

ethereal.palmtree = {

	size = {x = 9, y = 11, z = 9},

	yslice_prob = {
		{ypos = 3, prob = 127}
	},

	data = {

	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,

	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,l,_,_,_,
	_,_,_,_,_,L,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,

	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,L,_,L,_,L,_,
	_,_,_,_,_,L,_,_,_,
	_,_,_,_,_,_,_,_,_,

	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,C,_,_,_,
	_,_,_,_,L,L,L,_,_,
	_,_,_,_,_,_,_,_,_,

	_,_,_,_,M,_,_,_,_,
	_,_,_,_,M,_,_,_,_,
	_,_,_,_,M,_,_,_,_,
	_,_,_,_,M,_,_,_,_,
	_,_,_,_,M,_,_,_,_,
	_,_,_,_,T,t,_,_,_,
	_,_,_,_,_,T,_,_,_,
	_,_,l,_,_,T,_,_,l,
	_,_,L,L,C,T,C,L,L,
	_,_,_,L,L,L,L,L,_,
	_,_,_,_,_,L,_,_,_,

	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,C,_,_,_,
	_,_,_,_,L,L,L,_,_,
	_,_,_,_,_,_,_,_,_,

	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,L,_,L,_,L,_,
	_,_,_,_,_,L,_,_,_,
	_,_,_,_,_,_,_,_,_,

	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,l,_,_,_,
	_,_,_,_,_,L,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,

	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,
	_,_,_,_,_,_,_,_,_,

	}
}
