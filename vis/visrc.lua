-- load standard vis module, providing parts of the Lua API
require('vis')

--require('surround')                  -- https://repo.or.cz/vis-surround.git
--require('pairs')                     -- https://repo.or.cz/vis-pairs.git
--backup = require('backup')           -- https://github.com/roguh/vis-backup

local plugins = {
	['https://github.com/lutobler/vis-commentary.git'] = 'vis-commentary',
	['https://github.com/guillaumecherel/vis-fzf-open.git'] = 'vis-fzf-open',
	['https://gitlab.com/mcepl/vis-jump.git'] = 'vis-jump',
}

require('plugins/vis-plug').init(plugins)

--vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
--end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	-- Your per window configuration options e.g.
	vis:command('set number on')
	vis:command('set relativenumbers on')
	vis:command('set cursorline on')
	vis:command('set show-newlines on')
	vis:command('set show-tabs on')
	vis:command('set show-spaces off')
	vis:command('set show-eof on')
	vis:command('set tabwidth 8')
	vis:command('set expandtab off')
	vis:command('set autoindent on')
	vis:command('set theme dark-16')
	--vis:command('set theme light-16')

	-- TODO add shortcut for fzf file opening and line searching
	-- vis:map(vis.modes.NORMAL, "abc", )

	-- TODO remove trailing whitespace before writing to disk
	--vis.events.subscribe(vis.events.FILE_SAVE_PRE, function(file, path)
--	    return true
--	end)
end)

