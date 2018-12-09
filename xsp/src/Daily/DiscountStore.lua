--@summary:特惠商店每8小时检查一次

--@summary:检查特惠商店是否有新货
function Daily:CheckIfNewDiscountStore()
	if Setting.Daily.DiscountStore.Enable then
		local lastRunTime=storage.get("Daily.DiscountStore.lastRunTime",0)
		local nowTime=os.milliTime()/1000
		if(nowTime-lastRunTime)>60 then
			return function() 
				ShowInfo.ResInfo("特惠商人执行")
				Building.building:Navigate("特惠商人")
				self:RunDiscountStore() 
			end
		else
			return false
		end
	else
		ShowInfo.ResInfo("特惠商人功能被禁用")
	end
end

--@summary:记录商店下次刷新时间
function Daily:DiscountStore_RecordNextRefreshTime()
	local rawTime=ocrInfo:GetDiscountStoreRefreshTime()
	rawTime=replace(rawTime," ","")
	print("raw.StoreRefresh."..rawTime)
	local hour=string.sub(rawTime,1,2)
	local minute=string.sub(rawTime,4,5)
	local totalTime=(hour*60+minute)*60
	storage.put("Daily.DiscountStore.lastRunTime",math.floor(totalTime+os.milliTime()/1000))
	ShowInfo.ResInfo(string.format("已记录下次刷新时间:%d小时%d分",hour,minute))
end

--@summary:识别其中资源购买的商品
--@return table:{[1]={row=,column=,isTruckSpeed=是否采集加速
--				,require=0-金币 1-矿石 2-石油,discount=折扣力度,cost=价格}}
function Daily:DiscountStore_GetPageGoods()
	local result={}
	sleep(1000)
	screen.keep(true)
	for y=1,3 do
		for x=1,4 do
			table.insert(result,self:DiscountStore_PanelGoods(x,y))
		end
	end
	screen.keep(false)
	return result
end

--@summary:执行商店流程
function Daily:RunDiscountStore()
	self:DiscountStore_RecordNextRefreshTime()
	ShowInfo.ResInfo("执行商店流程")
	local goods=self:DiscountStore_GetPageGoods()
	for i,k in ipairs(goods) do
		if k.BeenBuy then
		
		else
			if not k.discount then--为黑心宝箱
				
			else
				if self:CompareGood(k) then
					self:BuyGood(k.column,k.row,k.require==0)
					sleep(1500)
				else
				
				end
			end
		end
	end
	if self:DiscountStore_CheckIfCanRefresh() then
		ShowInfo.ResInfo("免费刷新商店")
		sleep(1000)
		return self:RunDiscountStore()
	end
end
--@summary:购买
--@param int x:从左往右第x个商品
--@param int y:从上往下第y个商品
--@param int isGoldGood:商品是否为金币购买
function Daily:BuyGood(x,y,isGoldGood)
	local pos=self:DiscountStore_PanelPos(x,y)
	tap(pos.x+80,pos.y+180)--栏目购买按钮的中间
	sleep(800)
	tap(353,842)--购买按钮
	if isGoldGood then
		sleep(800)
		tap(509,728)--确定按钮
	end
end
--@summary:判断商品是否合适
--@param table:instance of {DiscountStore_GetPageGoods}
function Daily:CompareGood(good)
	local judge=false
	local typeDes=""
	local fitDiscount=0
	if good.isTruckSpeed then
		fitDiscount=Setting.Daily.DiscountStore.Buy.BuyTruck[good.require+1]
		judge= fitDiscount>=good.discount
		typeDes="采集加速商品"
	else
		fitDiscount=Setting.Daily.DiscountStore.Buy.BuyNormal[good.require+1]
		judge= fitDiscount>=good.discount
		typeDes="一般商品"
	end
	print(string.format("%s:%d折,%s %s:%d",typeDes,good.discount,
		Const.Daily.DiscountStore.Require[good.require+1],
		judge and "合适" or "不合适",fitDiscount))
	return judge
end
--@summary:是否可进行免费刷新，若可，则直接刷新并忽略黑金礼包
function Daily:DiscountStore_CheckIfCanRefresh()
	local r,g,b=screen.getRGB(268,1208)
	if r<100 and g>50 and b>120 then--蓝色按钮
		tap(353,1210)--免费刷新按钮
		sleep(800)
		--//TODO 检查是否有黑心宝箱按钮
		return true
	end
	return false
end

local panelX=20--下一个是190，360  
local panelY=298--下一个是511，724
local panelW=165--padding=5
local panelH=208--padding=5
--@summary:返回对应栏目的坐标
function Daily:DiscountStore_PanelPos(x,y)
	return {x=panelX+(x-1)*(panelW+5),y=panelY+(y-1)*(panelH+5)}
end

local discountPosOffsetX=14
local discountPosOffsetY=14
local discountW=14
local discountH=20
--@summary:返回对应栏目商品的信息
--@param int x:从左往右第x个商品
--@param int y:从上往下第y个商品
--@return table:instance of {DiscountStore_GetPageGoods}
function Daily:DiscountStore_PanelGoods(x,y)
	local pos=self:DiscountStore_PanelPos(x,y)
	local r,g,b=screen.getRGB(pos.x+20,pos.y+170)--按钮颜色为灰色，则已购买过
	
	if r<80 and g<80 and b<80 then--灰色商品 //TODO 金币专属可能需要实现
		return {row=y,column=x,BeenBuy=true}
	end
	local discountRaw=ocrInfo:GetDiscountStoreDiscount(
		pos.x+discountPosOffsetX,pos.y+discountPosOffsetY,discountW,discountH)
	print("raw.discount."..discountRaw)
	local price,costType=self:DiscountStore_PanelGoodTypeAndPrice(pos)
	local point = screen.findColor(Rect(pos.x,pos.y,panelW,panelH), 
"0|0|0x977f4d,-25|6|0x91afec,-14|32|0x87ff95",
95, screen.PRIORITY_DEFAULT)
	local TruckSpeed= point.x>0 --是否是采集加速
	return {
		row=y,
		column=x,
		isTruckSpeed=TruckSpeed,
		require=costType,
		discount=tonumber(discountRaw),
		--cost=price
	}
		
end
--@summary:检查当前位置的价格和种类
--@return int string:价格,种类:0-金币 1-矿石 2-石油
function Daily:DiscountStore_PanelGoodTypeAndPrice(pos)
	local priceBeginX=0
	local checkY=pos.y+170
	for nowX=pos.x+panelW,pos.x,-1 do--检查价格和种类
		local r,g,b=screen.getRGB(nowX,checkY)
		if b>100 then--价格结束位置确定
			priceBeginX=nowX+4
			break
		end
	end
	if priceBeginX==0 then
		ShowInfo.ResInfo("识别商品价格失败")
		sleep(5000)
		return false
	end
	local price=0--暂时不需要价格
	--local priceRaw=ocrInfo:GetDiscountStoreDiscount(priceBeginX,checkY,pos.x+panelW-priceBeginX,21)
	--print("raw.price:"..priceRaw)
	--price=tonumber(priceRaw)
	local r,g,b=screen.getRGB(priceBeginX-15,checkY)
	if r>200 and g>200 and b<200 then--金币
		return price,0
	else
		if r>200 and r<150 and b<200 then
			return price,2--石油
		else
			return price,1--矿石
		end
	end
end