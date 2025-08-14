local memprof = require("mymemprof.parse")
local process = require("mymemprof.process")
local view = require("mymemprof.humanize")
local evread = require("utils.evread")

print('Start parsing')

local events, symbols = evread(memprof.parse, "mp1G.bin")
local config = {
    leak_only = false,
    human_readable = true,
}

--require('lua-debug-helper').run()

view.profile_info(events, config)

local dheap = process.form_heap_delta(events)
view.leak_info(dheap, config)
view.aliases(symbols)
-- XXX: The second argument is required to properly close Lua
-- universe (i.e. invoke <lua_close> before exiting).
os.exit(0, true)
