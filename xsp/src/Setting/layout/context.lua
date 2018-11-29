Context={
	
	btn={
			id = 'test_btn',
			view = 'div',
			class = 'button',
			subviews = {
				{
					view = 'text',
					class = 'txt',
					value = 'ok'
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
}

