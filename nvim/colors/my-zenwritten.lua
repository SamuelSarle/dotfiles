local colors_name = "my-zenwritten"
vim.g.colors_name = colors_name -- Required when defining a colorscheme

local lush = require("lush")
local hsluv = lush.hsluv -- Human-friendly hsl
local util = require("zenbones.util")

local bg = vim.o.background

-- Define a palette. Use `palette_extend` to fill unspecified colors
local palette
if bg == "light" then
	palette = util.palette_extend({
		fg = hsluv(0, 0, 0),
	}, bg)
else
	palette = util.palette_extend({
		fg = hsluv(0, 0, 100),
	}, bg)
end

-- Generate the lush specs using the generator util
local generator = require("zenbones.specs")
local specs = generator.generate(palette, bg, generator.get_global_config("zenwritten", bg))

-- Optionally extend specs using Lush
specs = lush.extends({ specs }).with(function()
	return {
		NormalFloat({ specs.Normal }),
	}
end)

-- Pass the specs to lush to apply
lush(specs)

-- Optionally set term colors
require("zenbones.term").apply_colors(palette)
