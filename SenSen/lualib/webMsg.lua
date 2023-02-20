local tbl = {}
local cjson = require"cjson"
local cjson2 = cjson.new()
tbl.MakeWebMsg = function(...)

    local type,body = ...
    local ret = {}
    ret.msgType = type
    ret.msgBody = body
    local jsonStr = cjson2.encode(ret)
    return jsonStr
end

return tbl