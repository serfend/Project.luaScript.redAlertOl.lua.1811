TcpClient = {
	connectted=false,
	socket = require("bblibs.socket.socket"),
	host = '1s68948k74.imwork.net',
	msgCallBack=nil,
	listening=false
}--初始化
function TcpClient:showError()
	dialog("Tcp失败:"..self.msg)
	lua_exit()
end
function TcpClient:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
	self.sock=self.socket.connect(self.host, 16397) 
	if self.sock then
		self.sock:settimeout(0)
		self.connectted=true
	end
	return o
end
function TcpClient:send(title,info)
	if not self.connectted then return false end
	local index,msg=self.sock:send("<"..title..">"..encrypt:AesEncrypt(info).."</"..title..">#$%&'")
end
function TcpClient:close()
	if not self.connectted then return false end
	self.sock:close() 
	self.listening=false
end
function TcpClient:start()
	if not self.connectted then return false end
	self.listening=true
	self:newReceive()
end
function TcpClient:newReceive()
	local infoChunk,status=self:receiveOnce()
	if infoChunk and string.len(infoChunk)>0 and self.msgCallBack then 
		self.msgCallBack(infoChunk)
	end
	if self.listening then
		task.execTimer(500,function() self:newReceive() end)
	end
end
function TcpClient:receiveOnce()
	if not self.connectted then return false end
	local chunk, status, partial = self.sock:receive(1024)
	if status~="closed" then
		return chunk or partial
	else
		return nil
	end
end
function TcpClient:CheckEnd(data)
	return true
end
function TcpClient:HandleData(data)
	
end