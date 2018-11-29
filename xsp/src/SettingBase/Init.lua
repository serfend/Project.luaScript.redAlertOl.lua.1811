

Setting={
	User={
		list={},
		userNum=function() return #Setting.User.list end,
	},
	Building={
		Enable=true,
		SortRelyOnSystem=false,
		TraceBuilding=false,--当建筑条件不满足时，自动满足此条件
		SpeedUp={--满足剩余时间时秒建筑
			Enable=false,
			MinSpeedUpTime=30,
		},
		List={
			--建筑名={Priority=1,MaxRank=1}
		},
	},
	Runtime={
		ActiveMode={
			Interval=60,--每1分钟执行一次主动检查
			--@summary:上次主动操作开始的时间
			LastActiveTime=0,
		},
		
	},
	Expedition={
		PlayerEnergyPreserve=50,
		--@summary:是否自动补充体力
		PlayerEnergySupply=false,
		PlayerNoEnergyTargetEnable=false,
		PlayerMaxEnergy=100,
		--@summary:targetInfo[1]={Enemy=1,Rank={max=11,min=10}}
		--@property Enemy:由左至右依次顺序1-7
		--@property Rank:{max=1,min=1}目标的等级范围
		--@property Action:0-Dialog_OK 1-5:对应地图中按钮
		--@property Troop:0-默认 5-最高等级 6-最大负重 7-最快行军 8-均衡搭配 1到4-编队
		TargetInfo={
			[1]={Enemy=4,Rank={max=7,min=6},Action=5,Troop=0},
			[2]={Enemy=4,Rank={max=7,min=6},Action=5,Troop=0},
			[3]={Enemy=3,Rank={max=14,min=12},Action=0,Troop=0},
			[4]={Enemy=3,Rank={max=14,min=12},Action=0,Troop=0},
		},
		NoEnergyTargetInfo={
			[1]={Enemy=4,Rank={max=7,min=6},Action=5,Troop=0},
			[2]={Enemy=4,Rank={max=7,min=6},Action=5,Troop=0},
			[3]={Enemy=4,Rank={max=7,min=6},Action=5,Troop=0},
			[4]={Enemy=4,Rank={max=7,min=6},Action=5,Troop=0},
		}
	},
	Conscription={
		conscript={
			[1]={Enable=false,Description="坦克"},
			[2]={Enable=false,Description="空军"},
			[3]={Enable=false,Description="步兵"},
			[4]={Enable=false,Description="战车"},
			[5]={Enable=false,Description="城防"},
		}
	},
	Party={
		Gift={
			Enable=true,
			EnableOnekeyAttain=true,
		},
		Task={
			Enable=true,
		},
		Treasure={
			Enable=true,
			AssistOther={
				Enable=true,
				--1:绿色 2:蓝色 3:紫色 4:金色
				TreasureSort={4,3,2,1},
			},
			Self={
				Enable=true,
				AutoRefresh=true,
				TreasureSort={4,3,2},
			}
		}
	},
	
}

Const={
	Toolbar={
		scene={
			[1]="城市",
			[2]="世界",
			[3]="子菜单",
			[4]="其他"
		}
	},
	Expedition={
		PlayerEnergy={
			[1]=5,--野怪
			[2]=15,--兵营
			[3]=5,--野怪
			[4]=0,
			[5]=0,
			[6]=0,
			[7]=0,
			[8]=15,
		},
		Description={
			[1]="野怪",
			[2]="兵营",
			[3]="叛军",
			[4]="矿石",
			[5]="石油",
			[6]="合金",
			[7]="稀土",
			[8]="基地",
		},
		
		TargetButton={
			[1]={200,590},
			[2]={250,485},
			[3]={350,425},
			[4]={470,485},
			[5]={530,590}
		}
	}
}