JOB = setmetatable({ }, JOB)
JOB.__Index = JOB
JOB.Players = { }
JOB.Jobs = { }
JOB.Loaded = promise.new()
ESX = ESX
QBCore = QBCore

if Cfg.Framework == "esx" then
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
else
    exports['qb-core']:GetCoreObject()
end