Encrypt={
	AesKey="0000000000000000",
}
crypto=require "crypto"
function Encrypt:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
function Encrypt:AesEncrypt(raw)
	--local result= crypto.base64Encode(crypto.aes128ecbEncrypt("0000000000000000",self.AesKey))
	local result=crypto.base64Encode(raw)
	return result
end
function Encrypt:AesDecrypt(raw)

end

