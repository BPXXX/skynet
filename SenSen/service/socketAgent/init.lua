local skynet    = require "skynet"
local socket    = require "skynet.socket"
local websocket = require "http.websocket"
function echo(cID, addr)
    local protocol = "ws"

    local url = string.format("%s://127.0.0.1:8001", protocol)
    local ws_id = websocket.connect(url)
    while true do
        local msg = "hello world!"
        websocket.write(ws_id, msg)
        print(">: " .. msg)
        local resp, close_reason = websocket.read(ws_id)
        print("<: " .. (resp and resp or "[Close] " .. close_reason))
        if not resp then
            print("echo server close.")
            break
        end
       -- websocket.ping(ws_id)
        skynet.sleep(100)
    end
    --socket.start(cID)
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

local cID, addr = ...
cID = tonumber(cID)


local function send_package(pack)
	socket.write(cID, package)
end

skynet.start(function()
    skynet.fork(function()
        echo(cID, addr)
        skynet.exit()
    end)
end)