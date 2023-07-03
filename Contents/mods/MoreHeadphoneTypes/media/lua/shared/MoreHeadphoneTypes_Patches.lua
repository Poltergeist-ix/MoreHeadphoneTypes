local Mod = require "MoreHeadphoneTypes"

MoreHeadphoneTypes_Patches = {}

function MoreHeadphoneTypes_Patches.patchDeviceData()
    local mt = __classmetatables[DeviceData.class].__index

    -- local addHeadPhones = mt.addHeadphones
    mt.addHeadphones = function(self,item)
        --TODO: check if need check headphoneType, container
        if Mod.fullTypeMap[item:getFullType()] then
            ISRemoveItemTool.removeItem(item,getPlayer())
            self:setHeadphoneType(Mod.fullTypeMap[item:getFullType()])
            -- self:transmitDeviceDataState(6)
        -- else
        --     return addHeadPhones(self,item)
        end
    end

    -- local getHeadphones = mt.getHeadphones
    mt.getHeadphones = function(self,container)
        if self:getHeadphoneType() >= 0 then
            local fullType = Mod.integerMap[self:getHeadphoneType()]
            if fullType ~= nil then
                local item = InventoryItemFactory.CreateItem(fullType)
                if item ~= nil then
                    container:AddItem(item)
                end
            end
            self:setHeadphoneType(-1)
            -- self:transmitDeviceDataState(6)
        end
    end

end