
local skynet = require "skynet"
if _VERSION ~= "Lua 5.4" then
	error "Use lua 5.4"
end

local socket = require "client.socket"


local fd = assert(socket.connect("127.0.0.1", 8001))

skynet.start(function()
   
	skynet.error("testClient Init")
    skynet.fork(function()
        TickRecv()
    end)
    local cmd = "TestTest"
	socket.send(fd, cmd)
	skynet.exit()
end)

function TickRecv()
    while true do
        local r = socket.recv(fd)
    
        if not r then
            return 
        end
        if r == "" then
            error "Server closed"
            return 
        end
        skynet.error("recv " ..r)
    end
end

