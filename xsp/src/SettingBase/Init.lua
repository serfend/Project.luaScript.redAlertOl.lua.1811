Init={}


function Init:GetNowDetail()--获取钻石/水晶/金币数量
	local code,DiamondResult=ocr:GetNum(1752,30,1844,64)
	Setting.Main.Res.Diamond=tonumber(DiamondResult) or -1
	local code,CrystalsResult=ocr:GetNum(1752,116,1844,143)
	Setting.Main.Res.Crystals=tonumber(CrystalsResult) or -1
	local code,CointResult=ocr:GetNum(1752,197,1844,223)
	Setting.Main.Res.Coin=tonumber(CointResult) or -1
	ShowInfo.ResInfo("res:"..
		Setting.Main.Res.Diamond..","..
		Setting.Main.Res.Crystals..","..
		Setting.Main.Res.Coin
	)
end