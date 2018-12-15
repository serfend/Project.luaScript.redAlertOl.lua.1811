--[[
  @Author xxzhushou
  @Repo   https://github.com/xxzhushou/WUI
]]--

local wutils = require 'wui.utils'

local wtab_page = {
    itemLayout = function ()
        return {
            view = 'div',
            style = {},
            subviews = {
                {
                    view = 'image',
                    style = {},
                    src = ''
                },
                {
                    view = 'text',
                    style = {},
                    value = ''
                },
                {
                    view = 'div',
                    style = {}
                }
            }
        }
    end,

    layout = function ()
        return {
            view = 'div',
            style = {},
            subviews = {
                {
                    view = 'scroller',
                    ['show-scrollbar'] = 'true',
                    scrollDirection = 'horizontal',
                    style = {},
                    subviews = {}
                },
                {
                    view = 'scroller',
                    style = {},
                    subviews = {
                        {
                            view = 'div',
                            style = {},
                            subviews = {}
                        }
                    }
                }
            }
        }
    end,
    style = {
        ['wui-tab-page'] = {
            width = 750,
            height = 1334
        },
        ['tab-title-list'] = {
            ['flex-direction'] = 'row',
        },
        ['title-item'] = {
            ['justify-content'] = 'center',
            ['align-items'] = 'center',
            ['border-bottom-style'] = 'solid',
        },
        ['border-bottom'] = {
            position = 'absolute',
            bottom = 0
        },
        ['tab-page-wrap'] = {
            width = 750,
            overflow = 'hidden'
        },
        ['tab-container'] = {
            position = 'relative',
			['padding-top'] = 10,
			['padding-bottom'] = 10,
			['padding-left'] = 10,
			['padding-right'] = 10,
--            width = 750,
--            flex = 1,
            ['flex-direction'] = 'row',
--            ['align-items'] = 'stretch',
            ['background-color'] = '#eeeeff',
--            transition = 'left 0.2s ease-in-out'
        },
        ['tab-text'] = {
            lines = 1,
            ['text-overflow'] = 'ellipsis'
        },
        tabStyleDefault = {
            backgroundColor = '#aaaaFF',
            titleColor = '#666666',
            activeTitleColor = '#3D3D3D',
            activeBackgroundColor = '#9999FF',
            isActiveTitleBold = true,
            iconWidth = 70,
            iconHeight = 70,
            width = 100,
            height = 100,
            fontSize = 24,
            hasActiveBottom = false,
            activeBottomColor = '#9999ff',
            activeBottomWidth = 100,
            activeBottomHeight = 6,
            textPaddingLeft = 10,
            textPaddingRight = 10,
            leftOffset = 0
        }
    },
    instanceCount = 0,
    propertyMap = {}
}
--@summary:创建一个page列表
--@param table layout:布局数据
--			string	.id:布局id
--			table	.pages:布局子page源数据列表
--			table	.config:布局设置
--			int			.currentPage:初始化页面位置,默认为1
--			table		.tabTitles:子page标题列表
--			string			.activeIcon/icon:标题icon
--			string			.value:标题内容
--			int			.pageWidth/pageHeight:page尺寸
--			string		.wrapBackgroundColor:布局背景色
--			table		.tabStyle:布局菜单样式
--			string			.backgroundColor:菜单背景色
--			int				.height:菜单宽度
--			int				.leftOffset:菜单偏移
--			int				.iconWidth/iconHeight:icon尺寸
--			int				.fontSize:icon字体大小
--			bool			.isActiveTitleBold:激活的标题字体是否粗体
--			string			.activeTitleColor/titleColor:标题字体颜色
--			string			.activeBackgroundColor/backgroundColor:icon背景色
--			string			.activeBottomColor:下划线 背景色
--			table	.subviews:布局子页面
--			table			[1]:作为page列表的菜单栏
--@return table:subview:page列表
--		table		[1]:菜单栏...
--		table		[2]:内容...
--		table			view:
--		table			style:
--		table			subviews:子page内容
function wtab_page.createLayout(layout)
    if layout.id == nil then
        wtab_page.instanceCount = wtab_page.instanceCount + 1
    end
    local id = layout.id or 'wtab_page_' .. tostring(wtab_page.instanceCount)
    local tabPages = layout.pages
    local tpconfig = layout.config 
    local currentPage = tpconfig.currentPage or 1
    local tabTitles = tpconfig.tabTitles or {}

    if #tabPages ~= #tabTitles then
		dialog('Exception.wui.wtab_page.Init()页面与索引不匹配'..#tabPages..","..#tabTitles)
        return nil
    end

    local tabStyle = {}
    wutils.mergeTable(tabStyle, wtab_page.style.tabStyleDefault)
    wutils.mergeTable(tabStyle, tpconfig.tabStyle)
    local pageWidth = tpconfig.pageWidth or 750
    local pageHeight = tpconfig.pageHeight or 1334
    local wrapBackgroundColor = tpconfig.wrapBackgroundColor or '#f2f3f4'

    local layout = wtab_page.layout()
    layout.id = id
    wutils.mergeTable(layout.style , wtab_page.style['wui-tab-page'])
    layout.style['background-color'] = wrapBackgroundColor
    layout.style.width = pageWidth
    layout.style.height = pageHeight

    local subviews = layout.subviews

    local scroller = subviews[1]
    wutils.mergeTable(scroller.style, wtab_page.style['tab-title-list'])
    scroller.style['background-color'] = tabStyle.backgroundColor
    scroller.style.height = tabStyle.height
    scroller.style['padding-left'] = tabStyle.leftOffset

    for i, v in ipairs(tabTitles) do
        local itemId = id .. '_tab_item_' .. tostring(i)
        local itemLayout = wtab_page.itemLayout()
        itemLayout.id = itemId
        wutils.mergeTable(itemLayout.style, wtab_page.style['title-item'])
        itemLayout.style.width = tabStyle.width
        itemLayout.style.height = tabStyle.height
        itemLayout.style['background-color'] = currentPage == i and tabStyle.activeBackgroundColor or tabStyle.backgroundColor

        local image = itemLayout.subviews[1]
        image.style.width = tabStyle.iconWidth
        image.style.height = tabStyle.iconHeight
        v.activeIcon = v.activeIcon or ''
        v.icon = v.icon or ''
        image.src = currentPage == i and v.activeIcon or v.icon

        local text = itemLayout.subviews[2]
        wutils.mergeTable(text.style, wtab_page.style['tab-text'])
        text.style['font-size'] = tabStyle.fontSize
        text.style['font-weight'] = currentPage == i and tabStyle.isActiveTitleBold and 'bold' or 'normal'
        text.style.color = currentPage == i and tabStyle.activeTitleColor or tabStyle.titleColor
        text.style['padding-left'] = tabStyle.textPaddingLeft
        text.style['padding-right'] = tabStyle.textPaddingRight
        text.value = v.title

        local activeBottom = itemLayout.subviews[3]
        if tabStyle.hasActiveBottom then
            wutils.mergeTable(activeBottom.style, wtab_page.style['border-bottom'])
            activeBottom.style.width = tabStyle.activeBottomWidth
            activeBottom.style.left = (tabStyle.width-tabStyle.activeBottomWidth)/2
            activeBottom.style.height = tabStyle.activeBottomHeight
            activeBottom.style['background-color'] = currentPage == i and tabStyle.activeBottomColor or 'transparent'
        else
            activeBottom.style.visibility = 'hidden'
        end

        scroller.subviews[i] = itemLayout
    end

    subviews[2].style = wtab_page.style['tab-page-wrap']
    subviews[2].style.width = pageWidth
    subviews[2].style.height = pageHeight - tabStyle.height
    local tabContainer = subviews[2].subviews[1]
    tabContainer.style = wtab_page.style['tab-container']
    tabContainer.style.width = pageWidth * #tabTitles
    tabContainer.style.left = (currentPage - 1) * (-1 * pageWidth)
    tabContainer.subviews = tabPages and tabPages or {}

    wtab_page.propertyMap[id] = {}
    wtab_page.propertyMap[id].currentPage = currentPage
    wtab_page.propertyMap[id].tabStyle = tabStyle
    wtab_page.propertyMap[id].tabTitles = tabTitles
    wtab_page.propertyMap[id].pageWidth = pageWidth

    return layout
end


function wtab_page.createView(context, layout)
    layout.config = layout.config or {}
    local layout = wtab_page.createLayout(layout)
    if not layout then
        return nil
    end
    return context:createView(layout)
end

function wtab_page.setOnSelectedCallback(view, callback)
    local parentId = view:getID()
    local tabContainer = view:getSubview(2):getSubview(1)
    local scroller = view:getSubview(1)
    local subviewsCount = scroller:subviewsCount()

    local indexMap = {}
    local onClickeded = function (id, action)
        local currentPage = indexMap[id]
        if wtab_page.propertyMap[parentId].currentPage ~= currentPage then
            wtab_page.propertyMap[parentId].currentPage = currentPage
            local tabStyle = wtab_page.propertyMap[parentId].tabStyle
            local tabTitles = wtab_page.propertyMap[parentId].tabTitles

            for i = 1, subviewsCount do
                local backgroundColor = currentPage == i and tabStyle.activeBackgroundColor or tabStyle.backgroundColor
                local imageSrc = currentPage == i and tabTitles[i].activeIcon or tabTitles[i].icon
                local fontWeight = currentPage == i and tabStyle.isActiveTitleBold and 'bold' or 'normal'
                local textColor = currentPage == i and tabStyle.activeTitleColor or tabStyle.titleColor

                local itemView = scroller:getSubview(i)
                itemView:setStyle('background-color', backgroundColor)

                local image = itemView:getSubview(1)
                local text = itemView:getSubview(2)
                local activeBottom = itemView:getSubview(3)

                image:setAttr('src', imageSrc)
                text:setStyle('font-weight', fontWeight)
                text:setStyle('color', textColor)

                if tabStyle.hasActiveBottom then
                    local bkgColor = currentPage == i and tabStyle.activeBottomColor or 'transparent'
                    activeBottom:setStyle('background-color', bkgColor)
                end
            end

            tabContainer:setStyle('left', (currentPage - 1) * (-1 * wtab_page.propertyMap[parentId].pageWidth))

            if callback then
                callback(parentId, currentPage)
            end
        end

    end

    for i = 1, subviewsCount do
        local itemView = scroller:getSubview(i)
        local itemId = itemView:getID()
        indexMap[itemId] = i
        itemView:setActionCallback(UI.ACTION.CLICK, onClickeded)
    end
end

return wtab_page