--@summary:实现正常索引
Container={}
function Container:new(o)
	o=o or {}
	o.Index={}--Control.Name:Control索引
	o.List={}--ControlList
	return setmetatable(o,{__index=Container})
end
--@summary:将控件加入到uilist进行管理
--@param string		name:控件id
--@param UI			ui:控件实例
--@param bool		independent:独立于container外将需要手动加入到其他的view中
function Container:Add(name,ui,independent)
	if self[name] then
		dialog("控件管理异常,请联系作者\nException.Container.Add()name="..name)
		return false
	else
		self[name]=ui
		table.insert(self.List,{ui,independent})
		return true
	end
end
function Container:Count()
	return #self.List
end
function Container:Clear()
	self.List={}
end