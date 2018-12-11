--@summary:
--遵循layout管理所属控件，控件实现IControl接口
--@author:@github.com/serfend
--@date:2018-12-8
require "Setting.layout.Container"
require "Setting.layout.UI_Layout"
require "Setting.layout.UI_Tab"
require "Setting.layout.UI_Timespan"
require "Setting.layout.UI_Button"
require "Setting.layout.UI_Label"
View = {
	
}--初始化
--@summary:初始化布局
function View.SetLayout(x,y,w,h)
	return {
		left=x,
		top=y,
		width=w,
		height=h
	}
end
--@summary:设置布局尺寸并居中
--@param single w/h:布局尺寸像素
function View.SetLayoutCenter(w,h)
	return {
		left=math.floor(375*(Global.size.width-w)/Global.size.width),--原始宽为750
		top=math.floor(0.5*(Global.size.height-h)),--原始高为 设备高*750/设备宽
		width=w*750/Global.size.width,
		height=h*750/Global.size.width
	}
end


--@summary:初始化按钮样式
--@param Color3B themeColor:(r,g,b)主题色
--@param UIView targetView:目标对象
function View.SetButtonStyle(themeColor,targetView)
	--ENABLED
	local enableColor=Color3B(themeColor)
	local formatEnableColor=string.format('linear-gradient(to bottom right, #%06x, #%06x)',
				enableColor:toInt(),View.Color3BModify(enableColor,0.5):toInt()
			)
	targetView:setPseudoStyle(UI.PSEUDO.ENABLED,'background-image' , formatEnableColor)
	--ACTIVE
	local activeColor=Color3B(themeColor)
	local formatActiveColor=string.format('linear-gradient(to bottom right, #%06x,#%06x)',
			activeColor:toInt(),View.Color3BModify(activeColor,0.1):toInt()
		)
	targetView:setPseudoStyle(UI.PSEUDO.ACTIVE,'background-image', formatActiveColor)	
	--DISABLE
	local disableColorDark=Color3B(12,12,12)
	local maxColor=math.max(themeColor.r,themeColor.g,themeColor.b)
	local disableColorLight=Color3B(maxColor,maxColor,maxColor)
	local formatDisableColor=string.format('linear-gradient(to bottom right, #%06x, #%06x)',
			disableColorLight:toInt(),disableColorDark:toInt()
		)
	targetView:setPseudoStyle(UI.PSEUDO.DISABLED,'background-image' , formatDisableColor)
end

--@summary:按比例变换颜色值
--@param Color3B color:原始颜色
--@rate float rate:比例
function View.Color3BModify(color,rate)
	local tmp=Color3B(color)
	tmp.r=math.floor(tmp.r*rate)
	tmp.g=math.floor(tmp.g*rate)
	tmp.b=math.floor(tmp.b*rate)
	if tmp.r>255 then tmp.r=255 end
	if tmp.g>255 then tmp.g=255 end
	if tmp.b>255 then tmp.b=255 end
	return tmp
end
