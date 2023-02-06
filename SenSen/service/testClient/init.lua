
local skynet = require "skynet"
if _VERSION ~= "Lua 5.4" then
	error "Use lua 5.4"
end

local socket = require "client.socket"


local fd = assert(socket.connect("127.0.0.1", 8001))

skynet.start(function()
   
	skynet.error("testClient Init")
    local cmd = "TestTest"
	socket.send(fd, cmd)
	skynet.exit()
end)


