fx_version 'cerulean'

game "gta5"
author 'Cocodurlo'

description "Elevator Script by SkyStore"

client_scripts {
	"src/RMenu.lua",
	"src/menu/RageUI.lua",
	"src/menu/Menu.lua",
	"src/menu/MenuController.lua",
	"src/components/*.lua",
	"src/menu/elements/*.lua",
	"src/menu/items/*.lua",
	"src/menu/panels/*.lua",
	"src/menu/panels/*.lua",
	"src/menu/windows/*.lua",
	'config.lua',
	"client.lua",
}

server_script "versionchecker.lua"
