Encrypt={
	AesKey="[48/*Serfend.e;]",
}
crypto=require "crypto"
function Encrypt:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
function Encrypt:AesEncrypt(raw)
	local result= crypto.base64Encode(crypto.aes128ecbEncrypt(raw,self.AesKey))
	return result
end
function Encrypt:AesDecrypt(raw)

end

