local skynet = require "skynet"

local s = require "service"

s.money = 0
s.isworking = false
s.dsMap = {
    
}
s.update = function(frame)
end

s.init = function ()
   -- skynet.fork(s.timer)
    skynet.error("dsContainer Service Init!")
end


s.resp.get_ds_addr = function(type)
    return true,"127.0.0.1:8888"
end


s.start(...)