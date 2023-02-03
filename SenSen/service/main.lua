local skynet = require "skynet"
local cluster = require "skynet.cluster"
require "skynet.manager"
skynet.start(function()
	skynet.error("[start main] hello world")
	
		-- 集群配置
        cluster.reload({
            gate = "127.0.0.1:7001",
            dsContainer = "127.0.0.1:7002",
        })

        local mynode = skynet.getenv("node")
        if "gate" == mynode then
            -- 启动集群节点
            cluster.open("gate")
            -- gate节点，开启gate服务
            local gateService1 = skynet.newservice("gateService", "gateService", 1)
            skynet.name("gateService1", gateService1)

        elseif "dsContainer" == mynode then
            -- 启动集群节点
            cluster.open("dsContainer")
            -- dsContainer
            local dsMgr1 = skynet.newservice("dsMgr", "dsMgr", 1)
            skynet.name("dsMgr1", dsMgr1)
        end
	skynet.exit()
end)
