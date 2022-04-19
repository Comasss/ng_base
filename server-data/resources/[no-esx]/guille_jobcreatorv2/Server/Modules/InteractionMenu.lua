RegisterNetEvent("jobcreatorv2:server:requestarrest", function(targetid, playerheading, playerCoords,  playerlocation)
    local src <const> = source
    local targetid <const> = targetid
    TriggerClientEvent('jobcreatorv2:client:getarrested', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('jobcreatorv2:client:doarrested', src)
end)

RegisterNetEvent('jobcreatorv2:server:requestunaarrest', function(targetid, playerheading, playerCoords,  playerlocation)
    local src <const> = source
    local targetid <const> = targetid
    TriggerClientEvent('jobcreatorv2:client:getuncuffed', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('jobcreatorv2:client:douncuffing', src)
end)

RegisterServerEvent('jobcreatorv2:server:escort', function(target)
    local src <const> = source
    local targetid <const> = target
    TriggerClientEvent('jobcreatorv2:client:drag', targetid, src)
end)

JOB.CreateCallback("jobcreatorv2:server:getOtherPlayerData", function (source, cb, target)
    local src <const> = source
    local trg <const> = target
    local xPlayer = ESX.GetPlayerFromId(trg)
	if xPlayer then
		local data = {
			name = xPlayer.getName(),
			job = xPlayer.job.label,
			grade = xPlayer.job.grade_label,
			inventory = xPlayer.getInventory(),
			accounts = xPlayer.getAccounts(),
            identifier   = xPlayer.identifier,
			weapons = xPlayer.getLoadout()
		}
        return cb(data)
	end
end)

RegisterNetEvent("jobcreatorv2:server:confiscatePlayerItem", function (target, itemType, itemName, amount)
    local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		if targetItem.count > 0 and targetItem.count <= amount then
			if sourceXPlayer.canCarryItem(itemName, sourceItem.count) then
				targetXPlayer.removeInventoryItem(itemName, amount)
				sourceXPlayer.addInventoryItem(itemName, amount)
				sourceXPlayer.showNotification("You robbed x" ..amount.. " of " ..sourceItem.label .. " - " ..sourceXPlayer.name)
				targetXPlayer.showNotification("You have been robbed x" ..amount.. " of " ..sourceItem.label .. " - " ..sourceXPlayer.name)
			else
				sourceXPlayer.showNotification("No puedes llevar más unidades de este item")
			end
		else
			sourceXPlayer.showNotification("Invalid quantity")
		end

	elseif itemType == 'item_account' then
		targetXPlayer.removeAccountMoney(itemName, amount)
		sourceXPlayer.addAccountMoney(itemName, amount)

		sourceXPlayer.showNotification("You robbed " .. amount .. " of " .. itemName .. " to " ..targetXPlayer.name)
		targetXPlayer.showNotification("You have been robbed " .. amount .. " of " .. itemName .. " to " ..targetXPlayer.name)

	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end
		targetXPlayer.removeWeapon(itemName, amount)
		sourceXPlayer.addWeapon(itemName, amount)

		sourceXPlayer.showNotification("You robbed the weapon " .. ESX.GetWeaponLabel(itemName) .. " - " .. targetXPlayer.name.. " in quantity of x" ..amount)
		targetXPlayer.showNotification("You have been robbed the weapon " .. ESX.GetWeaponLabel(itemName) .. " - " .. targetXPlayer.name.. " in quantity of x" ..amount)
	end
end)

RegisterServerEvent('jobcreatorv2:server:putinvehicle', function(target)
    if target ~= 0 then
        TriggerClientEvent('jobcreatorv2:client:putInVehicle', target)
    end
end)

RegisterServerEvent('jobcreatorv2:server:outfromveh', function(target)
	if target ~= 0 then
        TriggerClientEvent('jobcreatorv2:client:OutVehicle', target)
    end
end)