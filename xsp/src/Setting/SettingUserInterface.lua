sfUI={
	ui={}
}
require "Setting.layout.CSS"
require "Setting.layout.context"
require "Setting.layout.normal"
wui=require "wui.wui"
function sfUI:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
function sfUI:show(settingName)
	local showing = true
	local context=UI.createContext(Context.rootLayout)
	local pages = {
    {
        view = 'div',
        style = {
            width = 480,
            ['background-color'] = '#ffffdd'
        },
        subviews = {
            {
                view = 'text',
                value = '配置1',
                style = {
                    ['font-size'] = 100,
                    color = '#707070'
                }
            }
        }
    },
    {
        view = 'div',
        style = {
            width = 480,
            ['background-color'] = '#ee00ff'
        },
        subviews = {
            {
                view = 'text',
                value = '配置2',
                style = {
                    ['font-size'] = 100,
                    color = '#707070'
                }
            }
        }
    },
	{
        view = 'div',
        style = {
            width = 480,
            ['background-color'] = '#ee00ff'
        },
        subviews = {
            {
                view = 'text',
                value = '配置2',
                style = {
                    ['font-size'] = 100,
                    color = '#707070'
                }
            }
        }
    }
}
local tabPageConfig = {}
tabPageConfig.currentPage = 1
tabPageConfig.pageWidth = 480
tabPageConfig.pageHeight = 560
tabPageConfig.tabTitles = {
    {
        title = '配置1',
        icon = 'https://gw.alicdn.com/tfs/TB1MWXdSpXXXXcmXXXXXXXXXXXX-72-72.png',
        activeIcon = 'https://gw.alicdn.com/tfs/TB1kCk2SXXXXXXFXFXXXXXXXXXX-72-72.png',
    },
    {
        title = '配置2',
        icon = 'https://gw.alicdn.com/tfs/TB1ARoKSXXXXXc9XVXXXXXXXXXX-72-72.png',
        activeIcon = 'https://gw.alicdn.com/tfs/TB19Z72SXXXXXamXFXXXXXXXXXX-72-72.png'
    },{
        title = '配置3',
        icon = 'https://gw.alicdn.com/tfs/TB1ARoKSXXXXXc9XVXXXXXXXXXX-72-72.png',
        activeIcon = 'https://gw.alicdn.com/tfs/TB19Z72SXXXXXamXFXXXXXXXXXX-72-72.png'
    }
}
tabPageConfig.tabStyle = {
    backgroundColor = '#FFFFFF',
    titleColor = '#666666',
    activeTitleColor = '#3D3D3D',
    activeBackgroundColor = '#FFFFFF',
    isActiveTitleBold = true,
    iconWidth = 70,
    iconHeight = 70,
    width = 160,
    height = 120,
    fontSize = 24,
    hasActiveBottom = true,
    activeBottomColor = '#FFC900',
    activeBottomHeight = 6,
    activeBottomWidth = 120,
    textPaddingLeft = 10,
    textPaddingRight = 10
}
local tabPage = wui.TabPage.createView(context, { pages = pages, config = tabPageConfig })
wui.TabPage.setOnSelectedCallback(tabPage, function (id, currentPage)
    print('tabPage id: ' .. id)
    print('tabPage currentPage: ' .. tostring(currentPage))
end)
context:getRootView():addSubview(tabPage)
context:show()
	while showing do
		sleep(1000)
	end

end
function sfUI:BuildGeneralPage(ui)
	local p = ui:newPage("通用")
	p:newLine()
	p:addLabel(1,1,"脚本间隔",20) 
	p:addComboBox(1.2,1,"Main.Interval","0",{"1","30","60","120","240","480","960","1920"})

end
function sfUI:BuildAboutPage(ui)
	p = ui:newPage("关于")
	p:addLabel(10,1,"当前版本:"..Application.version.."\n更新日期:"..Application.updateDate,20)
	p:newLine()	
	p:addLabel(10,0.5,"用户屏幕:".._fsh.."*".._fsw..":".._userDpi,20,nil,(_fitScreen==true and "100,200,100" or "255,100,100")) 
	p:newLine()
	p:addLabel(10,0.5,"欢迎使用本脚本,目前尚处于开发阶段,交流群:"..Application.groupQQ..",进群备注游戏id",20,nil,"255,0,0") 
	p:newLine()
	p:addLabel(10,5,"更新信息:\n"..table.concat(Application.UpdateInfo,"\n"),20,nil,"100,150,100") 
	p:newLine()	
	for j=1,1 do
	for i,item in ipairs(Application.ProcessInfo) do
		if item[1]==1 then
			p:addImage(0.3,0.3,(item[1]==1 and "Process.Completed.png"))
		else if item[1]==0 then
				p:addImage(0.3,0.3,(item[1]==0 and "Process.Processing.png"))
			else if item[1]==-1 then
					p:addImage(0.3,0.3,(item[1]==-1 and "Process.Closed.png"))
				else
					
				end
			end
		end
		p:addLabel(10,0.5,item[2],24,nil,"100,100,150") 
		p:newLine()	
	end
	end
	p:newLine()	
	p:addLabel(10,0.5,"power by "..Application.author.." on xxScript.lua.[2.0.1.7]",10)
	
end