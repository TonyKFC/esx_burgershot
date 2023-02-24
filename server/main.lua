ESX = exports["es_extended"]:getSharedObject()
local xPlayer = ESX.GetPlayerFromId(source)
local GetCurrentResourceName = GetCurrentResourceName()
local ox_inventory = exports.ox_inventory
lib.locale()


if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'burgershot', Config.MaxInService)
end
TriggerEvent('esx_society:registerSociety', 'burgershot', 'burgershot', 'society_burgershot', 'society_burgershot', 'society_burgershot', {type = 'private'})


RegisterServerEvent('esx_burgershotcooking:serverburger')
AddEventHandler('esx_burgershotcooking:serverburger', function()
	
  local Player = source
  exports.ox_inventory:RemoveItem(Player, 'vbread', 1)
  exports.ox_inventory:RemoveItem(Player, 'ccheese', 1)
  exports.ox_inventory:RemoveItem(Player, 'fburger', 1)
  exports.ox_inventory:RemoveItem(Player, 'lettuce', 1)
  exports.ox_inventory:RemoveItem(Player, 'ctomato', 1)
  local success = exports.ox_inventory:AddItem(Player, 'fvburger', 1)
 
 
end)

RegisterServerEvent('esx_burgershotcooking:servernuggets')
AddEventHandler('esx_burgershotcooking:servernuggets', function()

  local Player = source
  exports.ox_inventory:RemoveItem(Player, 'nuggets10', 1)
  local success = exports.ox_inventory:AddItem(Player, 'nugget', 10)


end)


RegisterServerEvent('esx_burgershotcooking:servercheese')
AddEventHandler('esx_burgershotcooking:servercheese', function()

  local Player = source
  exports.ox_inventory:RemoveItem(Player, 'potato', 1)
  local success = exports.ox_inventory:AddItem(Player, 'cheese', 10)


end)

RegisterServerEvent('esx_burgershotcooking:servercolala')
AddEventHandler('esx_burgershotcooking:servercolala', function()

  local Player = source
  exports.ox_inventory:RemoveItem(Player, 'icee', 5)
  local success = exports.ox_inventory:AddItem(Player, 'colala', 2) 
 
end)

 

local stashes = {

 
	{
		 
		id = 'burgershotFridge',
		label = locale('burgershotFridge'),
		slots = 50,
		weight = 100000,
		owner = false,
		jobs = 'burgershot' 
	},


	{
		 
		id = 'dinnerplate1',
		label = locale('dinnerplate1'),
		slots = 20,
		weight = 50000,
		owner = false,
		jobs = false
	},
	{
	 
		id = 'dinnerplate2',
		label = locale('dinnerplate2'),
		slots = 20,
		weight = 50000,
		owner = false,
		jobs = false
	},
	{
		id = 'dinnerplate3',
		label = locale('dinnerplate3'),
		slots = 20,
		weight = 50000,
		owner = false,
		jobs = false
	},
	{
		id = 'dinnerplate4',
		label = locale('dinnerplate4'),
		slots = 20,
		weight = 50000,
		owner = false,
		jobs = false
	},
	{
		id = 'dinnerplate5',
		label = locale('dinnerplate5'),
		slots = 20,
		weight = 50000,
		owner = false,
		jobs = false
	},
}

AddEventHandler('onServerResourceStart', function(resourceName)

	if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName then
		for i=1, #stashes do
			local stash = stashes[i]
			ox_inventory:RegisterStash(stash.id, stash.label, stash.slots, stash.weight, stash.owner, stash.jobs)
		end
	end

end)
 
RegisterServerEvent('burgershotFridge:addicee')
AddEventHandler('burgershotFridge:addicee', function()
	local count = exports.ox_inventory:GetItem('burgershotFridge', 'icee', nil, true)
	if count < 100 then
		local success = exports.ox_inventory:AddItem('burgershotFridge', 'icee', 100)
	end
    
end)

RegisterServerEvent('vbread:add')
AddEventHandler('vbread:add', function(indivual)

	local Player = source
	local money = exports.ox_inventory:Search(Player, 'count','money')
	local price = tonumber(indivual * 5)
	if money >= price then
		exports.ox_inventory:RemoveItem(Player, 'money', price)
		local success = exports.ox_inventory:AddItem(Player, 'vbread', indivual)
   	else
		TriggerClientEvent('ox_lib:notify', Player, {title = locale('shot'), description = locale('enoughcash'), type = 'error'})
	end

end)



RegisterServerEvent('ccheese:add')
AddEventHandler('ccheese:add', function(indivual)
	
	local Player = source
	local money = exports.ox_inventory:Search(Player, 'count','money')
	local price = tonumber(indivual * 5)
	if money >= price then
		exports.ox_inventory:RemoveItem(Player, 'money', price)
		local success = exports.ox_inventory:AddItem(Player, 'ccheese', indivual)
   	else
		TriggerClientEvent('ox_lib:notify', Player, {title = locale('shot'), description = locale('enoughcash'), type = 'error'})
	end

end)

RegisterServerEvent('fburger:add')
AddEventHandler('fburger:add', function(indivual)
	
	local Player = source
	local money = exports.ox_inventory:Search(Player, 'count','money')
	local price = tonumber(indivual * 5)
	if money >= price then
		exports.ox_inventory:RemoveItem(Player, 'money', price)
		local success = exports.ox_inventory:AddItem(Player, 'fburger', indivual)
   	else
		TriggerClientEvent('ox_lib:notify', Player, {title = locale('shot'), description = locale('enoughcash'), type = 'error'})
	end

end)

RegisterServerEvent('lettuce:add')
AddEventHandler('lettuce:add', function(indivual)
	
	local Player = source
	local money = exports.ox_inventory:Search(Player, 'count','money')
	local price = tonumber(indivual * 5)
	if money >= price then
		exports.ox_inventory:RemoveItem(Player, 'money', price)
		local success = exports.ox_inventory:AddItem(Player, 'lettuce', indivual)
   	else
		TriggerClientEvent('ox_lib:notify', Player, {title = locale('shot'), description = locale('enoughcash'), type = 'error'})
	end

end)

RegisterServerEvent('ctomato:add')
AddEventHandler('ctomato:add', function(indivual)
	
	local Player = source
	local money = exports.ox_inventory:Search(Player, 'count','money')
	local price = tonumber(indivual * 5)
	if money >= price then
		exports.ox_inventory:RemoveItem(Player, 'money', price)
		local success = exports.ox_inventory:AddItem(Player, 'ctomato', indivual)
   	else
		TriggerClientEvent('ox_lib:notify', Player, {title = locale('shot'), description = locale('enoughcash'), type = 'error'})
	end

end)

RegisterServerEvent('nuggets10:add')
AddEventHandler('nuggets10:add', function(indivual)
	
	local Player = source
	local money = exports.ox_inventory:Search(Player, 'count','money')
	local price = tonumber(indivual * 5)
	if money >= price then
		exports.ox_inventory:RemoveItem(Player, 'money', price)
		local success = exports.ox_inventory:AddItem(Player, 'nuggets10', indivual)
   	else
		TriggerClientEvent('ox_lib:notify', Player, {title = locale('shot'), description = locale('enoughcash'), type = 'error'})
	end

end)

RegisterServerEvent('potato:add')
AddEventHandler('potato:add', function(indivual)
	
	local Player = source
	local money = exports.ox_inventory:Search(Player, 'count','money')
	local price = tonumber(indivual * 5)
	if money >= price then
		exports.ox_inventory:RemoveItem(Player, 'money', price)
		local success = exports.ox_inventory:AddItem(Player, 'potato', indivual)
   	else
		TriggerClientEvent('ox_lib:notify', Player, {title = locale('shot'), description = locale('enoughcash'), type = 'error'})
	end

end)






  

 