local ox = exports.ox_inventory

-- Inventory give/remove KEYS
---@param data any
---@param action any
function InventoryKeys(action, data)
    data.plate = string.gsub(data.plate, "%s", "")
    local metaData = {
        plate       = data.plate,
        description = Text('PlateMetadata', data.plate)
    }
    if action == 'add' then
        if Carkey.inventory == 'ox' then
            ox:AddItem(data.player, Carkey.Item, 1, metaData)
        elseif Carkey.inventory == 'qs' then
            exports['qs-inventory']:AddItem(data.player, Carkey.Item, 1, nil, metaData)
        elseif Carkey.inventory == 'custom' then
            -- custom
        end
    elseif action == 'remove' then
        if Carkey.inventory == 'ox' then
            ox:RemoveItem(data.player, Carkey.Item, 1, metaData)
        elseif Carkey.inventory == 'qs' then
            exports['qs-inventory']:RemoveItem(data.player, Carkey.Item, 1, nil, metaData)
        elseif Carkey.inventory == 'custom' then
            -- custom
        end
    end
end

exports('InventoryKeys', InventoryKeys)

lib.callback.register('mono_carkeys:InventoryKeys', function(source, action, plate)
    InventoryKeys(action, { player = source, plate = plate })
end)


---Close all vehicle doors
---@param entity number
AddEventHandler('entityCreated', function(entity)
    if not DoesEntityExist(entity) then return end

    local entityType = GetEntityType(entity)

    if entityType ~= 2 then return end

    if GetEntityPopulationType(entity) > 5 then return end

    SetVehicleDoorsLocked(entity, 2)
end)