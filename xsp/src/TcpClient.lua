TcpClient = {
	connectted=false,
	socket = require("bblibs.socket.socket"),
	host = '111.225.9.87',
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
	local bb = require("badboy")
	self.json = bb.getJSON()
	self.sock=self.socket.connect(self.host, 16555) 
	if self.sock then
		ShowInfo.RunningInfo("联机成功")
		self.sock:settimeout(0)
		self.connectted=true
		self:send({
			Title="rpClientConnect",
			Type="androidPay",
			Version="1.0.0",
			DeviceId=DeviceId(),
			Name="测试下单"
		})
	end
	return o
end
function TcpClient:send(info)
	if not self.connectted then return false end
	print("<jsonMsg>".. self.json.encode(info) .."</jsonMsg>")
	local index,msg=self.sock:send("<jsonMsg>".. self.json.encode(info) .."</jsonMsg>")
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
		local msg=infoChunk
		print("来自服务器:"..msg)
		self.msgCallBack(self.json.decode(msg))
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