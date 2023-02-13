local skynet = require "skynet"
local socket    = require "skynet.socket"
local cluster = require "skynet.cluster"
require "skynet.manager"
local s = require "service"
local gateAddr = "0.0.0.0:8001"
local Agent = {};
s.money = 0
s.isworking = false
s.WSAgent  = nil
function on_connected(fd, addr)
    skynet.error("Gate:  "..addr .. " accepted")
    if (Agent[fd] == nil) then
        Agent[fd] = skynet.newservice("socketAgent", fd, addr)
        skynet.call(Agent[fd], "lua", "Echo", { cAddr = addr ,ws_id = fd})
    end 
end

s.update = function(frame)
end

s.init = function ()
   -- skynet.fork(s.timer)
    skynet.error("Gate Service Init!")
    -- 监听8001端口

    skynet.error("listen " .. gateAddr)
    local lID = socket.listen(gateAddr)
    assert(lID)
    socket.start(lID, on_connected)
end


s.resp.get_ds_addr = function(type)
	print( s.call("dsContainer", "dsMgr1", "get_ds_addr", type))
end

s.start(...)