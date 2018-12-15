
--@summary:提供设置所必须的索引选项，实现按顺序显示
--{
--	string Name:索引对应的字段
--	string 	Description:显示的名称，无名称时
--			将从translator实例尝试调用 
--			string Get(string raw,string from)方法翻译
--	bool 	OnSort:是否按指定顺序显示
--	table	child:当非ShowAll时，按此顺序显示子项
--}
ShowSettingIndex={
	{
		Name="Runtime",
		child={
			{
				 
			}
		}
	},
	{
		Name="Building",
		OnSort=true,
		child={
			{
				Name="Enable",
			},
			{
				Name="UseRecommand",
			},
			{
				Name="TraceBuilding",
			},
			{
				Name="Conscript"
			},
			{
				Name="List"
			}
		}
	},
	{
		Name="Expedition",
		child={
			{
				Name="Enable",
			}
		}
	},
	{
		Name="Party",
		child={
			{
				Name="Enable",
			}
		}
	},
	{
		Name="Daily",
		child={
			{
				Name="Enable",
			}
		}
	},
	{
		Name="User",
		child={
			{
				Name="Enable",
			}
		}
	},
	{
		Name="About",
		OnSort=true,
		child={
			{
				Name="Date",
			},
			{
				Name="Application"
			}
		}
	}
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
--		Description={
--			[1]="野怪",
--			[2]="兵营",
--			--[3]="叛军",
--			[3]="矿石",
--			[4]="石油",
--			[5]="合金",
--			[6]="稀土",
--			[7]="基地",
--		},
		
		TargetButton={
			[1]={200,590},
			[2]={250,485},
			[3]={350,425},
			[4]={470,485},
			[5]={530,590}
		},
		
	},
	Daily={
		DiscountStore={
			Require={
				"金币支付","矿石支付","石油支付"
			}
		}
	}
}