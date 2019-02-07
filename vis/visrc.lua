-- load standard vis module, providing parts of the Lua API
require('vis')
require("vis-commentary")
require('surround')
require('backup')
require('pairs')

plugin_vis_open =require('fzf-open')

-- Path to the fzf executable (default: "fzf")
plugin_vis_open.fzf_path = "fzf"

-- Arguments passed to fzf (defaul: "")
 plugin_vis_open.fzf_args = "-q '!.class '"

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	-- Your per window configuration options e.g.
	-- vis:command('set number')
    vis:command('set numbers on')
    vis:command('set relativenumbers off')
    vis:command('set cursorline on')
    vis:command('set show-newlines on')
    vis:command('set show-tabs on')
    vis:command('set show-spaces off')
    vis:command('set tabwidth 4')
    vis:command('set expandtab on')
    vis:command('set autoindent on')
    vis:command('set theme dark-16')

end)
