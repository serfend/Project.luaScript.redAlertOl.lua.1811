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
	local enableColor=themeColor
	targetView:setPseudoStyle(UI.PSEUDO.ENABLED,'background-image' , 
		string.format('linear-gradient(to bottom right, %s, %s)',
			enableColor.toValue(),
			View.Color3BModefy(enableColor,0.2).toValue()
			)
		)
	--ACTIVE
--	local activeColor=themeColor
--	targetView:setPseudoStyle(UI.PSEUDO.ACTIVE,'background-image' , 
--		string.format('linear-gradient(to bottom right, %s, %s)',
--		activeColor.toValue(),
--		View.Color3BModefy(activeColor,1.25).toValue()
--		)
--	)	
--	--DISABLE
--	local disableColorDark=Color3B(12,12,12)
--	local maxColor=max(themeColor.r,themeColor.g,themeColor.b)
--	local disableColorLight=Color3B(maxColor,maxColor,maxColor)
--	targetView:setPseudoStyle(UI.PSEUDO.DISABLED,'background-image' , 
--		string.format('linear-gradient(to bottom right, %s, %s)',
--		disableColorDark.toValue(),
--		disableColorLight.toValue()
--		)
--	)
end

--@summary:按比例变换颜色值
--@param Color3B color:原始颜色
--@rate floot rate:比例
function View.Color3BModefy(color,rate)
	local tmp=color
	tmp.r=math.floor(tmp.r*rate)
	tmp.g=math.floor(tmp.g*rate)
	tmp.b=math.floor(tmp.b*rate)
	if tmp.r>255 then tmp.r=255 end
	if tmp.g>255 then tmp.g=255 end
	if tmp.b>255 then tmp.b=255 end
	return tmp
end
