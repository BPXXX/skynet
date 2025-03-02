local skynet    = require "skynet"
local socket    = require "skynet.socket"
local websocket = require "http.websocket"

local handle = {}
local CMD = {}
local Clients = {}
local cID, addr = ...
cID = tonumber(cID)

function handle.connect(id)
    print("ws connect from: " .. tostring(id))
end

function handle.handshake(id, header, url)
    local addr = websocket.addrinfo(id)
    print("ws handshake from: " .. tostring(id), "url", url, "addr:", addr)
    print("----header-----")
    for k,v in pairs(header) do
        print(k,v)
    end
    print("--------------")
end

function handle.message(id, msg, msg_type)
    assert(msg_type == "binary" or msg_type == "text")
    websocket.write(id, msg)
end

function handle.ping(id)
    print("ws ping from: " .. tostring(id) .. "\n")
end

function handle.pong(id)
    print("ws pong from: " .. tostring(id))
end

function handle.close(id, code, reason)
    print("ws close from: " .. tostring(id), code, reason)
end

function handle.error(id)
    print("ws error from: " .. tostring(id))
end


function echo(cID, addr)

end

function CMD.Accept (conf)
    if Clients[conf.ws_id] == nil then
        if conf.ws_id then
            local msg = "SocketAgent Server Accept!!"
            websocket.accept(conf.ws_id, handle,"ws") 
            local ok, err = websocket.accept(conf.ws_id, handle, "ws", conf.cAddr)
            if not ok then
                print(err)
            end
        else
            print("SocketAgent Accept Failed:ws_id is nil!")
        end
    end
end

function CMD.Echo (conf)
    if conf.ws_id then
        if Clients[conf.ws_id] then
            websocket.write(conf.ws_id,"Server Echo","ws")
        end
    end

end


local function send_package(pack)
	socket.write(cID, package)
end


skynet.start(function ()
	skynet.dispatch("lua", function(_,_, command, ...)
		skynet.trace()
		local f = CMD[command]
		skynet.ret(skynet.pack(f(...)))
	end)
end)
-- skynet.start(function()
--     skynet.fork(function()
--         echo(cID, addr)
--         skynet.exit()
--     end)
-- end)