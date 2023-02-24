fx_version 'bodacious'
game 'gta5'

lua54 'yes'
 
description 'ESX Burger Shot 2023 by:TonyKFC'

version '1.1.0'

client_scripts {
  '@es_extended/locale.lua', 
  'config.lua',
  'client/main.lua'
}

server_scripts {
  '@es_extended/locale.lua',
  '@oxmysql/lib/MySQL.lua', 
  'config.lua',
  'server/main.lua'
}

shared_scripts {
  '@ox_lib/init.lua',
  '@es_extended/imports.lua',
  'config.lua'
}

dependencies {
 'es_extended',
 'esx_billing',
 'esx_vehicleshop',
 'ox_inventory',
 'ox_lib'
}

shared_script '@es_extended/imports.lua'

files {
	'locales/*.json',
}
