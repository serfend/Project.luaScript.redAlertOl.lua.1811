--@summary:特惠商店每8小时检查一次

--@summary:检查特惠商店是否有新货
function Daily:CheckIfNewDiscountStore()
	if not Setting.Daily.DiscountStore.Enable then
		ShowInfo.ResInfo("特惠商店功能被禁用")
	end
end

--@summary:识别其中资源购买的商品
--@return table:{[1]={row=,column=,require=0-金币 1-石油 2-矿石,discount=折扣力度}}
function Daily:DiscountStore_GetPageGoods()

end

--@summary:执行商店流程
function Daily:RunDiscountStore()

end

--@summary:是否可进行免费刷新，若可，则直接刷新并忽略黑金礼包
function Daily:DiscountStore_CheckIfCanRefresh()

end

--@summary:返回对应栏目的坐标
function Daily:DiscountStore_PanelPos(x,y)

end