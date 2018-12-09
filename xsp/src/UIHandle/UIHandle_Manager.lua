--@summary:绑定当前所有的ui到布局中,
--		   可将布局置于不同的uilist以实现布局绑定多个控件组
--@param layout.Container uilist:控件容器
function UIHandle:ControlsBind(uilist)
	for i,v in ipairs(uilist.List) do
		if not v.Controls then--非layout
			uilist.layout:Add(v)
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