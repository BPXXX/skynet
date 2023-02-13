local skynet = require "skynet"
local socket    = require "skynet.socket"
local cluster = require "skynet.cluster"
require "skynet.manager"
local s = require "service"

s.money = 0
s.isworking = false
s.WSAgent  = nil
function accept(cID, addr)
    skynet.error(addr .. " accepted")
    if (s.WSAgent == nil) then
        s.WSAgent = skynet.newservice("socketAgent", cID, addr)
    end 
end

s.update = function(frame)
end

s.init = function ()
   -- skynet.fork(s.timer)
    skynet.error("Gate Service Init!")
    -- 监听8001端口
    local addr = "0.0.0.0:8001"
    skynet.error("listen " .. addr)
    local lID = socket.listen(addr)
    assert(lID)
    socket.start(lID, accept)
end


s.resp.get_ds_addr = function(type)
	print( s.call("dsContainer", "dsMgr1", "get_ds_addr", type))
end

s.start(...)