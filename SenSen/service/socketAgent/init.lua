local skynet    = require "skynet"
local socket    = require "skynet.socket"
function echo(cID, addr)
    socket.start(cID)
    while true do
        local str = socket.read(cID)
        if str then
            skynet.error("recv " ..str)
            socket.write(cID, string.upper(str))  
        else
            socket.close(cID)
            skynet.error(addr .. " disconnect")
            return
        end
    end
end

local cID, addr = ...
cID = tonumber(cID)


local function send_package(pack)
	socket.write(cID, package)
end

skynet.start(function()
    skynet.fork(function()
        echo(cID, addr)
        skynet.exit()
    end)
end)