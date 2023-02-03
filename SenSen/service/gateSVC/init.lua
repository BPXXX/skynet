local skynet = require "skynet"
local cluster = require "skynet.cluster"
require "skynet.manager"
local s = require "service"

s.money = 0
s.isworking = false

s.update = function(frame)
end

s.init = function ()
   -- skynet.fork(s.timer)
    skynet.error("Gate Service Init!")
    s.resp.get_ds_addr(1)
end


s.resp.get_ds_addr = function(type)
	print(cluster.call("dsContainer", "dsMgr1", "get_ds_addr", "type"))
end

s.start(...)