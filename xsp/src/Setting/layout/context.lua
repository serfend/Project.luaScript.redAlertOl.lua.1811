Context={
	BrLine={
		id="lineDefault",
		view="div",
		style={
			width=100,
			['background-color'] = '#aaaaaa',
			height=2,
			['border-bottom-width']=1,
			['border-bottom-color']="#aaaaff"
		}
	},
	--@summary:标准的输入组
	InputDiv={
		id="divDefault",
		view="div",
		subviews={
			{
				view="text",
				style = {
					['font-size'] = 30,
					color = '#707070',
				}
			}
		},
		style={
			['flex-direction'] = 'row',
		}
	},
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
	--@summary:常规输入框
	TextNormal={
		id="TextDefalut",
		view="input",
		class ="input",
		style = {
                width = 300,
                height = 45,
                ['background-color'] = '#3f0000ff',
				['padding-top'] = 5,
				['padding-bottom'] = 5,
				['border-radius']=5
            }
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
		view="scroller",
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
	},
	
	MainSetting={
		{
			view = 'div',
			style = {
			},
			subviews = {
			}
		},
		{
			view = 'div',
			style = {
			},
			subviews = {
			}
		},
		{
			view = 'div',
			style = {
			},
			subviews = {
			}
		},
		{
			view = 'div',
			style = {
			},
			subviews = {
			}
		},
		{
			view = 'div',
			style = {
			},
			subviews = {
			}
		},
		{
			view = 'div',
			style = {
			},
			subviews = {
			}
		},
		{
			view = 'div',
			style = {
			},
			subviews = {
			}
		},
	},
	
	MainSettingTitle={
		{
			title="通用",
			icon = 'https://gw.alicdn.com/tfs/TB1MWXdSpXXXXcmXXXXXXXXXXXX-72-72.png',
			activeIcon = 'https://gw.alicdn.com/tfs/TB1kCk2SXXXXXXFXFXXXXXXXXXX-72-72.png',
		},
		{
			title="城建",
			icon = 'https://gw.alicdn.com/tfs/TB1ARoKSXXXXXc9XVXXXXXXXXXX-72-72.png',
			activeIcon = 'https://gw.alicdn.com/tfs/TB19Z72SXXXXXamXFXXXXXXXXXX-72-72.png'
		},
		{
			title="日常",
			icon = 'https://gw.alicdn.com/tfs/TB1VKMISXXXXXbyaXXXXXXXXXXX-72-72.png',
			activeIcon = 'https://gw.alicdn.com/tfs/TB1aTgZSXXXXXazXFXXXXXXXXXX-72-72.png'
		},
		{
			title="出征",
			icon = 'https://gw.alicdn.com/tfs/TB1Do3tSXXXXXXMaFXXXXXXXXXX-72-72.png',
			activeIcon = 'https://gw.alicdn.com/tfs/TB1LiNhSpXXXXaWXXXXXXXXXXXX-72-72.png'
		},
		{
			title="联盟",
			icon = 'https://gw.alicdn.com/tfs/TB1jFsLSXXXXXX_aXXXXXXXXXXX-72-72.png',
			activeIcon = 'https://gw.alicdn.com/tfs/TB1_Kc.SXXXXXa8XpXXXXXXXXXX-72-72.png'
		},
		{
			title="监控",
			icon = 'https://gw.alicdn.com/tfs/TB199sPSXXXXXb4XVXXXXXXXXXX-72-72.png',
			activeIcon = 'https://gw.alicdn.com/tfs/TB1DR.3SXXXXXc2XpXXXXXXXXXX-72-72.png'
		},
		{
			title="关于",
			icon = 'https://gw.alicdn.com/tfs/TB1hedfSpXXXXchXXXXXXXXXXXX-72-72.png',
			activeIcon = 'https://gw.alicdn.com/tfs/TB1mrXaSpXXXXaqXpXXXXXXXXXX-72-72.png'
		},
	}
}

