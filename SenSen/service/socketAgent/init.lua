local skynet    = require "skynet"
local socket    = require "skynet.socket"
local websocket = require "http.websocket"

local handle = {}
local cID, addr = ...
cID = tonumber(cID)
function echo(cID, addr)

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

    skynet.start(function ()
        skynet.dispatch("lua", function (_,_, id, protocol, addr)
            local ok, err = websocket.accept(id, handle, protocol, addr)
            if not ok then
                print(err)
            end
        end)
    end)
    -- socket.start(cID)
    -- while true do
    --     local str = socket.read(cID)
    --     if str then
    --         skynet.error("recv " ..str)
    --         socket.write(cID, string.upper(str))  
    --     else
    --         socket.close(cID)
    --         skynet.error(addr .. " disconnect")
    --         return
    --     end
    -- end
end




local function send_package(pack)
	socket.write(cID, package)
end

skynet.start(function()
    skynet.fork(function()
        echo(cID, addr)
        skynet.exit()
    end)
end)