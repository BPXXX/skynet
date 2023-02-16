local skynet = require "skynet"

local s = require "service"

s.money = 0
s.isworking = false
s.dsMap = {
    Room1 = {
        ipAddr = "127.0.0.1",
        maxPlayer = 100,
    }
    ,    
    Room2 = {
        ipAddr = "127.0.0.1",
        maxPlayer = 100,
    },
    Room3 = {
        ipAddr = "127.0.0.1",
        maxPlayer = 100,
    },
    Room4 = {
        ipAddr = "127.0.0.1",
        maxPlayer = 100,
    },
    Room5 = {
        ipAddr = "127.0.0.1",
        maxPlayer = 100,
    },
    Room6 = {
        ipAddr = "127.0.0.1",
        maxPlayer = 100,
    },
}
s.update = function(frame)
end

s.init = function ()
   -- skynet.fork(s.timer)
    skynet.error("dsContainer Service Init!")
end

s.resp.get_room_list = function ()
    return s.dsMap
end



s.start(...)