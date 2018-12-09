Context={
	--@summary:常规按钮控件
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
	--@summary:常规标签控件
	LabelNormal={
		id="LabelDefault",
		view="text",
		class="txt",
	},
	
	--@summary:对话框布局
	retDialog={
		view="div",
		style={
			['background-color'] = '#a1000000',
		},
	},
	
	--@summary:核心设置布局
	rootSetting={
		view="div",
		style={
			['background-color'] = '#a1000000',
		},
	},
	
	--@summary:计时器控件
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

