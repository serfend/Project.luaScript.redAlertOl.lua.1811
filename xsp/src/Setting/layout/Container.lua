--@summary:实现正常索引
Container={}
function Container:new(o)
	o=o or {}
	o.Index={}--Control.Name:Control索引
	o.List={}--ControlList
	return setmetatable(o,{__index=Container})
end

function Container:Add(name,ui)
	if self[name] then
		dialog("控件管理异常,请联系作者\nException.Container.Add()name="..name)
		return false
	else
		self[name]=ui
		table.insert(self.List,ui)
		return true
	end
end
function Container:Count()
	return #self.List
end
function Container:Clear()
	self.List={}
end