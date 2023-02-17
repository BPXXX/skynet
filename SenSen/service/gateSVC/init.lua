local skynet = require "skynet"
local socket = require "skynet.socket"
local websocket = require "websocket"
local httpd = require "http.httpd"
local urllib = require "http.url"
local sockethelper = require "http.sockethelper"
local s = require "service"
local cjson = require"cjson"
local cjson2 = cjson.new()
local handler = {}
function handler.on_open(ws)
    print(string.format("%d::open", ws.id))
end

function handler.on_message(ws, message)
    print(string.format("%d receive:%s", ws.id, message))
    local msg = s.gate_getMapList()
    ws:send_text(cjson2.encode(msg))
    ws:close()
end

function handler.on_close(ws, code, reason)
    print(string.format("%d close:%s  %s", ws.id, code, reason))
end

local function handle_socket(id)
    -- limit request body size to 8192 (you can pass nil to unlimit)
    
    local code, url, method, header, body = httpd.read_request(sockethelper.readfunc(id), 8192)
    if(header == nil) then 
        print(string.format("handle_socket :header is nil"))
    end
    if code then
        
        if header.upgrade == "websocket" then
            local ws = websocket.new(id, header, handler)
            ws:start()
        end
    end


end

s.init = function ()
    local address = "0.0.0.0:8001"
    skynet.error("Listening "..address)
    local id = assert(socket.listen(address))
    socket.start(id , function(id, addr)
       socket.start(id)
       pcall(handle_socket, id)
    end)
end


---------------------------------------------------------------------------------------------
--------------------------------------Cluster Calls------------------------------------------
---------------------------------------------------------------------------------------------
s.gate_getMapList = function ()
    return s.call("dsContainer","dsMgr1","get_room_list")
end


s.start(...)
