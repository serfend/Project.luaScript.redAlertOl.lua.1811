UI_Line={
	_instanceCount=0
}

function UI_Line:new(o)
	o = o or {}
	o.view=nil--控件的源视图，来自context:createView()
	o.parent=nil--所属布局
    return setmetatable(o, {__index=UI_Line})
end
function UI_Line:Init(context,left,width)
	local rawData=self:RawUI(left,width)
	self.view=context:createView(rawData)
end
--@summary:静态方式初始化
function UI_Line:RawUI(left,width)
	UI_Line._instanceCount=UI_Line._instanceCount+1
	Context.BrLine.id="brline"..UI_Line._instanceCount
	Context.BrLine.style.left=left
	Context.BrLine.style.width=width
	return Context.BrLine
end