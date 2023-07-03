if not isClient() then return end

local Util = require "MoreHeadphoneTypes_Util"

Events.OnServerCommand.Add(function(module,command,args)
    if module == "MoreHeadphoneTypes" then
        if command == "setHeadphones" then
            Util.setHeadphonesDataFromArgs(args)
        end
    end
end)