Splash = {
	nowState=0,
}--初始化
function Splash:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
--summary:掉线重连
function Splash:CheckIfDisconnect()
	
end

--summary:登录过程中的活动/公告界面
function Splash:CheckIfAnyNoticeForm()

end

function Splash:Login()
	
end