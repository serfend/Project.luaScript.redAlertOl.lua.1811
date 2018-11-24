sfUI={}

--function UI:show(settingName)
--	local ui = require "bblibs.G_ui"
--	sysLog("加载设置"..settingName)
--	--ui:new(_fsh,_fsw,"启动","切换["..settingName.."]",settingName..".dat")
--	--self:BuildGeneralPage(ui)

--	start,result= ui:show()
	
--	if start==0 then
--		return start,result
--	end

--	printTable(result)
--	return start,result
--end
--function UI:BuildGeneralPage(ui)
--	local p = ui:newPage("通用")
--	p:newLine()
--	p:addLabel(1,1,"脚本间隔",20) 
--	p:addComboBox(1.2,1,"Main.Interval","0",{"1","30","60","120","240","480","960","1920"})

--end
--function UI:BuildAboutPage(ui)
--	p = ui:newPage("关于")
--	p:addLabel(10,1,"当前版本:"..Application.version.."\n更新日期:"..Application.updateDate,20)
--	p:newLine()	
--	p:addLabel(10,0.5,"用户屏幕:".._fsh.."*".._fsw..":".._userDpi,20,nil,(_fitScreen==true and "100,200,100" or "255,100,100")) 
--	p:newLine()
--	p:addLabel(10,0.5,"欢迎使用本脚本,目前尚处于开发阶段,交流群:"..Application.groupQQ..",进群备注游戏id",20,nil,"255,0,0") 
--	p:newLine()
--	p:addLabel(10,5,"更新信息:\n"..table.concat(Application.UpdateInfo,"\n"),20,nil,"100,150,100") 
--	p:newLine()	
--	for j=1,1 do
--	for i,item in ipairs(Application.ProcessInfo) do
--		if item[1]==1 then
--			p:addImage(0.3,0.3,(item[1]==1 and "Process.Completed.png"))
--		else if item[1]==0 then
--				p:addImage(0.3,0.3,(item[1]==0 and "Process.Processing.png"))
--			else if item[1]==-1 then
--					p:addImage(0.3,0.3,(item[1]==-1 and "Process.Closed.png"))
--				else
					
--				end
--			end
--		end
--		p:addLabel(10,0.5,item[2],24,nil,"100,100,150") 
--		p:newLine()	
--	end
--	end
--	p:newLine()	
--	p:addLabel(10,0.5,"power by "..Application.author.." on xxScript.lua.[2.0.1.7]",10)
	
--end
