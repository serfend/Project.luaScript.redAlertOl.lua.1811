CityMap={
	建筑工厂={x=0,y=-100,Priority=4},
	集结指挥部={x=-620,y=-35,Priority=1},
	联盟大厦={x=-820,y=100,Priority=3},
	指挥中心={x=-1780,y=900,Priority=3},
	战车工厂={x=-600,y=600,Priority=1},
	坦克工厂={x=-900,y=760,Priority=1},
	城防工厂={x=-1300,y=440,Priority=1},
	兵营={x=-280,y=760,Priority=1},
	空指部={x=-590,y=905,Priority=1},
	作战实验室={x=-120,y=420,Priority=2},
	仓库={x=400,y=500,Priority=5},
	光棱塔左={x=-10,y=1000,Priority=7},
	光棱塔右={x=345,y=800,Priority=7},
	围墙={x=80,y=750,Priority=4},
	贸易中心={x=-850,y=-220,Priority=7},
	军需处={x=-1190,y=320,Priority=7},
	特惠商人={x=120,y=320,Priority=-1},
	军需处={x=-1080,y=340,Priority=-1},
}

for k,v in pairs(CityMap) do
	if v.Priority>0 then
		local tmp={}
		tmp.Name=k
		tmp.Priority=v.Priority
		tmp.MaxRank=0
		table.insert(Setting.Building.List,tmp)--初始化建筑
	end
end