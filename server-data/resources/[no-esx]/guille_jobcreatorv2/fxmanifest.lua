fx_version 'cerulean'

game 'gta5'

author 'guillerp#1928'

lua54 'yes'

shared_scripts {
    './Shared/Cfg.lua'
}

server_scripts {
    './Server/SMain.lua',

    './Server/Modules/Logger.lua',
    './Server/Modules/Functions.lua',
    './Server/Modules/Database.lua',
    './Server/Modules/Database.js',

    './Server/Classes/Job.lua',
    './Server/Classes/Player.lua',
    './Server/Modules/Commands.lua',

    './Server/Modules/Init.lua',
    './Server/Modules/ESXInventory.lua',
    './Server/Modules/InteractionMenu.lua'
}

client_scripts {
    './Client/CMain.lua',
    
    './Client/Modules/NuiCallbacks.lua',
    './Client/Modules/Markers.lua',
    './Client/Modules/Functions.lua',
    './Client/Modules/EditFunctions.lua',
    './Client/Modules/Framework.lua',
    './Client/Modules/InteractionMenu.lua'
}

ui_page './Ui/Index.html'

files {
    './Ui/Js/Main.js',
    './Ui/Js/Edit.js',

    './Ui/Css/Style.css',
    './Ui/Css/Edit.css',
    './Ui/Css/Creatorpage.css',

    './Ui/Assets/*.png',

    './Ui/Index.html',
}