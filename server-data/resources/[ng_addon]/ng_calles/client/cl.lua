local CreateThread = CreateThread
local PlayerPedId = PlayerPedId
local GetEntityCoords = GetEntityCoords
local Wait = Wait

local showing = true
local lastStreet1, lastStreet2 = nil, nil

if Config.Framework == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
elseif Config.Framework == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
end

-- https://github.com/Leah-UK/bixbi_core/blob/main/client.lua#L30-#L44 ^^
local function Notification(msg, type, duration)
	if (duration == nil) then duration = 5000 end
	if Config.Notification == "t-notify" then
		if type == '' or type == nil then type = 'info' end
		exports['t-notify']:Alert({style = type, message = string.gsub(msg, '(~[rbgypcmuonshw]~)', '')})
	elseif Config.Notification == "mythic_notify" then
		if type == '' or type == nil then type = 'inform' end
		exports['mythic_notify']:DoCustomHudText(type, string.gsub(msg, '(~[rbgypcmuonshw]~)', ''), duration)
	elseif Config.Notification == "okokNotify" then
		if type == '' or type == nil then type = 'info' end
		exports['okokNotify']:Alert("", string.gsub(msg, '(~[rbgypcmuonshw]~)', ''), duration, type)
    elseif Config.Notification == "esx" then
		ESX.ShowNotification(msg)
	elseif Config.Notification == "qb" then
        QBCore.Functions.Notify(msg, type, duration)
    else
        print('^5[ERROR]:^0 Check your configuration, you have something wrong.')
    end
end

CreateThread(function()
    while true do
        local sleep = 750
        local ped = PlayerPedId()
        local pedc = GetEntityCoords(ped)
        local street
        local street1, street2 = GetStreetNameAtCoord(pedc.x, pedc.y, pedc.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())

        lastStreet1 = street1
        lastStreet2 = street2

        if street1 ~= 0 and street2 ~= 0 and (street1.. ' & ' ..street2) ~= (lastStreet1.. ' & ' ..lastStreet1) then
            street = (GetStreetNameFromHashKey(street1).. ' & ' ..GetStreetNameFromHashKey(street2))
        elseif street1 ~= 0 and street2 == 0 then
            street = GetStreetNameFromHashKey(street1)
        elseif street1 == 0 and street2 ~= 0 then
            street = GetStreetNameFromHashKey(street2)
        end

        if showing and IsPedInAnyVehicle(ped) and not IsPauseMenuActive() then
            sleep = 100

            if Config.Debug then
                print(street, street1, street2)
            end

            SendNUIMessage({
                action = 'showStreet',
                street = street
            })
        else
            SendNUIMessage({
                action = 'hideStreet'
            })
        end

        Wait(sleep)
    end
end)

if Config.Framework == 'esx' then
    if Config.Command.Enabled then
        RegisterCommand(Config.Command.Name, function()
            if showing then
                showing = false
                Notification(Locales[Config.Language]['desactivated_command'])

                if Config.Debug then
                    print(showing)
                end
            else
                showing = true
                Notification(Locales[Config.Language]['activated_command'])

                if Config.Debug then
                    print(showing)
                end
            end
        end)
    end

    if Config.Command.Keybind then
        RegisterKeyMapping(Config.Command.Name, Locales[Config.Language]['keybind_command'], 'keyboard', Config.Command.DefaultKey)
    end
elseif Config.Framework == 'qb' then
    RegisterCommand(Config.Command.Name, function()
        if showing then
            showing = false
            Notification(Locales[Config.Language]['desactivated_command'], 'success', 5000)

            if Config.Debug then
                print(showing)
            end
        else
            showing = true
            Notification(Locales[Config.Language]['activated_command'], 'success', 5000)

            if Config.Debug then
                print(showing)
            end
        end
    end)
end