-- Load plugin modules in order.

function gh(repo) return 'https://github.com/' .. repo end

require 'plugins.guess-indent'
require 'plugins.gitsigns'
require 'plugins.which-key'
require 'plugins.tokyonight'
require 'plugins.todo-comments'
require 'plugins.mini'
require 'plugins.telescope'
require 'plugins.lspconfig'
require 'plugins.conform'
require 'plugins.blink-cmp'
require 'plugins.treesitter'

-- The following comments only work if you have downloaded the repo, not just copy pasted the
-- init.lua. If you want these files, they are in the repository, so you can just download them and
-- place them in the correct locations.

-- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
--
--  Here are some example plugins that I've included in the repository.
--  Uncomment any of the lines below to enable them (you will need to restart nvim).
--
-- require 'plugins.debug'
-- require 'plugins.indent_line'
-- require 'plugins.lint'
require 'plugins.oil'

-- vim: ts=2 sts=2 sw=2 et
