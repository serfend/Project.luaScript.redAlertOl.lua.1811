UI_Tab={
	_instanceCount=0
}

function UI_Tab:new(o)
	o = o or {}
	o.view=nil--控件的源视图，来自context:createView()
	o.parent=nil--所属布局
	o.nowX=0
	o.targetX=0
    return setmetatable(o, {__index=UI_Tab})
end
--@summary:初始化控件
--@param string id:对象id
--@param UIContext context:创建控件的布局源
--@param table pages:控件原始数据，加载正常的页面数据组
--@param table tabPageConfig:控件设置
--		int		.currentPage:初始页面位置
--		int		.pageWidth/pageHeight:页面大小
--		table	.tabTitles:标题栏图标
--		string		.title:标题内容
--		string		.icon:未选中时图标
--		string		.activeIcon:选中时图标
--@param Action<string,int>	callBack:当page选中发生变化时回调 id,pageIndex
function UI_Tab:Init(id,context,rawData,tabPageConfig,callBack)
	--归并所有pages尺寸
	local pageWidth=tabPageConfig.pageWidth or defaultSetting.pageWidth
	for i,k in ipairs(rawData) do
		k.style.width=pageWidth
	end
	
	self.view=wui.TabPage.createView(context, 
		{ pages = rawData, config = tabPageConfig }
	)
	
	
	
	local defaultSetting=wui.TabPage.style
	--滑块背景
	self.barLinerBack=UI_Label:new()
	self.barLinerBack:Init("barLinerBack",context,Context.LabelNormal)
	self.view:addSubview(self.barLinerBack.view)
	self.barLinerBack.view:setStyle({
		position="absolute",
		['background-color']="#ff00ff00",
		width=self.view:getStyle("width"),
		height=tabPageConfig.activeBottomHeight or defaultSetting.tabStyleDefault.activeBottomHeight,
		left=0,
		top=tabPageConfig.height or defaultSetting.tabStyleDefault.height
	})
	
	--前置滑块
	self.barLinerFront=UI_Label:new()
	self.barLinerFront:Init("barTest",context,Context.LabelNormal)
	self.view:addSubview(self.barLinerFront.view)
	
	
	self:OnSelect(function(id,page) 
		self:SwitchBarTo(page)
		if callBack then
			callBack(id,page)
		end
	end)
	local startPage=tabPageConfig.currentPage or 1
	self.barWidth=tabPageConfig.activeBottomWidth or defaultSetting.tabStyleDefault.activeBottomWidth
	self.barLinerFront.view:setStyle({
		position="absolute",
		['background-color']=tabPageConfig.activeBottomColor or defaultSetting.tabStyleDefault.activeBottomColor,
		width=self.barWidth,
		height=tabPageConfig.activeBottomHeight or defaultSetting.tabStyleDefault.activeBottomHeight,
		left=self.barWidth*(startPage-1),
		top=tabPageConfig.height or defaultSetting.tabStyleDefault.height,
	})
	--初始化标题索引
	self.tabTitle={}
	local titleView=self.view:getSubview(1)
	for i=1,#rawData do
		self.tabTitle[i]=titleView:getSubview(i)
	end
	
	--控制内容位置
	self.containerView=self.view:getSubview(2):getSubview(1)
	self.containerTargetX=0
	self.containerNowX=0
	self.containerWidth=pageWidth
	
	--初始化各页面索引
	self.page={}
	for i=1,#rawData do
		self.page[i]=self.containerView:getSubview(i)
	end
end
--@summary:更改当前bottomActiveBar位置
function UI_Tab:SwitchBarTo(pageIndex)
	self.barLinerFront.targetX=self.barWidth*(pageIndex-1)
	self.barLinerFront.AnimationComplete=false
	self.containerView:setStyle("left",self.containerNowX)
	self.containerTargetX=(pageIndex - 1) * (-1 * self.containerWidth)
	self.AnimationComplete=false
end

--@summary:刷新控件
--@return bool:是否要求布局结束
function UI_Tab:Refresh()
	if not self.barLinerFront.AnimationComplete then			
		local newMoveCheck= math.abs(self.barLinerFront.nowX-self.barLinerFront.targetX)>2
		if newMoveCheck then
			self.barLinerFront.nowX=self.barLinerFront.nowX*0.8+self.barLinerFront.targetX*0.2
		else
			self.barLinerFront.nowX=self.barLinerFront.targetX
			self.barLinerFront.AnimationComplete=true
		end
		self.barLinerFront.view:setStyle("left",self.barLinerFront.nowX)
	end
	if not self.AnimationComplete then
		local newMoveCheck= math.abs(self.containerNowX-self.containerTargetX)>2
		if newMoveCheck then
			self.containerNowX=self.containerNowX*0.8+self.containerTargetX*0.2
		else
			self.containerNowX=self.containerTargetX
			self.AnimationComplete=true
		end
		self.containerView:setStyle("left",self.containerNowX)
	end
	return false
end
--@summary:从布局中删除此控件
function UI_Tab:Delete()
	self.parent:Delete(self.view:getID())
end

--@summary:新增一个页面
function UI_Tab:AddPage(name,rawData)

		
end

--@summary:回调Tab被点击
function UI_Tab:OnSelect(callBack)
	wui.TabPage.setOnSelectedCallback(self.view, function (id, currentPage)
		callBack(id,currentPage)
	end)
end