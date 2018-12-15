--@summary:绑定当前所有的ui到布局中,
--		   可将布局置于不同的uilist以实现布局绑定多个控件组
--@param layout.Container uilist:控件容器
function UIHandle:ControlsBind(uilist)	
	for i,v in ipairs(uilist.List) do
		if not v[1].Controls then--非layout
			if v[2] then--控件是独立于此layout的
				table.insert(uilist.layout.Controls,v[1])
			else
				uilist.layout:Add(v[1])
			end
		end
	end
end

--@summary:显示当前对话框
function UIHandle:Dialog_Show(uilist)
	
	uilist.layout:Show()
	while self.anyUIShow do
		sleep(10)
		if uilist.layout:Refresh() then
			break
		end
	end
	self:CloseContext()
	uilist.layout:Close()
	uilist={}
end
function UIHandle:SynSetting(path,value)
	local tmp=split(path,".")--设置.子设置.子子设置
	local rawSet=_G
	for j=1,#tmp-1 do
		rawSet=rawSet[tmp[j]]
	end
	local checkNumber=tonumber(tmp[#tmp])--判断最后一项是否为数字
	if checkNumber then
		rawSet[checkNumber]=value
	else
		rawSet[tmp[#tmp]]=value
	end
end

local instanceCount=0
--@summary:创建一个按钮
--@param layout.Container:控件容器
function UIHandle:BuildButton(uilist,callback,color,caption)
	instanceCount=instanceCount+1
	local id="Btn"..instanceCount
	local button=UI_Button:new()
	button:Init(id,uilist.layout.context,Context.BtnNormal,color)
	button:SetText(caption)
	if callback then
		button:OnClick(
			function(id,action)
				callback(uilist)
			end
		)
	end
	uilist:Add(id,button)
	return button
end