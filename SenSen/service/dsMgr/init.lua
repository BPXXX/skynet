local skynet = require "skynet"
local roomType = require"enums".ERoomType
local s = require "service"

s.money = 0
s.isworking = false
s.dsMap = {
    Room1 = {
        roomType = roomType.RType_Commercial,
        roomName = "RoomName",
        ipAddr = "127.0.0.1",
        maxPlayer = 100,
        curPlayer = 1
    }
    ,    
    Room2 = {
        roomType = roomType.RType_Commercial,
        roomName = "RoomName",
        ipAddr = "127.0.0.1",
        maxPlayer = 100,
        curPlayer = 1
    },
    Room3 = {
        roomType = roomType.RType_Commercial,
        roomName = "RoomName",
        ipAddr = "127.0.0.1",
        maxPlayer = 100,
        curPlayer = 1
    }
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