
  #
  <sub> <center> Discord https://discord.gg/Vk7eY8xYV2 </center></sub>
  
# <center>**SY_CARKEYS**</center>
<center><img src="https://i.imgur.com/45ygmFr.png"></center>

#
#
# <center>**Features**</center>
* Turn on and off the vehicle engine using the corresponding assigned key to the vehicle  (optional, Keys.Engine).
* You can hold down the F key when exiting the vehicle to keep the engine running, if you have the vehicle keys. (Optional, Keys.OnExitCar)
* Retrieve lost keys through an NPC that can be easily added in the Config.lua file.(In the config.lua file, you can edit the NPC to acquire the license plate. Keep in mind that if you set BuyNewPlate to true, the NPC will only sell license plates and not keys)
* Administrators can create keys for the vehicle they are in, as well as for other players using their ID.
* NPC-owned vehicles will be parked with their doors closed, and will be turned off if opened (This option is disabled by default since it is not 100% finished. It will block all kinds of vehicles, including those with NPCs inside. In the future, only vehicles without NPCs will be affected. Keys.CloseDoorsNPC).
* Lockpicking system with skill check, allowing players to force entry into vehicles (includes a function in the Config.lua file to optionally add a dispatch system).
* Includes a tool called "Wire Cutters" with skill check, allowing players to hotwire previously forced vehicles (optional).
* The license plate item allows the player to customize both the color and the license plate of their vehicle. (This will change the license plate in the database)
* Keybind to open/close the vehicle. (Default key is U, can be changed in the Config.lua file.)
* Keybind to turn on/off the engine. (Default key is M, can be changed in the Config.lua file. Optional) 
#
#
#  <center>**Commands Admins**</center>
* **/givekey [ID]** - *With this command, you can obtain a key for the vehicle you are currently in, or you can use the ID of a player who is in a vehicle to give them a key to that vehicle.*

* **/delkey [ID]** - *With this command, you can delete the key for the vehicle you are currently in.*

# 
#


# <center> **Events y exports**</center>

* To obtain a key for a nearby vehicle with a ProgressBar:
```LUA
exports['sy_carkeys']:CarKey(time) -- Waiting time of the ProgressBar
-- exports['sy_carkeys']:CarKey(1000)           1000 = 1s
```
* To generate a key with a wait time for the player to enter the vehicle and obtain its license plate:
```LUA
exports['sy_carkeys']:CarKeyBuy(time) --The time can be adjusted as needed and allows waiting for the player who is inside the vehicle.

-- exports['sy_carkeys']:CarKeyBuy(1000)           1000 = 1s
```
* Create Key event:
```LUA
local ped = PlayerPedId()
local vehicle = GetVehiclePedIsUsing(ped)
local model = GetEntityModel(vehicle)
local name = GetDisplayNameFromVehicleModel(model)
local plate = GetVehicleNumberPlateText(vehicle)
TriggerServerEvent('sy_carkeys:CreateKey', plate, name)  
```
* To delete the key of a player in their current vehicle (useful for when a player returns a work vehicle):
```LUA
TriggerEvent('sy_carkeys:DeleteClientKey', count)
```
* To delete specific keys:
```LUA
local ped = PlayerPedId()
local vehicle = GetVehiclePedIsUsing(ped)
local model = GetEntityModel(vehicle)
local name = GetDisplayNameFromVehicleModel(model)
local plate = GetVehicleNumberPlateText(vehicle)
TriggerServerEvent('sy_carkeys:DeleteKey', count, plate, name)  
```
* LockPick:
```LUA
exports['sy_carkeys']:LockPick()
```
* HotWire:
```LUA
exports['sy_carkeys']:HotWire()
```
* Change Plate:
```LUA
exports['sy_carkeys']:SetMatricula()
```
#
#
#  <center>**Ox inventory Item's**</center>
```LUA
['carkeys'] = {
	label = 'Car Key',
	weight = 5,
	stack = true
},

['ganzua'] = {
	label = 'Lockpick',
	weight = 25,
	stack = true,
	client = {
		export = 'sy_carkeys.LockPick'
	}
},

['alicates'] = {
	label = 'Wire Cutters',
	weight = 50,
	stack = true,
	client = {
		export = 'sy_carkeys.HotWire'
	}
},
['plate'] = {
	label = 'Plate',
	weight = 500,
	stack = true,
	client = {
		export = 'sy_carkeys.SetMatricula'
	}
},

 ```
#
#
# <center> **Preview**</center>
 * Change Plate -  https://streamable.com/goz7ya
 * keys and menu recovery - https://streamable.com/akf84k
 * LockPick & HotWire - https://streamable.com/nps2uq
#
#
# <center> **Dependencies**</center>
 - ox_lib  -  https://github.com/overextended/ox_lib/releases  
 - ox_inventory  -  https://github.com/overextended/ox_inventory/releases  
 - ox_target  -  https://github.com/overextended/ox_target/releases  



