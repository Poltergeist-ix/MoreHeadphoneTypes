local Mod = require "MoreHeadphoneTypes"

function MoreHeadphoneTypes_Patches.patch_RWMVolume()
    RWMVolume.headPhoneTypeTextures = {}
    local function updateTexture(self,intType)
        if intType > 1 then
            if not self.headPhoneTypeTextures[intType] then
                local item = getScriptManager():getItem(Mod.integerMap[intType])
                if not item then
                    self.deviceData:removeHeadphones()
                else
                    self.headPhoneTypeTextures[intType] = item:getNormalTexture()
                end
            end
            self.itemDropBox:setStoredItemFake(self.headPhoneTypeTextures[intType])
        end
    end

    local verifyItem = RWMVolume.verifyItem
    RWMVolume.verifyItem = function(self,item)
        return Mod.fullTypeMap[item:getFullType()] ~= nil or verifyItem(self,item)
    end

    local update = RWMVolume.update
    RWMVolume.update = function(self)
        update(self)

        if self.deviceData then updateTexture(self,self.deviceData:getHeadphoneType()) end
    end

end
