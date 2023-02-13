
local skynet = require "skynet"
if _VERSION ~= "Lua 5.4" then
	error "Use lua 5.4"
end

local socket = require "client.socket"


local fd = assert(socket.connect("127.0.0.1", 8001))


local function TickRecv()
    while true do
        local r = socket.recv(fd)
        if not r then
            skynet.error("recv error" )
        end
        if r == "" then
            error "Server closed"
        end
        skynet.error("recv " ..r)
    end
end

skynet.start(function()

	skynet.error("testClient Init")
    skynet.fork(TickRecv)
    local cmd = "testtest"
	socket.send(fd, cmd)
	skynet.exit()
end)