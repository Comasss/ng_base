ESX = ESX
QBCore = QBCore

if Cfg.Framework == "esx" then
    CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Wait(0)
        end
    end)
    ---comment
    ---@param title any
    ---@param name any
    ---@param data any
    ---@param cb function
    JOB.OpenMenu = function(title, name, data, cb)
        ESX.UI.Menu.Open('default',GetCurrentResourceName(),name,
        { 
        title = title, 
        align = "bottom-right", 
        elements = data 
        }, function(data, menu)
            cb(data, menu)
        end, function(data, menu) 
        menu.close() 
        end)
    end
elseif Cfg.Framework == "qbcore" then
    exports['qb-core']:GetCoreObject()
else
    print("ERROR - FRAMEWORK NOT SET")
end
