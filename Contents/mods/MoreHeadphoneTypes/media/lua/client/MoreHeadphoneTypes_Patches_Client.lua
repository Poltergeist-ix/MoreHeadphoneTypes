local volumeElementPatch = function(o)
    local verifyItem = o.verifyItem
    o.verifyItem = function(self,item)
        return item:hasTag("Headphones") or verifyItem(self,item)
    end

    local update = o.update
    o.update = function(self)
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
            -- self.itemDropBox:setStoredItemFake(getScriptManager():getItem(self.deviceData:getParent():getModData().hasHeadphoneFullType):getNormalTexture()) --Fixme
        end
    end

    local onJoypadDown = o.onJoypadDown
    o.onJoypadDown = function(self, button)
        if button == Joypad.XButton and self.deviceData:getHeadphoneType() == -1 then
            -- onJoypadDown(self,button)
            -- if self.deviceData:getHeadphoneType() == -1 then
                local headphone = self.player:getInventory():getFirstTag("Headphones")
                if headphone ~= nil then self:addHeadphone(headphone) end
            -- end
        else
            return onJoypadDown(self,button)
        end
    end

    local getXPrompt = o.getXPrompt
    o.getXPrompt = function(self)
        return getXPrompt(self) or self.deviceData:getHeadphoneType() == -1 and self.player:getInventory():getFirstTag("Headphones") ~= nil and getText("IGUI_RadioAddHeadphones")
    end
end

---Patch Volume Element
function MoreHeadphoneTypes_Patches.patch_RWMVolume()
    volumeElementPatch(RWMVolume)
end

---Patch Volume Element of True Music Copy
if getActivatedMods():contains("truemusic") then
    function MoreHeadphoneTypes_Patches.patch_TCRWMVolume()
        volumeElementPatch(TCRWMVolume)
    end
end
