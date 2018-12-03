function self:RunDiscountStore()
	if not Setting.Daily.DiscountStore.Enable then
		ShowInfo.ResInfo("特惠商店功能被禁用")
	end
end