CityMap={
	{Name="建筑工厂",x=0,y=-100,Priority=4},
	{Name="集结指挥部",x=-620,y=-35,Priority=1},
	{Name="联盟大厦",x=-820,y=100,Priority=3},
	{Name="指挥中心",x=-1780,y=900,Priority=3},
	{Name="战车工厂",x=-600,y=600,Priority=1},
	{Name="坦克工厂",x=-900,y=760,Priority=1},
	{Name="城防工厂",x=-1300,y=440,Priority=1},
	{Name="兵营",x=-280,y=760,Priority=1},
	{Name="空指部",x=-590,y=905,Priority=1},
	{Name="作战实验室",x=-120,y=420,Priority=2},
	{Name="仓库",x=400,y=500,Priority=5},
	{Name="光棱塔左",x=-10,y=1000,Priority=7},
	{Name="光棱塔右",x=345,y=800,Priority=7},
	{Name="围墙",x=80,y=750,Priority=4},
	{Name="贸易中心",x=-850,y=-220,Priority=7},
	{Name="军需处",x=-1190,y=320,Priority=7},
	{Name="特惠商人",x=120,y=320,Priority=-1},
	{Name="军需处",x=-1080,y=340,Priority=-1},
	{Name="英雄大厦",x=-310,y=320,Priority=-1},
}

OutCityMap={
	{
		Name="城外建筑",x=1120,y=60,Priority=7
	},
	{
		Name="城外建筑",x=1290,y=105,Priority=7
	},
	{
		Name="城外建筑",x=955,y=220,Priority=7
	},
	{
		Name="城外建筑",x=1105,y=195,Priority=7
	},
	{
		Name="城外建筑",x=1330,y=210,Priority=7
	},
	
	
	{--6到10
		Name="城外建筑",x=1080,y=360,Priority=7
	},
	{
		Name="城外建筑",x=1270,y=400,Priority=7
	},
	{
		Name="城外建筑",x=1435,y=430,Priority=7
	},
	{
		Name="城外建筑",x=1120,y=470,Priority=7
	},
	{
		Name="城外建筑",x=1310,y=510,Priority=7
	},
	
	{--11到15
		Name="城外建筑",x=1010,y=600,Priority=7
	},
	{
		Name="城外建筑",x=1150,y=630,Priority=7
	},
	{
		Name="城外建筑",x=1300,y=680,Priority=7
	},
	{
		Name="城外建筑",x=990,y=720,Priority=7
	},
	{
		Name="城外建筑",x=1150,y=780,Priority=7
	},
	
	
	{--16到20
		Name="城外建筑",x=800,y=680,Priority=7
	},
	{
		Name="城外建筑",x=700,y=790,Priority=7
	},
	{
		Name="城外建筑",x=820,y=860,Priority=7
	},
	{
		Name="城外建筑",x=570,y=890,Priority=7
	},
	{
		Name="城外建筑",x=670,y=955,Priority=7
	},
	
	
	{--21到25
		Name="城外建筑",x=1000,y=1000,Priority=7
	},
	{
		Name="城外建筑",x=1180,y=1050,Priority=7
	},
	{
		Name="城外建筑",x=800,y=1100,Priority=7
	},
	{
		Name="城外建筑",x=950,y=1160,Priority=7
	},
	{
		Name="城外建筑",x=1140,y=1220,Priority=7
	},
	
	{--26到30
		Name="城外建筑",x=230,y=1030,Priority=7
	},
	{
		Name="城外建筑",x=110,y=1150,Priority=7
	},
	{
		Name="城外建筑",x=320,y=1200,Priority=7
	},
	{
		Name="城外建筑",x=-45,y=1240,Priority=7
	},
	{
		Name="城外建筑",x=150,y=1330,Priority=7
	},
	
	
	{--31到35
		Name="城外建筑",x=560,y=1250,Priority=7
	},
	{
		Name="城外建筑",x=690,y=1340,Priority=7
	},
	{
		Name="城外建筑",x=470,y=1380,Priority=7
	},
	{
		Name="城外建筑",x=590,y=1490,Priority=7
	},
	{
		Name="城外建筑",x=750,y=1460,Priority=7
	},
}


function ReloadCityIndex()
	CityIndex={}--建筑索引
	Setting.Building.List={}
	for nowPriority=1,7 do
		for k,v in ipairs(CityMap) do
			v.isOutSize=false
			if v.Priority==nowPriority then
				local tmp={}
				tmp.Description=v.Name
				tmp.Priority=v.Priority
				tmp.MaxRank=0
				table.insert(Setting.Building.List,tmp)--初始化建筑
				CityIndex[tmp.Description]=tmp
			end
		end

		for i,v in ipairs(OutCityMap) do
			v.isOutside=true
			if v.Priority==nowPriority then
				local tmp={}
				tmp.Description=v.Name .. i
				tmp.Priority=v.Priority
				tmp.MaxRank=0
				table.insert(Setting.Building.List,tmp)
				CityIndex[tmp.Description]=tmp
			end
		end
	end
end

