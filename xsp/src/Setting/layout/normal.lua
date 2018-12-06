--@summary:
--遵循layout管理所属控件，控件实现Controls接口
--@author:@github.com/serfend
--@date:2018-12-8
require "Setting.layout.UI_Layout"
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
function View.SetLayoutCenter(w,h)
	return {
		left=0.5*(Global.size.width-w),
		top=0.5*(Global.size.height-h),
		width=w,
		height=h
	}
end


--@summary:初始化按钮样式
--@param Color3B themeColor:(r,g,b)主题色
--@param UIView targetView:目标对象
function View.SetButtonStyle(themeColor,targetView)
	--ENABLED
	local enableColor=Color3B(themeColor)
	targetView:setPseudoStyle(UI.PSEUDO.ENABLED,'background-image' , 
		string.format('linear-gradient(to bottom right, %s, %s)',
			string.format("#%06x",enableColor:toValue()),
			string.format("#%06x",View.Color3BModify(enableColor,0.5):toValue())
			)
		)
	--ACTIVE
	local activeColor=Color3B(themeColor)
	targetView:setPseudoStyle(UI.PSEUDO.ACTIVE,'background-image' , 
		string.format('linear-gradient(to bottom right, %s, %s)',
		string.format("#%06x",activeColor:toValue()),
		string.format("#%06x",View.Color3BModify(activeColor,0.1):toValue())
		)
	)	
	--DISABLE
	local disableColorDark=Color3B(12,12,12)
	local maxColor=math.max(themeColor.r,themeColor.g,themeColor.b)
	local disableColorLight=Color3B(maxColor,maxColor,maxColor)
	targetView:setPseudoStyle(UI.PSEUDO.DISABLED,'background-image' , 
		string.format('linear-gradient(to bottom right, %s, %s)',
		string.format("#%06x",disableColorLight:toValue()),
		string.format("#%06x",disableColorDark:toValue())
		)
	)
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
