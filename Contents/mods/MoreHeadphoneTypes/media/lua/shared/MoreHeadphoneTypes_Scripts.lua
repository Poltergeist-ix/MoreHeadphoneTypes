do
    local manager = getScriptManager()
    for _,name in ipairs({"Headphones","Earbuds"}) do
        local item = manager:getItem(name)
        local tags = item:getTags()
        if not tags:contains("Headphones") then tags:add("Headphones") end
    end
end