--@summary:绑定当前所有的ui到布局中,可将布局置于不同的uilist以实现布局绑定多个控件组
--@param table uilist:
--	UI_Layout uilist.layout:布局
--  UI_IControl uilist.controls..:需要绑定的控件
function UIHandle:ControlsBind(uilist)
	for i,v in pairs(uilist) do
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
			self:CloseContext()
		end
	end
	self:CloseContext()
	uilist.layout:Close()
end
local instanceCount=0
function UIHandle:BuildButton(uilist,callback,color,caption)
	instanceCount=instanceCount+1
	local id="Btn"..instanceCount
	local button=UI_Button:new()
	button:Init(id,uilist.layout.context,Context.BtnNormal,color)
	button:SetText(caption)
	button:OnClick(
		function(id,action)
			callback(uilist)
		end
	)
	uilist[id]=button
	return button
end