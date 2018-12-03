Daily={

}
require "Daily.DiscountStore"
require "Daily.Recruit"
--@summary:完成日常任务
function Daily:Run()
	self:RunDiscountStore()
	self:RunRecruit()
	--每日奖励
	--日常任务奖励
	--贵族礼包
end