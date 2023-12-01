
local delay = false


function GetPlayerKey(vehicle)
    local Ped = PlayerPedId()
    local coords = GetEntityCoords(Ped)
    local inAcar = IsPedInAnyVehicle(Ped, true)
    local entity = vehicle or lib.getClosestVehicle(coords, 5, true)
    local plate = GetVehicleNumberPlateText(entity)
    if Carkey.inventory == 'ox_inventory' then
        local keys = exports.ox_inventory:Search('slots', Carkey.Item)
        for i, v in ipairs(keys) do
            if PlateEqual(v.metadata.plate, plate) then
                return true, entity, inAcar, Ped
            end
        end
    elseif Carkey.inventory == 'qs-inventory' then
        local items = exports['qs-inventory']:getUserInventory()
        for item, meta in pairs(items) do
            if PlateEqual(meta.info.plate, plate) then
                return true, entity, inAcar, Ped
            end
        end
    end
    
    return false, entity, inAcar, Ped
end

exports('GetPlayerKey', GetPlayerKey)

AddStateBagChangeHandler('MonoCarKeys', nil, function(bagName, key, value, _unused, replicated)
    if not value then return end

    local entity = GetEntityFromStateBagName(bagName)

    if NetworkGetEntityOwner(entity) ~= PlayerId() then return end

    SetVehicleDoorsLocked(entity, value)

    Entity(entity).state:set('MonoCarKeys', nil, true)
end)


exports('ClientInventoryKeys', function(action, plate)
    lib.callback('mono_carkeys:InventoryKeys', nil, source, action, plate)
end)


function VehicleDoors()
    local havekey, entity, inCar, ped = GetPlayerKey()
    if not havekey then return end
    local nameCar = GetDisplayNameFromVehicleModel(GetEntityModel(entity))
    local markCar = GetMakeNameFromVehicleModel(GetEntityModel(entity))
    local fullname = ((nameCar .. ' - ' .. markCar):lower()):gsub("(%a)([%w_']*)", function(first, rest) return first:upper() .. rest:lower() end)
    if not delay then
        if DoesEntityExist(entity) then
            if not inCar then AnimKeys(ped) end
            if GetVehicleDoorLockStatus(entity) == 2 then
                Entity(entity).state.MonoCarKeys = 0
                PlayVehicleDoorCloseSound(entity, 1)
                PlaySoundFromEntity(-1, "Remote_Control_Close", entity, "PI_Menu_Sounds", 1, 0)
                Notifi({ title = fullname, text = Text('VehicleOpen'), icon = 'lock-open', color = '#64cc69' })
                delay = true
                Citizen.Wait(Carkey.Delay)
                delay = false
            else
                Entity(entity).state.MonoCarKeys = 2
                PlayVehicleDoorCloseSound(entity, 1)
                PlaySoundFromEntity(-1, "Remote_Control_Fob", entity, "PI_Menu_Sounds", 1, 0)
                Notifi({ title = fullname, text = Text('VehicleClose'), icon = 'lock', color = '#cc6493' })
                delay = true
                Citizen.Wait(Carkey.Delay)
                delay = false
            end
            SetVehicleLights(entity, 2)
            Citizen.Wait(250)
            SetVehicleLights(entity, 0)
            Citizen.Wait(250)
            SetVehicleLights(entity, 2)
            Citizen.Wait(250)
            SetVehicleLights(entity, 0)
            Citizen.Wait(750)
        end
    end
end

function AnimKeys(ped)
    RequestModel('p_car_keys_01')

    while not HasModelLoaded('p_car_keys_01') do
        Wait(1)
    end
    local prop = CreateObject('p_car_keys_01', 1.0, 1.0, 1.0, 1, 1, 0)

    RequestAnimDict("anim@mp_player_intmenu@key_fob@")

    AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.039, 0.0, 0.0, 0.0, 0.0,
        true, true, false, true, 1, true)
    TaskPlayAnim(ped, "anim@mp_player_intmenu@key_fob@", "fob_click_fp", 8.0, 8.0, -1, 48, 1, false,
        false, false)
    Citizen.Wait(1000)
    DeleteObject(prop)
end

lib.addKeybind({
    name = 'mono_carkeys',
    description = Text('DoorsVehicleKeyBind'),
    defaultKey = Carkey.Button,
    onPressed = function()
        VehicleDoors()
    end
})

local TryingToEnterVehicle = nil

TryingToEnterVehicle = SetInterval(function()
    local ped = cache.ped
    local veh = GetVehiclePedIsTryingToEnter(ped)
    local lock = GetVehicleDoorLockStatus(veh)
    if DoesEntityExist(veh) then
        if lock == 2 then
            ClearPedTasks(ped)
        elseif lock == 0 then
            if GetIsVehicleEngineRunning(veh) == false then
                SetVehicleNeedsToBeHotwired(veh, false)
                SetVehicleEngineOn(veh, false, true, true)
            end
        end
        if GetIsVehicleEngineRunning(veh) == false then
            return
        end
    else
        SetInterval(TryingToEnterVehicle, 500)
    end
end, 0)
