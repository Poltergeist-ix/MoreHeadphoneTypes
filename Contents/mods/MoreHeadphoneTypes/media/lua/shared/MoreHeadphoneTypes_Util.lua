local Util = {}

function Util.setHeadphonesData(device,fullType)
    --  print("zxLog: ",device,fullType)

   device:getModData().hasHeadphoneFullType = fullType

    if not isClient() then return end

    local args = { fullType = fullType }
    if instanceof(device, "Radio") then
        local container = device:getContainer()
        if instanceof(container:getParent(), "IsoPlayer") then
            args.type = "playerInv"
            args.onlineID = container:getParent():getOnlineID()
            args.id = device:getID()
        end
    elseif instanceof(device, "IsoWaveSignal") then
        if device:getObjectIndex() ~= -1 then
            args.type = "IsoObject"
            args.x, args.y, args.z = device:getX(), device:getY(), device:getZ()
            args.index = device:getObjectIndex()
        end
    elseif instanceof(device, "VehiclePart") then
        args.type = "VehiclePart"
        args.vehicleId = device:getVehicle():getId()
        args.index = device:getIndex()
    end

    if args.type ~= nil then sendClientCommand("MoreHeadphoneTypes","setHeadphones",args) end
end

function Util.setHeadphonesDataFromArgs(args)
    -- print("zxLog: ",args.type,args.fullType)
    
    local dataObject
    if args.type == "playerInv" then
        local player = getPlayerByOnlineID(args.onlineID)
        if not player then return end
        dataObject = player:getInventory():getItemWithID(args.id)
        if not dataObject then return end
    elseif args.type == "IsoObject" then
        local square = getSquare(args.x,args.y,args.z)
        if not square or square:getObjects():size() > args.index then return end
        dataObject = square:getObjects():get(args.index)
        if not instanceof(dataObject,"IsoWaveSignal") then return end
    elseif args.type == "VehiclePart" then
        local vehicle = getVehicleById(args.vehicleId)
        if not vehicle then return end
        dataObject = vehicle:getPartByIndex(args.index)
        if not dataObject or not dataObject:getDeviceData() then return end
    end

    if dataObject ~= nil then
        dataObject:getModData().hasHeadphoneFullType = args.fullType
    end
end

return Util