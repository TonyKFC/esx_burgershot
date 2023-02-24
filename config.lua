Config                            = {}
Config.OxInventory                = ESX.GetConfig().OxInventory

Config.MarkerZones = {
    BossActions=
    { 
        Pos   = { x = -1192.2319, y = -897.5267, z = 13.9953},  
        Type  = 2
    },
    burgershotFridge=
    { 
        Pos   = { x = -1197.2465, y = -900.0168, z = 13.9953},  
        Type  = 2
    },
    burgerchangingroom=
    {                                        
        Pos   = { x = -1201.3363, y = -893.6201, z = 13.9953},  
        Type  = 2
    },
 
    burgercooking=
    {                                    
        Pos   = { x = -1202.3115, y = -896.9929, z = 13.9953},  
        Type  = 2
    },  
    burgerfoodshot=
    {                                    
        Pos   = { x = -1659.5527, y = -1044.4146, z = 13.1653},  
        Type  = 2
    },
}
Config.SpawnVehicle ={  
    Spawn =
    {
        Pos   = { x = -1164.3126, y = -891.8652, z = 14.0976, w = 303.0782},
        model = "boxville2",
        Plate = "BURGER",
        PlateColor = 1,
    },

        --[[
            PlateColor:
            Blue/White - 0
            Yellow/black - 1
            Yellow/Blue - 2
            Blue/White2 - 3
            Blue/White3 - 4
            Yankton - 5
      ]]
 
}   

Config.blips ={ 

    Burgerblip = {
		Pos   = {x = -1173.0192, y = -890.1209, z = 13.9109},
	    Sprite = 536,
        Display = 4,
        Scale = 0.8,
        Colour = 1,
	},
 
    burgeringredients = {
		Pos   = {x = -1659.6061, y = -1044.4788, z = 13.1637},
	    Sprite = 59,
        Display = 4,
        Scale = 0.8,
        Colour = 1,
	},
}
 


Config.burgershot = {
    ['burgershot'] = { -- Job name
 
        bossMenu = {
            enabled = true, -- Enable boss menu?
            coords = vec3(-1192.2319, -897.5267, 13.9953), 
            range = 1.0,  
        },
        locations = {
            burgershotFridge = {
                coords = vec3(-1197.2465, -900.0168, 13.9953),
                range = 1.0
            },
            burgerchangingroomLoc = { 
                coords = vec3(-1201.3363, -893.6201, 13.9953),
                range = 1.0
            },
            burgercookingLoc = { 
                coords = vec3(-1202.3115, -896.9929, 13.9953),
                range = 1.0
            },
            burgercookingLoc = { 
                coords = vec3(-1202.3115, -896.9929, 13.9953),
                range = 1.0
            },
            burgerfoodmenuLoc = { 
                coords = vec3(-1194.0216, -892.8758, 13.9953),
                range = 1.0
            },
            burgerdeskLoc = { 
                coords = vec3(-1195.3750, -890.9067, 13.9953),
                range = 1.0
            }, 
            burgerfoodshotLoc = { 
                coords = vec3(-1659.5527, -1044.4146, 13.1653),
                range = 2.0
            }, 
        }
    }, 
    
}

