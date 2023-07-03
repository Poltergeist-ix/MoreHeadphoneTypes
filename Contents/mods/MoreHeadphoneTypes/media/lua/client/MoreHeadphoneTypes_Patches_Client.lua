local Mod = require "MoreHeadphoneTypes"

function MoreHeadphoneTypes_Patches.patch_RWMVolume()

    local verifyItem = RWMVolume.verifyItem
    RWMVolume.verifyItem = function(self,item)
        return item:hasTag("Headphones") or verifyItem(self,item)
    end

    local update = RWMVolume.update
    RWMVolume.update = function(self)
        update(self)

        if self.deviceData and self.deviceData:getHeadphoneType() >= 0 then
            if not self.deviceData:getParent():getModData().hasHeadphoneFullType then
                self.deviceData:getParent():getModData().hasHeadphoneFullType = self.deviceData:getHeadphoneType() == 0 and "Base.Headphones" or "Base.Earbuds"
            end
            if self.prevHeadphoneType ~= self.deviceData:getParent():getModData().hasHeadphoneFullType then
                self.storedItemFakeTexture = getScriptManager():getItem(self.deviceData:getParent():getModData().hasHeadphoneFullType):getNormalTexture()
                self.prevHeadphoneType = self.deviceData:getParent():getModData().hasHeadphoneFullType
            end
            self.itemDropBox:setStoredItemFake(self.storedItemFakeTexture)
        end
    end

end
