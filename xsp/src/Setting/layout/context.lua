Context={
	
	BtnNormal={
			id = 'Btn',
			view = 'div',
			class = 'button',
			subviews = {
				{
					view = 'text',
					class = 'txt',
					value = '按钮内容'
				}
			}
		},
	logo={
			view = 'image',
			class = 'logo', -- 动态创建的image使用到了globalStyle中的'logo'
			src = 'http://www.xxzhushou.cn/statics/images/xxcms5/logo.png',
			style = {
				width = 280,
				height = 76
			}
		},
	rootLayout = {
		view = 'scroller',
		style = {
			width = _sw,
			['background-color'] = '#fff',
			['align-items'] = 'center',
		}
	},
	
	retDialog={
		view="scroller",
		style={
			['background-color'] = '#a1000000',
			['align-items'] = 'center',
		},
	},
	
	TimeSpan={
		id="timeSpan",
		view="div",
		style={
			['align-items'] = 'center',
			['background-color'] = '#ef3fff7f',
			height=10,
			['font-size'] = 5,
		},
		subviews = {
				{
					view = 'text',
					value = "倒计时"
				}
			}
	}
}

