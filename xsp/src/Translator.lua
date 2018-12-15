Translator = {
	lang={
		en={
			Enable=1,
			Test=2,
			ActiveMode=3,
			TraceBuilding=4,
			SpeedUp=5,
			List=6,
			UseRecommand=7,
			Conscript=8,
			PlayerMaxEnergy=9,
			Building=10,
			Daily=11,
			Expedition=12,
			Party=13,
			Runtime=14,
			User=15,
			About=16,
			Check=17,
			InDanger=18,
			AutoBuyProtect=19,
			AutoProtect=20,
			AutoWithdraw=21,
			MaxRank=22,
			Priority=23,
			TargetInfo=24,
			Rank=25,
			min=26,
			max=27,
			Action=28,
			Troop=29,
			Enemy=30,
			Interval=31,
		},
		cn={
			[1]="启用",
			[2]="测试",
			[3]="激活模式",
			[4]="自动完成建筑前置条件",
			[5]="加速",
			[6]="列表",
			[7]="使用系统推荐",
			[8]="征兵",
			[9]="玩家体力上限值",
			[10]="建筑",
			[11]="日常",
			[12]="出征",
			[13]="联盟",
			[14]="通用",
			[15]="多用户",
			[16]="关于",
			[17]="检查",
			[18]="危险判断",
			[19]="自动购买防护罩",
			[20]="自动使用防护罩",
			[21]="当受到撞田时撤兵",
			[22]="最高等级",
			[23]="优先级",
			[24]="出征目标设置",
			[25]="目标等级",
			[26]="最小",
			[27]="最大",
			[28]="动作",
			[29]="队伍",
			[30]="敌人",
			[31]="间隔"
		}
	}
}--初始化
function Translator:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

--@summary:转换文字
--@param string raw:原始内容
--@param string from:来源语言
function Translator:Get(raw,from)
	local language= self.lang[from]
	return self.lang.cn[language[raw]] or raw
	
end