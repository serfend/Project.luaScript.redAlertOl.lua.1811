-- 作者boyliang
-- 时间: 2015-11-26
require "bblibs.StringBuilder"
StrUtils=require "bblibs.StrUtilsAPI"
-- 格式化输出
function sysLogFmt(fmt, ...)
  sysLog(string.format(fmt, ...))
end
function GetMaxIndex(...)
	local items={...}
	if #items==0 then return 0 end
	local maxValue=items[1]
	local maxIndex=1
	for i=2,#items do
		if items[i]>maxValue then
			maxValue=items[i]
			maxIndex=i
		end
	end
	return maxIndex
end
function GetUserImages(interval,size)
	require "bblibs.pos"

	while(true) do 
		catchTouchPoint()
		local point=pos:new()
		local f=point:GetImageDescription(interval,size)--提取按下点周围的信息
		for times=1,5 do
			local points=findColors({0,0,1920,1080},f,90,0,0,0)
			points=exceptPosTableByNewtonDistance(points,50)
			for i=1,#points do
				for j=1,5 do
					showRect(points[i].x-10,points[i].y-10,points[i].x+10,points[i].y+10,500,nil,tostring(i))
				end
			end
			mSleep(1000)
		end
	end
end
function restartApp(delay)
	delay=delay or 30000
	local lastApp=frontAppName()
	closeApp(lastApp)
	mSleep(2000)
	
	runApp(lastApp)
	for i=delay,1,-5000 do
		toast("重启中..."..i.."ms后重新启动")
		mSleep(5000)
	end
end
function showRectPos(x,y,timeDelay,color,info)
	showRect(x-10,y-10,x+10,y+10,timeDelay,color,info)
end
function showRect(x1,y1,x2,y2,timeDelay,color,info)
	sysLog("ShowRect"..x1..","..y1.."."..x2..","..y2)
	color=color or "0xacff0000"
	info=info or ""
	timeDelay=timeDelay or 1000
	local tmpHud=createHUD()
	showHUD(tmpHud,info,(x2-x1)*0.2,"0xffffffff",color,0,x1,y1,x2-x1,y2-y1)
	mSleep(timeDelay)
	hideHUD(tmpHud)
	mSleep(30)
end
local expandedRect,expandingRect,rectAera={},{},{}
function GetRect(initX,initY,beginX,endX,beginY,endY,r,g,b,endurence)
	expandedRect,expandingRect,rectAera={},{},{}
	rectAera.x1,rectAera.x2,rectAera.y1,rectAera.y2=beginX,endX,beginY,endY
	expandingRect[1]={x=initX,y=initY}
	for x=rectAera.x1,rectAera.x2 do
		expandedRect[x]={}
	end
	return ExpandRect(r,g,b,endurence)
end
function ExpandRect(r,g,b,endurence)
	local expandCount,maxX,minX,maxY,minY=1,0,9999,0,9999
	while (true) do
		local hdlRect=expandingRect
		expandingRect,expandCount={},1
		for i,pos in ipairs(hdlRect) do
			local currentPos=hdlRect[i]
			for stepX=-1,1,1 do
				for stepY=-1,1,1 do
					local newX,newY=currentPos.x+stepX,currentPos.y+stepY
					--sysLog(string.format("(%s,%s)",newX,newY))
					if CheckRectPos(newX,newY,r,g,b,endurence) then
						expandingRect[expandCount]={x=newX,y=newY}
						expandedRect[newX][newY]=true
						expandCount=expandCount+1
						if maxX<newX then maxX=newX end
						if maxY<newY then maxY=newY end
						if minX>newX then minX=newX end
						if minY>newY then minY=newY end
					end
				end
			end
		end
		----sysLog(string.format("(%s,%s)-(%s,%s)",tostring(minX),tostring(minY),tostring(maxX),tostring(maxY)))
		if expandCount==1 then return {x1=minX,y1=minY,x2=maxX,y2=maxY} end
	end
end
function CheckRectPos(x,y,r,g,b,endurence)
	if x>rectAera.x2 or x<rectAera.x1 or y>rectAera.y2 or y<rectAera.y1 then return false end
	if expandedRect[x][y] then return false end
	local r2,g2,b2	=	getColorRGB(x,y)
	local aberration= 	GetAberration(r,g,b,r2,g2,b2)
	return endurence>=aberration
end
function GetAberration(r,g,b,r2,g2,b2)
	return math.abs(r-r2)+math.abs(g-g2)+math.abs(b-b2)
end

function sleepWithCheckLoading(interval)
	local canGoOn=false
	local times=0
	while not canGoOn do
		mSleep(interval)
		if Form:CheckLoading() then
			times=times+1
			ShowInfo.RunningInfo("出现卡顿"..times)
			if times>10 then
				toast("达到卡顿最大上限，重启游戏")
				restartApp()
			end
		else
			canGoOn=true
		end
	end
end
function sleepWithCheckEnemyConquer(interval)
	if normal:CheckIfAnyEnemyConquer() then
		ShowInfo.RunningInfo("【防御模式】")
		while normal:CheckIfAnyEnemyConquer() do
			sleep(1000)
		end
		return
	end
	if interval<1000 then
		sleep(interval)
	else
		sleep(1000)
		sleepWithCheckEnemyConquer(interval-1000)
	end
	
end
-- 任意输出
function sysLogLst(...)
  local msg = ''
  for k,v in pairs({...}) do
    msg = string.format('%s %s ', msg, tostring(v))
  end
  sysLog(msg)
end
function getTableFirstValue(list)
	local rootType = type(list)
	if rootType == "table" then
		for i,item in pairs(list) do
			return getTableFirstValue(item)
		end
	else
		return list
	end
end
function exceptPosTableByNewtonDistance(list,dis)
	local newList={}
	if list==nil then
		return {}
	end
	for i,item in ipairs(list) do
		local canAdd=true
		for j=i+1,#list do
			local disX=math.abs(item.x-list[j].x)
			local disY=math.abs(item.y-list[j].y)
			if disX+disY<dis then
				canAdd=false
				break
			end
		end
		if canAdd then 
			table.insert (newList,item)
		end
	end
	return newList
end
function split( str,reps )
    local resultStrList = {}
    string.gsub(str,'[^'..reps..']+',function ( w )
        table.insert(resultStrList,w)
    end)
    return resultStrList
end
function replace(str,find,to)
	return string.gsub(str,find,to)
end
function isColor(x,y,c,s)   --x,y为坐标值，c为颜色值，s为相似度，范围0~100。
    local fl,abs = math.floor,math.abs
    s = fl(0xff*(100-s)*0.01)
    local r,g,b = fl(c/0x10000),fl(c%0x10000/0x100),fl(c%0x100)
    local rr,gg,bb = getColorRGB(x,y)
    if abs(r-rr)<s  and abs(g-gg)<s  and abs(b-bb)<s then
        return true
    end
    return false
end
function GetLastValue(iniValue)
	local tmp=split(iniValue," ")
	return tmp[#tmp]
end
-- 模拟一次点击
function tap(x, y,delay)
	--sysLog("tap:"..x..","..y)
  --math.randomseed(tostring(os.time()):reverse():sub(1, 6))  --设置随机数种子
  local index = math.random(1,5)
  touchDown(index,x, y)
  delay=delay or 0
  sleep(math.random(delay+20,delay+30))                --某些特殊情况需要增大延迟才能模拟点击效果
  touchUp(index, x, y)
  sleep(30)
end
function distance(x1,y1,x2,y2)
	return math.sqrt((x2-x1)^2+(y2-y2)^2)
end
-- 模拟滑动操作，从点(x1, y1)划到到(x2, y2)
function swip(x1,y1,x2,y2,step)
	step=step or 10
	index = math.random(1,5)
    touchDown(index, x1, y1)
	sleep(30)
    for i=1,step do
		touchMove(index,(x2-x1)*i/step+x1,(y2-y1)*i/step+y1)
		sleep(30)
	end
    sleep(200)
    touchUp(index, x2, y2)
	sleep(100)
end


-- 多点颜色对比，格式为{{x,y,color},{x,y,color}...} 
function cmpColor(array, s, isKeepScreen)
  s = s or 90
  s = math.floor(0xff * (100 - s) * 0.01)
  isKeepScreen = isKeepScreen or false


  screen.keep(true)
  for i = 1, #array do
    local lr,lg,lb = getColorRGB(array[i][1], array[i][2])
    local rgb = array[i][3]

    local r = math.floor(rgb/0x10000)
    local g = math.floor(rgb%0x10000/0x100)
    local b = math.floor(rgb%0x100)

    if math.abs(lr-r) > s or math.abs(lg-g) > s or math.abs(lb-b) > s then
      screen.keep(false)
      return false
    end
  end

  screen.keep(false)
  return true
end

function string.contains(raw,finding)
	local index=string.find(raw,finding)
	return index and index>0
end
function string.GetElement(raw,strBegin,strEnd,nowPos)
	local beginIndex,beginEndIndex=string.find(raw,strBegin,nowPos)
	if beginIndex then
		local endIndex,endEndIndex=string.find(raw,strEnd,beginIndex,beginIndex)
		return string.sub(raw,beginEndIndex+1,endIndex-1),endIndex
	else
		return nil
	end
end
function string.GetAllElement(raw,strBegin,strEnd)
	local tmp={}
	local tmpInfo=""
	local nowPos=1
	while true do
		tmpInfo,nowPos=string.GetElement(raw,strBegin,strEnd,nowPos)
		if tmpInfo then
			table.insert(tmp,tmpInfo)
		else
			return tmp
		end
	end
end