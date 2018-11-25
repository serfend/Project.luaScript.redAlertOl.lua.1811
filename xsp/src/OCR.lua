OCR = {
	ocrMapPos,ocrNumBold, msg = nil,nil,nil,
}--初始化
function OCR:showError()
	dialog("加载字库错误:"..self.msg)
	lua_exit()
end
local tessocr=require('tessocr_3.05.02')
function OCR:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
	self.ocrMapPos,self.msg=tessocr.create({
		path = "res/", -- 自定义字库暂时只能放在脚本res/目录下
		lang = "num", -- 使用生成的num.traineddata文件
		
	})
	
	if self.ocrMapPos==nil then
		self:showError()
	end
    return o
end
function OCR:GetMapPos(x,y,w,h,foreColor)
	local rect = {x1, y1, x2, y2}
	local diff = {foreColor or "0xffffff-0x0f0f0f"}
	local code, text = self.ocrMapPos:getText(Rect(x,y,w,h),diff)
	
	return code ,text
end
