fx_version 'cerulean'

game 'gta5' 

name 'mono_carkeys'

repository 	'https://github.com/Mono-94/mono_carkeys'

version 		'2.0.0'

author 'Symbiote#3027'


shared_scripts{
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config_keys.lua'
} 


client_scripts{
    'client/*.lua',
} 

server_scripts{
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
} 


files {
    'locales/*.json'
}

lua54 'yes'
