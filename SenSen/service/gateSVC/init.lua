local skynet = require "skynet"
local socket    = require "skynet.socket"
local cluster = require "skynet.cluster"
require "skynet.manager"
local s = require "service"

s.money = 0
s.isworking = false
function accept(cID, addr)
    skynet.error(addr .. " accepted")
    skynet.newservice("socketAgent", cID, addr)
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

    s.resp.get_ds_addr(1)
end


s.resp.get_ds_addr = function(type)
	print(cluster.call("dsContainer", "dsMgr1", "get_ds_addr", "type"))
end

s.start(...)