
--@summary:主设置
--ui设置自动化将自动遍历每个设置，加入ui的设置需设置索引ShowSettingIndex
Setting={
	User={
		暂未开放此功能={
			
		},
		Enable="false",
		UserNum=1,
		List={
			Uin=331945833,
			Enable="true"
		},
	},
	Building={
		Enable="true",
		UseRecommand="false",
		TraceBuilding="false",--当建筑条件不满足时，自动满足此条件
		Conscript={
			[1]={Enable="true",Description="坦克"},
			[2]={Enable="true",Description="空军"},
			[3]={Enable="true",Description="步兵"},
			[4]={Enable="true",Description="战车"},
			[5]={Enable="false",Description="城防"},
		},
		List={
			--建筑名={Priority=1,MaxRank=1}
		}
	},
	Runtime={
		ActiveMode={
			Interval=60,--每1分钟执行一次主动检查
		},
		Check={
			InDanger={
				AutoProtect=0,--0:不使用 1:1小时 2:8小时 3:24小时
				AutoWithdraw="true",
				AutoBuyProtect=0,--0:不买 1:1小时 2:8小时 3:24小时
			}
		}
	},
	Expedition={
		Enable="true",
		PlayerEnergyPreserve=50,
		--@summary:是否自动补充体力
		PlayerEnergySupply="false",
		PlayerNoEnergyTargetEnable="false",
		PlayerMaxEnergy=100,
		--@summary:targetInfo[1]={Enemy=1,Rank={max=11,min=10}}
		--Rank取非正数，表示取等级=游戏最大值减去此值
		--@property Enemy:由左至右依次顺序1-7
		--@property Rank:{max=1,min=1}目标的等级范围
		--@property Action:0-Dialog_OK 1-5:对应地图中按钮
		--@property Troop:0-默认 5-最高等级 6-最大负重 7-最快行军 8-均衡搭配 1到4-编队
		TargetInfo={
			[1]={Enemy=5,Rank={max=7,min=4},Action=5,Troop=0,Description="队列1"},
			[2]={Enemy=5,Rank={max=7,min=4},Action=5,Troop=0,Description="队列2"},
			[3]={Enemy=5,Rank={max=7,min=4},Action=5,Troop=0,Description="队列3"},
			[4]={Enemy=5,Rank={max=7,min=4},Action=5,Troop=0,Description="队列4"},
			[5]={Enemy=5,Rank={max=7,min=4},Action=5,Troop=0,Description="队列5"},
		},
		NoEnergyTargetInfo={
			[1]={Enemy=5,Rank={max=7,min=6},Action=5,Troop=0,Description="队列1"},
			[2]={Enemy=5,Rank={max=7,min=6},Action=5,Troop=0,Description="队列2"},
			[3]={Enemy=5,Rank={max=7,min=6},Action=5,Troop=0,Description="队列3"},
			[4]={Enemy=5,Rank={max=7,min=6},Action=5,Troop=0,Description="队列4"},
			[5]={Enemy=5,Rank={max=7,min=6},Action=5,Troop=0,Description="队列5"},
		}
	},
	Party={
		Enable="true",
		Gift={
			Enable="true",
			EnableOnekeyAttain="true",
		},
		Task={
			Enable="true",
		},
		Treasure={
			Enable="true",
			AssistOther={
				Enable="true",
				--1:绿色 2:蓝色 3:紫色 4:金色
			},
			Self={
				Enable="true",
				AutoRefresh="true",
				TreasureSort={4,3,2,1}
			}
		},
		Donation={
			Enable="true",
			MinDonateTime=12,
		}
	},
	Daily={
		Enable="true",
		Recruit="true",--每日5次招募
		DiscountStore={
			Enable="true",
			Buy={--金币购买,矿石购买,石油购买
				BuyNormal={
					Gold=0,
					Mine=10,
					Oil=10
				},--购买资源付费的商品
				BuyTruck={
					Gold=0,
					Mine=10,
					Oil=10
				},--购买矿车加成 采集加速
			},
			AutoRefresh="true",--自动免费刷新
		},
		Supply={
			Enable="true",
			res={
				Mine="false",
				Oil="false",
				Metal="false",
				Tom="false"
			},--1:矿 2:油 3:合金 4:稀土
		},
	},
	About={
		Date="2018.12.11",
		
	}
}
require "SettingBase.Init_Index"