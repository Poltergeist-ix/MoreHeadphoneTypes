if not isServer() then return end
local Util = require "MoreHeadphoneTypes_Util"

Events.OnClientCommand.Add(function(module,command,player,args)
    if module == "MoreHeadphoneTypes" then
        if command == "setHeadphones" then
            Util.setHeadphonesDataFromArgs(args)
            if args.type ~= nil then sendServerCommand("MoreHeadphoneTypes","setHeadphones",args) end
        end
    end
end)