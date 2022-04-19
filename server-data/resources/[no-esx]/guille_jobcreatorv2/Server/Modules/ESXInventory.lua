JOB.CreateCallback("jobcreatorv2:server:getPlyInv", function (source, cb)
    local src <const> = source
    local xPlayer  = ESX.GetPlayerFromId(src)
    local Weapons  = xPlayer.getLoadout()
    local Accounts = xPlayer.getAccounts()
    local Items    = xPlayer.getInventory()
    return cb(Accounts, Items, Weapons)
end)


JOB.AddItem = function(type, name, count, label, job)
    local src <const> = source
    local Job = JOB.GetJob(job)
    local xPlayer = ESX.GetPlayerFromId(src)
    if type == "account" then
        xPlayer.removeAccountMoney(name, count)
    elseif type == "item" then
        xPlayer.removeInventoryItem(name, count)
    elseif type == "weapon" then
        xPlayer.removeWeapon(name)
    end
    Job.addItemToInv(type, name, count, label)
end

RegisterServerEvent("jobcreatorv2:server:addItemToInv", JOB.AddItem)

JOB.RemoveItem = function(type, name, count, job)
    local src <const> = source
    local Job = JOB.GetJob(job)
    local xPlayer = ESX.GetPlayerFromId(src)
    if type == "account" then
        xPlayer.addAccountMoney(name, count)
    elseif type == "item" then
        xPlayer.addInventoryItem(name, count)
    elseif type == "weapon" then
        xPlayer.addWeapon(name, count)
    end
    Job.removeItemOfInv(type, name, count)
end

RegisterServerEvent("jobcreatorv2:server:removeItemInv", JOB.RemoveItem)