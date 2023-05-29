
function CreateBlip(Position, Sprite, Display, Scale, Colour, ShortRange, Name)
    local blip = AddBlipForCoord(Position.x, Position.y, Position.z)
    SetBlipSprite(blip, Sprite)
    SetBlipDisplay(blip, Display)
    SetBlipScale(blip, Scale)
    SetBlipColour(blip, Colour)
    SetBlipAsShortRange(blip, ShortRange)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Name)
    EndTextCommandSetBlipName(blip)
end

function SetPedPos(Hash, Pos, Scenario)
    RequestModel(Hash)
    while not HasModelLoaded(Hash) do Wait(0) end
    NPC = CreatePed(2, Hash, Pos.x, Pos.y, Pos.z, Pos.w, false, false)
    SetPedFleeAttributes(NPC, 0, 0)
    SetPedDiesWhenInjured(NPC, false)
    if Scenario == false then else
        TaskStartScenarioInPlace(NPC, Scenario, 0, true)
    end
    SetPedKeepTask(NPC, true)
    SetBlockingOfNonTemporaryEvents(NPC, true)
    SetEntityInvincible(NPC, true)
    FreezeEntityPosition(NPC, true)
end

CreateThread(function()
    for k, v in pairs(Keys.NpcReclameKey) do
        if v.Blip then
            CreateBlip(v.pos, v.Sprite, v.Display, v.Scale, v.Colour, v.ShortRange, locale('cerrajero'))
        end
        SetPedPos(v.hash, v.pos, v.PedScenario)
        exports.ox_target:addBoxZone({
            coords = vec3(v.pos.x, v.pos.y, v.pos.z + 1),
            size = vec3(1, 1, 2),
            rotation = v.pos.w,
            debug = v.debug,
            options = {
                {
                    icon = v.icon,
                    label = v.label,
                    onSelect = function()
                        MenuKeys(v.price, v.tiempoprogress)
                    end
                }
            }
        })
    end
end)


function MenuKeys(precio, tiempoprogress)
    local KeyMenu = {}
    local vehicles = lib.callback.await('mono_carkeys:getVehicles')
    if vehicles == nil then
        TriggerEvent('mono_carkeys:Notification', locale('title'), locale('nopropio'), 'alert')
        return
    end
    for i = 1, #vehicles do
        local data = vehicles[i]
        local name = GetDisplayNameFromVehicleModel(data.vehicle.model)
        local marca = GetMakeNameFromVehicleModel(data.vehicle.model)
        local plate = data.vehicle.plate
        local price = precio
        table.insert(KeyMenu, {
            title = marca .. ' - ' .. name,
            iconColor = '#81cdeb',
            icon = 'car-side',
            arrow = true,
            description = locale('matricula', plate),
            metadata = { { label = 'Price', value = price .. '$' } },
            onSelect = function()
                local alert = lib.alertDialog({
                    header = locale('buy_key_confirm1'),
                    content = locale('buy_key_confirm2', plate, marca, name,
                        price),
                    centered = true,
                    cancel = true
                })
                if alert == 'cancel' then
                    MenuKeys(price)
                    return
                else
                    if lib.progressBar({
                            duration = tiempoprogress,
                            label = locale('forjar'),
                            useWhileDead = false,
                            canCancel = false,
                            disable = {
                                car = true,
                                move = true,

                            },
                            anim = {
                                dict = 'missheistdockssetup1clipboard@base',
                                clip = 'base'
                            },
                            prop = {
                                model = `prop_notepad_01`,
                                bone = 18905,
                                pos = vec3(0.1, 0.02, 0.05),
                                rot = vec3(10.0, 0.0, 0.0)
                            },
                        })
                    then
                        TriggerServerEvent('mono_carkeys:BuyKeys', plate, price)
                    end
                end
            end
        })
    end
    lib.registerContext({
        id = 'mono_carkeys:SelectCarKey',
        title = locale('cerrajero'),
        options = KeyMenu
    })

    lib.showContext('mono_carkeys:SelectCarKey')
end

