



--@summary:检查含有【帮】字样的蓝色按钮并返回所有坐标
function party:GetAssistOtherPreasure()
	local points = screen.findColors(Rect(540, 310, 154, 843), 
"0|0|0xfbfcfc,0|18|0x528cc9,15|18|0xffffff,15|0|0xf9fafb",
95, screen.PRIORITY_DEFAULT)
	points=exceptPosTableByNewtonDistance(points,20)
	return self:TransformPointToPreasureType(points)
end

--@summary:检查含有【求】字样的蓝色按钮并返回所有坐标
function party:GetSelfWaitAssistPreasure()
	local points = screen.findColors(Rect(540, 310, 154, 843), 
"0|0|0xfdfefe,0|15|0x4885c6,13|15|0xcaddef,13|0|0xfdfefe",
95, screen.PRIORITY_DEFAULT)
	points=exceptPosTableByNewtonDistance(points,20)
	return self:TransformPointToPreasureType(points)
end

--summary:检查含有【挖】资源的蓝色按钮并返回所有坐标
function party:GetSelfWaitDigPreasure()
	local points = screen.findColors(Rect(540, 310, 154, 843), 
"0|0|0xf5f7f9,0|11|0x437bbb,13|11|0x497fbe,13|-2|0xf6f8fa",
95, screen.PRIORITY_DEFAULT)
	points=exceptPosTableByNewtonDistance(points,20)
	return self:TransformPointToPreasureType(points)
end

--@summary:将获取到的点识别颜色
function party:TransformPointToPreasureType(points)
	local result={}
	for k,p in ipairs(points) do
		local tmp={x=p.x,y=p.y}
		tmp.Type=self:GetPreasureType(p)
		table.insert(result,tmp)
	end
	return result
end
--@summary:获取目标按钮所在宝箱的颜色
--@return:1-绿 2-蓝 3-紫 4-金
function party:GetPreasureType(rawPos)
	local r,g,b=screen.getRGB(rawPos.x,rawPos.y-160)--获取上方横条的颜色
	if g>40 and b<40 and r<20 then
		return 1
	else if b>50 and g<45 and r<20 then
			return 2
		else if b>50 and r>40 and g<35 then
				return 3
			else
				ShowInfo.ResInfo(string.format("未知的特征:%d:%d:%d",r,g,b))
				return 4
			end
		end
	end
end