
local skynet = require "skynet"
if _VERSION ~= "Lua 5.4" then
	error "Use lua 5.4"
end

local socket = require "client.socket"
local proto = require "proto"
local sproto = require "sproto"

local host = sproto.new(proto.s2c):host "package"
local request = host:attach(sproto.new(proto.c2s))

local fd = assert(socket.connect("127.0.0.1", 8001))

skynet.start(function()
   
	skynet.error("testClient Init")
    local cmd = "TestTest"
	socket.send(fd, cmd)
	skynet.exit()
end)


