--@summary:设置的主界面
function UIHandle:SettingDialogShow(callBackOk,callBackCancel)
	local uilist=Container:new()
	
	
	uilist:Add("layout",UI_Layout:new())
	uilist.layout:Init(Context.rootSetting)
	local dialogHeight=math.floor(Global.size.height)
	local dialogWidth=math.floor(Global.size.width)
	uilist.layout:SetStyle(View.SetLayoutCenter(dialogWidth,dialogHeight))
	
	self:BuildConfirmButton(uilist,callBackOk,callBackCancel)
	self:BuildMenu(uilist)
	for i,k in ipairs(ShowSettingIndex) do
		uilist.tab.tabTitle[i]:getSubview(2):setAttr("value",translator:Get(k.Name,"en"))
		print("创建page:"..k.Name)
		self:IndexInput(uilist,uilist.tab.page[i],k,Setting,0,"Setting")
	end
	self:ControlsBind(uilist)
	self:Dialog_Show(uilist)
	
end

function UIHandle:BuildMenu(uilist)
	uilist:Add("tab",UI_Tab:new())
	uilist.tab:Init("mainTab",uilist.layout.context,Context.MainSetting,{
		currentPage=1,
		pageWidth=700,
		pageHeight=1000,
		tabTitles=Context.MainSettingTitle,
	},function(id,pageIndex) 
		
	end)
	uilist.tab.view:setStyle({
		top=100,
		left=25
	})
	
end
local containerCount=0
function UIHandle:NewTitle(uilist,parent,title,value,rank)
	--填入标题
	Context.InputDiv.subviews[1].value=translator:Get(title,"en")
	
	--本层级容器
	containerCount=containerCount+1
	local containerId="container"..containerCount
	uilist:Add(containerId,UI_Button:new(),true)
	uilist[containerId]:Init(nil,uilist.layout.context,Context.InputDiv)
	uilist[containerId]:Move(20*rank,nil,true)--初始化位置
	uilist[containerId].EnableAnimation=true
	parent:addSubview(uilist[containerId].view)	
	if type(value)=="table" then
		--升级标题为大标题
		uilist[containerId].view:setStyle({
			['flex-direction']="column",
--			['background-color']=string.format("#%06x",Color3B(35*rank,100+35*rank,50+50*rank):toInt())
		})
		uilist[containerId].view:getSubview(1):setStyle({
			['font-size']=45,
			color="#000000"
		})
		--table初始化为标题栏
		local titleLine=UI_Line:new()
		titleLine:Init(uilist.layout.context,20*rank,740-20*rank)--标题栏下为分割线
		uilist[containerId].view:addSubview(titleLine.view)
	end
	
	return uilist[containerId]
end

--@summary:在页面上添加值
--@param UI.Container 	uilist: uilist.layout.context目标上下文 
--@param UIView 	parent:目标容器
--@param string		title:标题
--@param var		value:值
--@param int 		rank:当前层级
--@param string 	path:当前路径
function UIHandle:BuildInput(uilist,parent,title,value,rank,path)
	if title=="Description" or not title then
		return
	end
	local container=self:NewTitle(uilist,parent,title,value,rank)
	--记录移除
--	local subviewRecorder={}
--	--控件折叠回调
--	container:OnClick(function(id,action)
--		if container.fold then
--			container:Navigate(nil,container.targetY+100)
--		else
--			container:Navigate(nil,container.targetY-100)
--		end
--		container.fold=not container.fold
--	end)
	
	local valueType=type(value)
	if valueType=="table" then--迭代
		for k,v in pairs(value) do
			local childTitle=""
			if type(v)=="table" then
				childTitle=v.Description or k
			else
				childTitle=k
			end
			self:BuildInput(uilist,container.view,childTitle,v,rank+1,path.."."..childTitle)
		end
	elseif valueType=="number" then--下拉选项框
		local t=UI_TextBox:new()
		t:Init(path,uilist.layout.context,Context.TextNormal)
		t.view:setAttr("value",value)
		container.view:addSubview(t.view)
	elseif valueType=="string"  then--文本框
		if value=="true" or value=="false" then
			local t=UI_CheckBok:new()
			t:Init(path,uilist.layout.context)
			t:OnClick(function(id, title, value, checked)
				self:SynSetting(id,checked)
			end)
			t:SetChecked(value=="true")
			container.view:addSubview(t.view)
		else
			local t=UI_TextBox:new()
			t:Init(path,uilist.layout.context,Context.TextNormal)
			t.view:setAttr("value",value)
			container.view:addSubview(t.view)
		end
	else
		local t=UI_TextBox:new()
		t:Init(path,uilist.layout.context,Context.TextNormal)
		t.view:setAttr("value","nil")
		container.view:addSubview(t.view)
		dialog(string.format("未处理的种类%s\n请联系作者",valueType))
	end
end
--@summary:在页面上按索引增加
--@param UI.Container 	uilist: uilist.layout.context目标上下文 
--@param UIView page:当前页面
--@param table Index:索引源
--			string	Name:索引指向Setting的名称
--			string 	Description:此索引别名
--			boolean	ShowAll:是否需要显示此索引下所有数据
--			table	child:当非显示所有时，按child顺序进行显示
--@param	table	nowRootSetting:当前数据根
--@param int rank:当前层级
--@param table	path:记录栈
function UIHandle:IndexInput(uilist,page,Index,nowRootSetting,rank,path)
	local nowSetting=nowRootSetting[Index.Name]
	if not nowSetting then
		dialog(path.."."..Index.Name..",无效")
		return
	end
	if Index.OnSort then
		local container=self:NewTitle(uilist,page,Index.Name,Index,rank)
		for i,k in ipairs(Index.child) do
			self:IndexInput(uilist,container.view,k,nowSetting,rank+1,path.."."..Index.Name)
			nowSetting=nowRootSetting[Index.Name]
		end
	else
		self:BuildInput(uilist,page,Index.Name,nowSetting,rank,path.."."..Index.Name)
	end
end

function UIHandle:BuildConfirmButton(uilist,callBackOk,callBackCancel)
	local btnOK=self:BuildButton(uilist,function(id,action)
		callBackOk(uilist)
	end,Color3B(200,200,255),"运行")
	btnOK.EnableAnimation=true
	local btnTop=0
	btnOK:Navigate(nil,btnTop)
	btnOK.view:setStyle("width",375)
	btnOK.view:setStyle("position","absolute")
	
	local btnCancel=self:BuildButton(uilist,function(id,action)
		callBackCancel(uilist)
	end,Color3B(255,100,100),"设置组...")
	btnCancel:Move(375)
	btnCancel:Navigate(375,btnTop)
	btnCancel.EnableAnimation=true
	btnCancel.view:setStyle("width",375)
	btnCancel.view:setStyle("position","absolute")

end