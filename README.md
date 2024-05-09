# DEPRACATED 
# NEW VERSION 
# https://github.com/Mono-94/mGarage
# https://github.com/Mono-94/mVehicle
# DEPRACATED 
# NEW VERSION 
# https://github.com/Mono-94/mGarage
# https://github.com/Mono-94/mVehicle
# DEPRACATED 
# NEW VERSION 
# https://github.com/Mono-94/mGarage
# https://github.com/Mono-94/mVehicle


# <center>   MONO  CARKEYS

# ❗ Dependencies 
- ox_lib - https://github.com/overextended/ox_lib
- ox_inventory - https://github.com/overextended/ox_inventory
 
- Available languages: **ES** | **EN** | **PL** | **FR** | **IT** | **PT**

# 🔩 Exports / Events
## Client / Server
- Set Vehicle Doors Status 
```lua
    Entity(VehicleEntity).state.MonoCarKeys = doorstatus
```
### GetVehicleDoorLockStatus()  https://docs.fivem.net/natives/?_0xD72CEF2
- None = 0,
- Locked = 2,
- LockedForPlayer = 3,
- StickPlayerInside = 4, -- Doesn't allow players to exit the vehicle with the exit vehicle key.
- CanBeBrokenInto = 7, -- Can be broken into the car. If the glass is broken, the value will be set to 1
- CanBeBrokenIntoPersist = 8, -- Can be broken into persist
- CannotBeTriedToEnter = 10, -- Cannot be tried to enter (Nothing happens when you press the vehicle enter key).


## Client

- Give or Remove Keys
```lua
--  actio = 'add' or 'revome'
    exports.mono_carkeys:ClientInventoryKeys(action, plate) 
```
- Get Player Key
```lua
    local havekey, entity, inCar, ped = exports.mono_carkeys:GetPlayerKey()
    --  return havekey, entity, inCar, ped 
```
## Server

- Give or Remove Keys
```lua
    local source = source -- Source Player 
    local action = 'add' --  'add' or 'revome'
    exports.mono_carkeys:InventoryKeys(action, { plate = plate, player = source})
```

# 📦 Item

- carkeys 
```lua
    ['carkeys']  = {
		label = 'Car Keys',
		weight = 10,
		stack = true,
	},
```
