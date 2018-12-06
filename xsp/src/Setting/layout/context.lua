Context={
	
	BtnNormal={
			id = 'BtnDefault',
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
	LabelNormal={
		id="LabelDefault",
		view="text",
		class="txt",
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

	
	retDialog={
		view="div",
		style={
			['background-color'] = '#a1000000',
		},
	},
	
	TimeSpan={
		id="timeSpan",
		view="div",
		style={
			['align-items'] = 'center',
			['background-color'] = '#ef3fff7f',
			height=20,
		},
		subviews = {
				{
					view = 'text',
					value = "倒计时",
					style={
						['font-size'] = 20,
					}
				}
			}
	}
}

