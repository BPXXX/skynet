local skynet = require "skynet"
skynet.start(function()
	skynet.error("[start main] hello world")
	
	local worker1 = skynet.newservice("worker", "worker", 1)
    -- 开始工作
    skynet.send(worker1, "lua", "start_work")
	-- 主服务休息2秒，注意，这里是主服务休息2秒，并不会卡住worker服务
    skynet.sleep(200)
    -- 停止工作
    skynet.send(worker1, "lua", "stop_work")

	
	skynet.exit()
end)
