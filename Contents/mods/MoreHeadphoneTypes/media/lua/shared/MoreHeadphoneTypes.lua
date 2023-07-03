local Mod = {
    fullTypeMap = {},
    integerMap = nil,---saved as GlobalModData
}

function Mod.add(fullType)
    Mod.fullTypeMap[fullType] = -1
end

function Mod.init(data)
    -- Mod.integerMap = ModData.getOrCreate("MoreHeadphoneTypes")
    Mod.integerMap = data
    if table.isempty(Mod.integerMap) then
        Mod.integerMap[0] = "Base.Headphones"
        Mod.integerMap[1] = "Base.Earbuds"
    end

    for i,fullType in ipairs(Mod.integerMap) do
        Mod.fullTypeMap[fullType] = i
    end
    for fullType,v in pairs(Mod.fullTypeMap) do
        if v == -1 then
            table.insert(Mod.integerMap,fullType)
            Mod.fullTypeMap[fullType] = #Mod.integerMap
        end
    end
end

if not isClient() then
    Events.OnInitGlobalModData.Add(function()
        Mod.init(ModData.getOrCreate("MoreHeadphoneTypes"))
    end)
else
    ModData.request("MoreHeadphoneTypes")
    Events.OnReceiveGlobalModData.Add(function(name,data)
        if name == "MoreHeadphoneTypes" then
            Mod.init(data)
        end
    end)
end

return Mod