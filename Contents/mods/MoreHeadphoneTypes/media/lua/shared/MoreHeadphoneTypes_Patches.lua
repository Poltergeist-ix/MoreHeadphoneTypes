local Mod = require "MoreHeadphoneTypes"

MoreHeadphoneTypes_Patches = {}

function MoreHeadphoneTypes_Patches.patchDeviceData()
    local mt = __classmetatables[DeviceData.class].__index

    local addHeadphones = mt.addHeadphones
    mt.addHeadphones = function(self,item)
        if item:hasTag("Headphones") then
            local container = item:getContainer() or InventoryItemFactory.CreateItem("Base.Garbagebag"):getInventory()
            addHeadphones(self,container:AddItem("Base.Earbuds"))

            self:getParent():getModData().hasHeadphoneFullType = item:getFullType()
            pcall(ISRemoveItemTool.removeItem,item,getPlayer())
        end
    end

    local getHeadphones = mt.getHeadphones
    mt.getHeadphones = function(self,container)
        local fullType = self:getParent():getModData().hasHeadphoneFullType
        if fullType ~= nil then
            local item = InventoryItemFactory.CreateItem(fullType)
            if item ~= nil then
                container:AddItem(item)
            end
            self:getParent():getModData().hasHeadphoneFullType = nil

            getHeadphones(self,InventoryItemFactory.CreateItem("Base.Garbagebag"):getInventory())
        else
            return getHeadphones(self,container)
        end
    end

end