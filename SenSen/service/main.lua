local skynet = require "skynet"
local cluster = require "skynet.cluster"
require "skynet.manager"
skynet.start(function()
    local mynode = skynet.getenv("node")
	skynet.error("[start main] hello world"..mynode)
	
		-- 集群配置
        cluster.reload({
            gate = "127.0.0.1:7575",
            dsContainer = "127.0.0.1:7576",
        })


        if "gate" == mynode then
            -- 启动集群节点
            cluster.open("gate")
            -- gate节点，开启gate服务
            local gateSVC1 = skynet.newservice("gateSVC", "gateSVC", 1)
            skynet.name("gateSVC1", gateSVC1)

        elseif "dsContainer" == mynode then
            -- 启动集群节点
            cluster.open("dsContainer")
            -- dsContainer
            local dsMgr1 = skynet.newservice("dsMgr", "dsMgr", 1)
            skynet.name("dsMgr1", dsMgr1)
        end
	skynet.exit()
end)
