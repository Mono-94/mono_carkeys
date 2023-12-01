Carkey               = {}

Carkey.Lang          = 'EN' -- ES/EN/PL/FR/IT/PT

Carkey.Button        = 'U'  -- open / close vehicle

Carkey.Delay         = 2000 -- 2s

Carkey.inventory     = 'ox_inventory' -- ox_inventory / qs-inventory

Carkey.Item          = 'carkeys'      -- CarKey Item

Carkey.Notifications = 'ox_lib'       -- ox_lib/esx


---Notifi
function Notifi(data)
    if Carkey.Notifications == 'ox_lib' then
        TriggerEvent('ox_lib:notify', {
            title = data.title or 'CarKeys',
            description = data.text or data,
            position = data.position or 'top-right',
            style = {
                backgroundColor = '#292929',
                color = '#c2c2c2',
                ['.description'] = {
                    color = '#cccccc'
                }
            },
            icon = data.icon or 'car',
            iconColor = data.color or '#d46363'
        })
    elseif Carkey.Notifications == 'esx' then
        TriggerEvent('esx:showNotification', data.text, "success", 3000)
    end
end

function PlateEqual(valueA, valueB)
    valueA = tostring(valueA)
    valueB = tostring(valueB)
    valueA = valueA:gsub("%s", ""):lower()
    valueB = valueB:gsub("%s", ""):lower()
    return valueA == valueB
end
