fx_version 'cerulean'
game 'gta5'

author 'Brad'
description 'Script de wipe avec ESX et oxmysql'
version '1.0.0'


shared_script '@es_extended/imports.lua'
server_script '@oxmysql/lib/MySQL.lua'

client_script 'client.lua'
server_script 'server.lua'
