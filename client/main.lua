ESX = exports["es_extended"]:getSharedObject()

local currentZone, currentData = nil, nil

lib.locale()
local ox_inventory = exports.ox_inventory


function ShowUI(message, icon)
  if icon == 0 then
      lib.showTextUI(message)
  else
      lib.showTextUI(message, {
          icon = icon
      })
  end
end

function HideUI()
  lib.hideTextUI()
end

 
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    ESX.PlayerLoaded = false
    ESX.PlayerData = {}
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

--==========================================================================================================
 
CreateThread(function()

  local Burgerblip = AddBlipForCoord(Config.blips.Burgerblip.Pos.x, Config.blips.Burgerblip.Pos.y,Config.blips.Burgerblip.Pos.z)
  SetBlipSprite(Burgerblip, Config.blips.Burgerblip.Sprite)
  SetBlipDisplay(Burgerblip, Config.blips.Burgerblip.Display)
  SetBlipScale(Burgerblip, Config.blips.Burgerblip.Scale)
  SetBlipColour(Burgerblip, Config.blips.Burgerblip.Colour)
  SetBlipAsShortRange(Burgerblip, true)
  BeginTextCommandSetBlipName('STRING')
  AddTextComponentSubstringPlayerName(locale('burgergarageblipsname'))
  EndTextCommandSetBlipName(Burgerblip)

  local burgeringredients = AddBlipForCoord(Config.blips.burgeringredients.Pos.x, Config.blips.burgeringredients.Pos.y,Config.blips.burgeringredients.Pos.z)
  SetBlipSprite(burgeringredients, Config.blips.burgeringredients.Sprite)
  SetBlipDisplay(burgeringredients, Config.blips.burgeringredients.Display)
  SetBlipScale(burgeringredients, Config.blips.burgeringredients.Scale)
  SetBlipColour(burgeringredients, Config.blips.burgeringredients.Colour)
  SetBlipAsShortRange(burgeringredients, true)
  BeginTextCommandSetBlipName('STRING')
  AddTextComponentSubstringPlayerName(locale('burgershotingredients'))
  EndTextCommandSetBlipName(burgeringredients)

end)

--==========================================================================================================
 

function inside()
  
 local options = {} 
 
  if inside then   
     options[#options + 1] = {
     title = locale('billingget'),
     description = locale('billinggetplay'), 
     event = 'esx_burgershot:burgershotbilling', 
     icon = 'file-lines',
     }
    options[#options + 1] = {
    title = locale('takeout'),
    description = locale('takeoutcar'),
    event = 'esx_burgershot:burgergarageSpawnVehicle',
    icon = 'left-long',
    }
    options[#options + 1] = {
    title = locale('deposit'),
    description = locale('depositcar'),
    event = 'esx_burgershot:burgergarageDeleteVehicle', 
    icon = 'right-long',
    }
  end
    lib.registerContext({
      id = 'burgershotbilling',
      title = locale('billing'),
      options = options,
    })
end

function onExit() 
  local options = {} 
  if onExit then  
    options[#options + 1] = {
      title = locale('billingget'),
      description = locale('billinggetplay'), 
      event = 'esx_burgershot:burgershotbilling', 
      icon = 'file-lines',
      }
  end
  lib.registerContext({
    id = 'burgershotbilling',
    title = locale('billing'),
    options = options,
})
end
local box = lib.zones.box({
  coords = vec3(-1172.4801, -883.7699, 14.02080),
  size = vec3(18, 28, 5),
  rotation = 214,
  debug = false,
  inside = inside, 
  onExit = onExit,
})

Citizen.CreateThread(function()
  while true do
    local sleep = 0
    if IsControlJustReleased(0, 167) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'burgershot' then
       lib.showContext('burgershotbilling') 
     end
    Citizen.Wait(sleep)
  end      
end)   
 

RegisterNetEvent('esx_burgershot:burgershotbilling')
AddEventHandler('esx_burgershot:burgershotbilling', function()
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  local input = lib.inputDialog(locale('billing'), {{ type = "number", label = locale('Amount'), default = 0 }, })
  if not input then return end
   local amount = tonumber(input[1])
   if amount >0  then
 
      if closestPlayer == -1 or closestDistance > 3.0 then 
          lib.notify({
            title =locale('billing'),
            description = locale('no_players_nearby'),
            type = 'error'
        })
      else
          TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_burgershot',
              'burgershot', amount)
        
          lib.notify({
            title =locale('billing'),
            description = locale('billing_sent'),
            type = 'success'
        })
      end
   
   else 
      lib.notify({
        title =locale('billing'),
        description = locale('amount_invalid'),
        type = 'error'
    })
   end

 end)  
 
--==========================================================================================================
CreateThread(function()
  local pedCoords = GetEntityCoords(PlayerPedId())
  local BossActions = GetDistanceBetweenCoords(pedCoords.x,pedCoords.y,pedCoords.z,Config.MarkerZones.BossActions.Pos.x,Config.MarkerZones.BossActions.Pos.y,Config.MarkerZones.BossActions.Pos.z)
  local burgershotFridge = GetDistanceBetweenCoords(pedCoords.x,pedCoords.y,pedCoords.z,Config.MarkerZones.burgershotFridge.Pos.x,Config.MarkerZones.burgershotFridge.Pos.y,Config.MarkerZones.burgershotFridge.Pos.z)
  local burgerchangingroom = GetDistanceBetweenCoords(pedCoords.x,pedCoords.y,pedCoords.z,Config.MarkerZones.burgerchangingroom.Pos.x,Config.MarkerZones.burgerchangingroom.Pos.y,Config.MarkerZones.burgerchangingroom.Pos.z)
  local burgercooking = GetDistanceBetweenCoords(pedCoords.x,pedCoords.y,pedCoords.z,Config.MarkerZones.burgercooking.Pos.x,Config.MarkerZones.burgercooking.Pos.y,Config.MarkerZones.burgercooking.Pos.z)
  local burgerfoodshot = GetDistanceBetweenCoords(pedCoords.x,pedCoords.y,pedCoords.z,Config.MarkerZones.burgerfoodshot.Pos.x,Config.MarkerZones.burgerfoodshot.Pos.y,Config.MarkerZones.burgerfoodshot.Pos.z)
 
  
  local textUI, burgerchangingroomLoc, burgershotFridgeLoc,  burgercookingLoc, burgerfoodmenu, burgerdeskLoc, burgerfoodshotLoc, DrawMarkerK= nil, nil, nil, nil, nil, nil, nil, nil
  while true do
      local sleep = 1500
      local coords = GetEntityCoords(PlayerPedId())
      for k,v in pairs(Config.burgershot) do

          local burgershotFridgeLoc = v.locations.burgershotFridge.coords
          local burgerchangingroomLoc = v.locations.burgerchangingroomLoc.coords
          local burgercookingLoc = v.locations.burgercookingLoc.coords
          local burgerfoodmenuLoc = v.locations.burgerfoodmenuLoc.coords
          local burgerdeskLoc = v.locations.burgerdeskLoc.coords
          local burgerfoodshotLoc = v.locations.burgerfoodshotLoc.coords
          
          local bossLoc
          if v.bossMenu.enabled then
              bossLoc = v.bossMenu.coords
          end

          local distFridge = #(coords - burgershotFridgeLoc)
          local distchangingroom = #(coords - burgerchangingroomLoc)
          local distburgercooking = #(coords - burgercookingLoc)
          local burgerfoodmenu = #(coords - burgerfoodmenuLoc)
          local burgerdesk = #(coords - burgerdeskLoc)
          local burgerfoodshot = #(coords - burgerfoodshotLoc)

          local distBoss
          if bossLoc then
              distBoss = #(coords - bossLoc)
          end
          if distFridge <= v.locations.burgershotFridge.range and ESX.PlayerData.job.name == k then
              if not textUI then
                ShowUI(locale('open_fridge'), 'box')
                  textUI = true 
              end
              sleep = 0
              if IsControlJustReleased(0, 38) then
                TriggerServerEvent('burgershotFridge:addicee')
                sleep = 100
                ox_inventory:openInventory('stash', 'burgershotFridge')  
               end
              sleep = 0
              if not DrawMarkerK then
                 DrawMarker(Config.MarkerZones.burgershotFridge.Type, Config.MarkerZones.burgershotFridge.Pos.x, Config.MarkerZones.burgershotFridge.Pos.y, Config.MarkerZones.burgershotFridge.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 128, 0, 100, false, true, 2, nil, nil, false)
              end 
          elseif distchangingroom <= v.locations.burgerchangingroomLoc.range and ESX.PlayerData.job.name == k then
              if not textUI then
                ShowUI(locale('open_changingroom'), 'shirt')
                  textUI = true
              end
              sleep = 0
              if IsControlJustReleased(0, 38) then
                lib.showContext('burgerchangingroom')
              end
              sleep = 0
              if not DrawMarkerK then
                DrawMarker(Config.MarkerZones.burgerchangingroom.Type, Config.MarkerZones.burgerchangingroom.Pos.x, Config.MarkerZones.burgerchangingroom.Pos.y, Config.MarkerZones.burgerchangingroom.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 128, 0, 100, false, true, 2, nil, nil, false)
               end 
          elseif distburgercooking <= v.locations.burgercookingLoc.range and ESX.PlayerData.job.name == k then
              if not textUI then
                ShowUI(locale('open_burgercooking'), 'cookie-bite')
                textUI = true
              end
              sleep = 0
              if IsControlJustReleased(0, 38) then
                lib.showContext('burgercooking')
              end
              sleep = 0
              if not DrawMarkerK then
                DrawMarker(Config.MarkerZones.burgercooking.Type, Config.MarkerZones.burgercooking.Pos.x, Config.MarkerZones.burgercooking.Pos.y, Config.MarkerZones.burgercooking.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 128, 0, 100, false, true, 2, nil, nil, false)
              end 
            elseif burgerdesk <= v.locations.burgerdeskLoc.range  then
              if not textUI then
                ShowUI(locale('open_dinnerplate'), 'burger')
                textUI = true
              end
              sleep = 0
              if IsControlJustReleased(0, 38) then  
                takemeal()
              end  
            elseif burgerfoodshot <= v.locations.burgerfoodshotLoc.range and ESX.PlayerData.job.name == k  then
              if not textUI then
                ShowUI(locale('open_burgerfoodshot'), 'burger')
                textUI = true
              end
              sleep = 0
              if IsControlJustReleased(0, 38) then  
                lib.showContext('burgerfoodshot')
              end  
              sleep = 0
              if not DrawMarkerK then
                 DrawMarker(Config.MarkerZones.burgerfoodshot.Type, Config.MarkerZones.burgerfoodshot.Pos.x, Config.MarkerZones.burgerfoodshot.Pos.y, Config.MarkerZones.burgerfoodshot.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 128, 0, 100, false, true, 2, nil, nil, false)
              end 
 
            elseif burgerfoodmenu <= v.locations.burgerfoodmenuLoc.range   then
              if not textUI then
                ShowUI(locale('open_burgerfoodmenu'), 'burger')
                textUI = true
              end
              sleep = 0
              if IsControlJustReleased(0, 38) then              
ShowUI(([[
*****%s***** \
\
[%s] - %s \
[%s] - %s \
[%s] - %s \
[%s] - %s \
[%s] - %s
]]):format(locale('burgerfoodmenu'),locale('fvburgersellmoney'), locale('fvburger'), locale('nuggetsellmoney'), locale('nugget'), locale('cheesesellmoney'), locale('cheese'), locale('colalasellmoney'), locale('colala'),"BACKSPACE", locale('exit')))

              elseif IsControlJustReleased(0, 177) then      
                HideUI()
                if burgerfoodmenu <= v.locations.burgerfoodmenuLoc.range then
                  ShowUI(locale('open_burgerfoodmenu'), 'burger')   
                end
              end
       
          elseif distBoss and distBoss <= v.bossMenu.range and ESX.PlayerData.job.name == k then
              if not textUI then
                ShowUI(locale('open_boss'), 'bars')
                textUI = true
              end
              sleep = 0
              if IsControlJustReleased(0, 38) and ESX.PlayerData.job.name == k and ESX.PlayerData.job.grade_name == 'boss' then
                  TriggerEvent('esx_society:openBossMenu', ESX.PlayerData.job.name, function(data, menu)
                      menu.close()
                  end, {wash = false})
              end
              sleep = 0
              if not DrawMarkerK then
                DrawMarker(Config.MarkerZones.BossActions.Type, Config.MarkerZones.BossActions.Pos.x, Config.MarkerZones.BossActions.Pos.y, Config.MarkerZones.BossActions.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 128, 0, 100, false, true, 2, nil, nil, false)
               end 
          elseif textUI then
              lib.hideTextUI()
              textUI = nil
          end
      end
      Wait(sleep)
  end
end)
 

function takemeal()
 
    local input = lib.inputDialog(locale('takemeal'), {{ type = "input", label = locale('takemealnumber'), placeholder = "1-5" }, })
  if not input then return end
    local takemealnumber = tonumber(input[1])
      if takemealnumber == 1  then
        ox_inventory:openInventory('stash', 'dinnerplate1') 
      elseif takemealnumber == 2  then
        ox_inventory:openInventory('stash', 'dinnerplate2') 
      elseif takemealnumber == 3  then
        ox_inventory:openInventory('stash', 'dinnerplate3') 
      elseif takemealnumber == 4  then
        ox_inventory:openInventory('stash', 'dinnerplate4') 
      elseif takemealnumber == 5  then 
        ox_inventory:openInventory('stash', 'dinnerplate5') 
      else
        lib.notify({
          title = locale('wrongnumber'),
          description = locale('wrongnumberr'),
          type = 'error'
      }) 
      end
  end  
--==========================================================================================================
lib.registerContext({
  id = 'burgercooking',
  title = locale('burgercooking'),
  options = {
      {
          title = locale('burgercookingroomm'),
          description = locale('burgercookingroommcr'),
          icon = 'gear',
          menu = 'burgercookingvv',
          
      },
  },
  {
    id = 'burgercookingvv',
    title = locale('burgercookingroomm'),
    menu = 'burgercooking',
    options = {
      {
        title = locale('makingburgers'),
        description = locale('makingburgerss'), 
        event = 'esx_burgershotcooking:burger',
        icon = 'burger', 
        metadata = {
          {label = locale('vbread'),    value = '1x'},
          {label = locale('ccheese'),   value = '1x'}, 
          {label = locale('fburger'),   value = '1x'},
          {label = locale('lettuce'),   value = '1x'},
          {label = locale('ctomato'),   value = '1x'},
        }

      }, 

      {
        title = locale('makingnugget'),
        description = locale('makingnuggets'), 
        event = 'esx_burgershotcooking:nugget',
        icon = 'play',
        metadata = {
          {label = locale('nuggets10'),    value = '1x'}, 
        }

      },

      {
        title = locale('makingcheese'),
        description = locale('makingcheeses'), 
        event = 'esx_burgershotcooking:cheese',
        icon = 'cheese',  
        metadata = {
          {label = locale('potato'),    value = '1x'}, 
        }

      },
      {
        title = locale('makingcolala'),
        description = locale('makingcolalas'), 
        event = 'esx_burgershotcooking:colala',
        icon = 'bottle-water',
        metadata = {
          {label = locale('icee'),    value = '5x'}, 
        }
      },    
    }
  }
})


RegisterNetEvent('esx_burgershotcooking:burger')
AddEventHandler('esx_burgershotcooking:burger', function()
  local vbread = exports.ox_inventory:Search('count', 'vbread')
  local ccheese = exports.ox_inventory:Search('count', 'ccheese')
  local fburger = exports.ox_inventory:Search('count', 'fburger')
  local lettuce = exports.ox_inventory:Search('count', 'lettuce')
  local ctomato = exports.ox_inventory:Search('count', 'ctomato')
  if  vbread >= 1 and ccheese >= 1  and fburger >= 1  and lettuce >= 1 and ctomato >= 1 then
      if lib.progressCircle({
        duration = 5000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        label = locale('cookinging'),
        disable = {
          car = true,
          move = true,
          combat = true,
        },
        anim = {
          dict = 'amb@prop_human_bum_bin@base',
          clip = 'base'
        },
     
    }) then 
          TriggerServerEvent('esx_burgershotcooking:serverburger') 
      else
        lib.notify({
          title = locale('kitchen'),
          description = locale('errorkitchen'),
          type = 'error'
      })
      end
    else 
        lib.notify({
            title = locale('kitchen'),
            description = locale('missingfood'),
            type = 'error'
        })
    end

end)
RegisterNetEvent('esx_burgershotcooking:nugget')
AddEventHandler('esx_burgershotcooking:nugget', function()

  
  local nuggets10 = exports.ox_inventory:Search('count', 'nuggets10') 

  if  nuggets10 >= 1  then
    if lib.progressCircle({
      duration = 5000,
      position = 'bottom',
      useWhileDead = false,
      canCancel = false,
      label = locale('cookinging'),
      disable = {
        car = true,
        move = true,
        combat = true,
      },
      anim = {
        dict = 'amb@prop_human_bum_bin@base',
        clip = 'base'
      },
   
  }) then 
        TriggerServerEvent('esx_burgershotcooking:servernuggets') 
    else
      lib.notify({
        title = locale('kitchen'),
        description = locale('errorkitchen'),
        type = 'error'
    })
    end
else 
    lib.notify({
        title = locale('kitchen'),
        description = locale('missingfood'),
        type = 'error'
    })
end
end)  

RegisterNetEvent('esx_burgershotcooking:cheese')
AddEventHandler('esx_burgershotcooking:cheese', function()

  local potato = exports.ox_inventory:Search('count', 'potato') 

  if  potato >= 1  then
 
    if lib.progressCircle({
      duration = 5000,
      position = 'bottom',
      useWhileDead = false,
      canCancel = false,
      label = locale('cookinging'),
      disable = {
        car = true,
        move = true,
        combat = true,
      },
      anim = {
        dict = 'amb@prop_human_bum_bin@base',
        clip = 'base'
      },
   
  }) then 
        TriggerServerEvent('esx_burgershotcooking:servercheese') 
    else
      lib.notify({
        title = locale('kitchen'),
        description = locale('errorkitchen'),
        type = 'error'
    })
    end
else 
    lib.notify({
        title = locale('kitchen'),
        description = locale('missingfood'),
        type = 'error'
    })
end

end)  

RegisterNetEvent('esx_burgershotcooking:colala')
AddEventHandler('esx_burgershotcooking:colala', function()
  local icee = exports.ox_inventory:Search('count', 'icee') 
  if  icee >= 5  then
    if lib.progressCircle({
      duration = 5000,
      position = 'bottom',
      useWhileDead = false,
      canCancel = false,
      label = locale('cookinging'),
      disable = {
        car = true,
        move = true,
        combat = true,
      },
      anim = {
        dict = 'amb@prop_human_bum_bin@base',
        clip = 'base'
      },
   
  }) then 
        TriggerServerEvent('esx_burgershotcooking:servercolala') 
    else
      lib.notify({
        title = locale('kitchen'),
        description = locale('errorkitchen'),
        type = 'error'
    })
    end
else 
    lib.notify({
        title = locale('kitchen'),
        description = locale('missingfood'),
        type = 'error'
    })
end
end)  

 
--==========================================================================================================
lib.registerContext({
  id = 'burgerchangingroom',
  title = locale('burgerchangingroom'),
  options = {
      {
          title = locale('burgerchangingroomm'),
          description = locale('changingclothing'),
          menu = 'workerroom',
          icon = 'fa-shirt',
      },
  },
  {
    id = 'workerroom',
    title = locale('workerroom'),
    menu = 'burgerchangingroom',
    options = {
      {
        title = locale('casualwear'),
        description = locale('changing'),
        event = 'esx_burgershot:loadSkin',
        icon = 'fa-shirt',

      },
      {
        title = locale('workerclothing'),
        description = locale('changing'),
        event = 'esx_burgershot:loadClothes',
        icon = 'fa-shirt',

      },
       
    }
  }
})
 

RegisterNetEvent('esx_burgershot:loadSkin')
AddEventHandler('esx_burgershot:loadSkin', function(skin)
  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
    TriggerEvent('skinchanger:loadSkin', skin)
  end)
end)
 
RegisterNetEvent('esx_burgershot:loadClothes')
AddEventHandler('esx_burgershot:loadClothes', function(skin)
  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
    if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
    else
        TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
    end
end)
end)
--==========================================================================================================

 
RegisterNetEvent('esx_burgershot:burgergarageSpawnVehicle')
AddEventHandler('esx_burgershot:burgergarageSpawnVehicle', function(vehicle)
  local playerPed = PlayerPedId()
  local pedCoords = GetEntityCoords(playerPed)
 
 -- ESX.Game.SpawnVehicle(Config.SpawnVehicle.Spawn.model, vector3(Config.SpawnVehicle.Spawn.Pos.x,Config.SpawnVehicle.Spawn.Pos.y, Config.SpawnVehicle.Spawn.Pos.z), Config.SpawnVehicle.Spawn.Pos.w, function(vehicle)
 ESX.Game.SpawnVehicle(Config.SpawnVehicle.Spawn.model, vector3(pedCoords.x,pedCoords.y, pedCoords.z), pedCoords.w, function(vehicle)
    if DoesEntityExist(vehicle) then  
      DoScreenFadeOut(100)
   
  		SetPedIntoVehicle(playerPed,vehicle,-1)
      SetVehicleNumberPlateText(vehicle,Config.SpawnVehicle.Spawn.Plate)
      SetVehicleNumberPlateTextIndex(vehicle,vehicle,Config.SpawnVehicle.Spawn.PlateColor)
   --   TriggerEvent('esx_locksystem:add', localVehId, localVehPlateTest,localVehPlate,localVehLockStatus)
      lib.notify({
        title = locale('burgergarage'),
        description = locale('keygaragetext'),
        type = 'inform'
    })
    Wait(1000)
    DoScreenFadeIn(100)
    end
 end)
end)
 

RegisterNetEvent('esx_burgershot:burgergarageDeleteVehicle')
AddEventHandler('esx_burgershot:burgergarageDeleteVehicle', function(vehicle)
  local playerPed = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(playerPed, false,-1)
  if GetEntityModel(vehicle) == `boxville2` then
    TaskLeaveVehicle(playerPed, vehicle, 0)
    Wait(1000)
    ESX.Game.DeleteVehicle(vehicle)
  else
    lib.notify({
      title = locale('errorgarage'),
      description = locale('errorgaragetext'),
      type = 'error'
  })
  end
   
end)

 
 --==========================================================================================================
lib.registerContext({
  id = 'burgerfoodshot',
  title = locale('burgeringredients'),
  
  options = {
          {
              title = locale('open_burgerfoodshott'),
              description = locale('buyingredients'), 
              icon = 'burger', 
              menu = 'makingburgers',
          } 
   },
   {
    id = 'makingburgers',
    title = locale('makingburgers'),
    menu = 'burgerfoodshot',
    options = {
      {
        title = locale('burgeringredients'),
        icon = 'gear',
        description = locale('ingredientsforhamburger'), 
        menu = 'burgerIngredients',
      },
      {
        title = locale('chickennuggets'),
        icon = 'gear',
        description = locale('IngredientsforChickenNuggets'), 
        menu = 'nuggetIngredients',
      },
      {
        title = locale('friesingredients'), 
        icon = 'gear',
        description = locale('IngredientsforFrenchFries'), 
        menu = 'cheeseIngredients',
      },
    }
    },
        {
          id = 'burgerIngredients',
          title = locale('burgeringredients'),
          menu = 'makingburgers',
          options = {
            {
              title = locale('vbread'),
              icon = 'burger',
              description = locale('Buythisingredient'), 
              event = 'esx_burgershot:buyvbread'
            
            },
            {
              title = locale('ccheese'),
              icon = 'cheese',
              description = locale('Buythisingredient'), 
              event = 'esx_burgershot:buyccheese'
            
            },
            {
              title = locale('fburger'),
              icon = 'cow',
              description = locale('Buythisingredient'), 
              event = 'esx_burgershot:buyfburger'
            
            },
            {
              title = locale('lettuce'),
              icon = 'leaf',
              description = locale('Buythisingredient'), 
              event = 'esx_burgershot:buylettuce'
            
            },
            {
              title = locale('ctomato'),
              icon = 'seedling',
              description = locale('Buythisingredient'), 
              event = 'esx_burgershot:buyctomato'
            
            },
          }
        },
        {
          id = 'nuggetIngredients',
          title = locale('chickennuggets'),
          menu = 'makingburgers',
          options = {
            {
              title = locale('nuggets10'),
              icon = 'play',
              description =locale('Buythisingredient'), 
              event = 'esx_burgershot:buynuggets10'
            
            },

          }
        },
        {
          id = 'cheeseIngredients',
          title = locale('friesingredients'),
          menu = 'makingburgers',
          options = {
            {
              title = locale('potato'),
              icon = 'grip-lines-vertical',
              description =locale('Buythisingredient'), 
              event = 'esx_burgershot:buypotato'
            
            },

          }
        },
})




RegisterNetEvent('esx_burgershot:buyvbread')
AddEventHandler('esx_burgershot:buyvbread', function()
local input = lib.inputDialog(locale('buyvbread'), {{ type = "number", label = locale('Amount'), default = 0 }})
  if not input then return end 
  local indivual = tonumber(input[1])
    if indivual > 0 then
        TriggerServerEvent('vbread:add', indivual)
    else
      lib.notify({
        title = locale('Invalidamount'),
        description = locale('validamount'),
        type = 'error'
    })
  end
end) 

RegisterNetEvent('esx_burgershot:buyccheese')
AddEventHandler('esx_burgershot:buyccheese', function()
local input = lib.inputDialog(locale('buyccheese'), {{ type = "number", label = locale('Amount'), default = 0 }})
  if not input then return end 
  local indivual = tonumber(input[1])
      if indivual > 0 then
        TriggerServerEvent('ccheese:add', indivual)
    else
      lib.notify({
        title = locale('Invalidamount'),
        description = locale('validamount'),
        type = 'error'
    })
  end
end) 


RegisterNetEvent('esx_burgershot:buyfburger')
AddEventHandler('esx_burgershot:buyfburger', function()
local input = lib.inputDialog(locale('buyfburger'), {{ type = "number", label = locale('Amount'), default = 0 }})
  if not input then return end 
  local indivual = tonumber(input[1])
      if indivual > 0 then
        TriggerServerEvent('fburger:add', indivual)
    else
      lib.notify({
        title = locale('Invalidamount'),
        description = locale('validamount'),
        type = 'error'
    })
  end
end) 


RegisterNetEvent('esx_burgershot:buylettuce')
AddEventHandler('esx_burgershot:buylettuce', function()
local input = lib.inputDialog(locale('buylettuce'), {{ type = "number", label = locale('Amount'), default = 0 }})
  if not input then return end 
  local indivual = tonumber(input[1])
      if indivual > 0 then
        TriggerServerEvent('lettuce:add', indivual)
    else
      lib.notify({
        title = locale('Invalidamount'),
        description = locale('validamount'),
        type = 'error'
    })
  end
end) 


RegisterNetEvent('esx_burgershot:buyctomato')
AddEventHandler('esx_burgershot:buyctomato', function()
local input = lib.inputDialog(locale('buyctomato'), {{ type = "number", label = locale('Amount'), default = 0 }})
  if not input then return end 
  local indivual = tonumber(input[1])
      if indivual > 0 then
        TriggerServerEvent('ctomato:add', indivual)
    else
      lib.notify({
        title = locale('Invalidamount'),
        description = locale('validamount'),
        type = 'error'
    })
  end
end) 

RegisterNetEvent('esx_burgershot:buynuggets10')
AddEventHandler('esx_burgershot:buynuggets10', function()
local input = lib.inputDialog(locale('buynuggets10'), {{ type = "number", label = locale('Amount'), default = 0 }})
  if not input then return end 
  local indivual = tonumber(input[1])
      if indivual > 0 then
        TriggerServerEvent('nuggets10:add', indivual)
    else
      lib.notify({
        title = locale('Invalidamount'),
        description = locale('validamount'),
        type = 'error'
    })
  end
end) 

RegisterNetEvent('esx_burgershot:buypotato')
AddEventHandler('esx_burgershot:buypotato', function()
local input = lib.inputDialog(locale('buypotato'), {{ type = "number", label = locale('Amount'), default = 0 }})
  if not input then return end 
  local indivual = tonumber(input[1])
      if indivual > 0 then
        TriggerServerEvent('potato:add', indivual)
    else
      lib.notify({
        title = locale('Invalidamount'),
        description = locale('validamount'),
        type = 'error'
    })
  end
end) 
 
 
 
 
--[[function openMenu()
 
  local options = {}
  local vbread = exports.ox_inventory:Search('count', 'vbread')

     if vbread == 1 then
      if vbread == 1 then
          options[#options + 1] = {
              title = 'options+1',
              description = 'options+1',
 
              
          }
      else 
          options[#options + 1] = {
            title = 'options+2',
            description = 'options+2',
   
               
          }
      end
  end


  lib.registerContext({
      id = "test",
      title = 'test',
      options = options,
  
  })

  lib.showContext("test")

end
RegisterCommand('ddddd', function()
  openMenu()
end)]]