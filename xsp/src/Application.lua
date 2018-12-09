Application={
	version="0.1.1",
	updateDate="2018-12-8 20:21",
	author="serfend",
	groupQQ="489518369",
	UpdateInfo={
		"",
		"测试版本发布"
	},
	ProcessInfo={
		
	}
}
function Application:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Application:DeviceID()
	local lastID=storage.get("client.ID","")
	if lastID=="" then
		lastID=self:GenerateId()
		storage.put("client.ID",lastID)
	end
	return lastID
end
local alphabet = "0123456789abcdefghijklmnopqrstuvwxyz"
function Application:GenerateId()
	local len=string.len(alphabet)
	local tmp=StringBuilder:new()
	for i=1,16 do
		local index=math.floor(math.random()*len)+1
		tmp:Append(string.sub(alphabet,index,index))
	end
	return tmp:ToString()
end