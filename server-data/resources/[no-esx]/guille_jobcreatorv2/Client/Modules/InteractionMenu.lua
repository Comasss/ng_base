JOB.OpenInteractionMenu = function ()
    if JOB.Variables.OwnJob then
        local MenuData = GlobalState[JOB.Variables.OwnJob.name.."-guille"]
        local ParsedData = MenuData.options
        local Elements = {}
        if ParsedData['search'] then
            table.insert(Elements, { label = "Search", value = "search" })
        end
        if ParsedData['handcuff'] then
            table.insert(Elements, { label = "Handcuff", value = "handcuff" })
            table.insert(Elements, { label = "Remove Handcuffs", value = "rhandcuff" })
            table.insert(Elements, { label = "Drag", value = "drag" })
            table.insert(Elements, { label = "Put in vehicle", value = "putveh" })
            table.insert(Elements, { label = "Remove from vehicle", value = "remveh" })
        end
        if ParsedData['billing'] and Cfg.Framework == "esx" then
            table.insert(Elements, { label = "Billing", value = "billing" })
        end
        if ParsedData['identity'] then
            table.insert(Elements, { label = "Identity (Not working at the moment)", value = "identity" })
        end
        if ParsedData['vehinfo'] then
            table.insert(Elements, { label = "Vehicle Options", value = "vehinfo" })
        end
        if ParsedData['objects'] then
            table.insert(Elements, { label = "Put objects", value = "objects" })
        end
        JOB.OpenMenu("Interaction Menu", "inter-menu-cumbai", Elements, function (data, menu)
            if data.current.value == "handcuff" then
                local player, distance = JOB.GetClosestPlayer()
                local ped = PlayerPedId()
                local playerheading = GetEntityHeading(ped)
                local playerlocation = GetEntityForwardVector(PlayerPedId())
                local playerCoords = GetEntityCoords(ped)
                if distance < 2 and distance ~= -1 and player then
                    TriggerServerEvent('jobcreatorv2:server:requestarrest', GetPlayerServerId(player), playerheading, playerCoords, playerlocation)
                end
            elseif data.current.value == "rhandcuff" then
                local player, distance = JOB.GetClosestPlayer()
                local ped = PlayerPedId()
                local playerheading = GetEntityHeading(ped)
                local playerlocation = GetEntityForwardVector(PlayerPedId())
                local playerCoords = GetEntityCoords(ped)
                if distance < 2 and distance ~= -1 and player then
                    TriggerServerEvent('jobcreatorv2:server:requestunaarrest', GetPlayerServerId(player), playerheading, playerCoords, playerlocation)
                end
            elseif data.current.value == "drag" then
                local player, distance = JOB.GetClosestPlayer()
                if distance < 3 and distance ~= -1  and player then
                    TriggerServerEvent('jobcreatorv2:server:escort', GetPlayerServerId(player))
                    if not JOB.Variables.IsDragging then
                        ESX.Streaming.RequestAnimDict('switch@trevor@escorted_out', function()
                            TaskPlayAnim(PlayerPedId(), 'switch@trevor@escorted_out', '001215_02_trvs_12_escorted_out_idle_guard2', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
                        end)
                        JOB.Variables.IsDragging = true
                    else
                        Wait(500)
                        ClearPedTasks(PlayerPedId())
                        JOB.Variables.IsDragging = false
                    end
                end
            elseif data.current.value == "putveh" then
                local player, distance = JOB.GetClosestPlayer()
                if distance < 3 and distance ~= -1 and player then
                    TriggerServerEvent('jobcreatorv2:server:putinvehicle', GetPlayerServerId(player))
                end
            elseif data.current.value == "remveh" then
                local player, distance = JOB.GetClosestPlayer()
                if distance < 3 and distance ~= -1 and player then
                    TriggerServerEvent('jobcreatorv2:server:outfromveh', GetPlayerServerId(player))
                end
            elseif data.current.value == "identity" then
            elseif data.current.value == "vehinfo" then
            elseif data.current.value == "objects" then

            elseif data.current.value == "search" then
                local player, distance = JOB.GetClosestPlayer()
                if distance < 3 and distance ~= -1 and player then
                    JOB.OpenBodySearchMenu(player)
                end
            end
        end)
    end
end

RegisterCommand("openinteractionjobcreatorguillerpontophellobombay", JOB.OpenInteractionMenu)

RegisterKeyMapping("openinteractionjobcreatorguillerpontophellobombay", "Open JobCreator menu", "keyboard", "f9")

RegisterNetEvent('jobcreatorv2:client:getarrested', function(playerheading, playercoords, playerlocation)
	playerPed = PlayerPedId()
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(PlayerPedId(), x, y, z - 1)
	SetEntityHeading(PlayerPedId(), playerheading)
	Wait(250)
	JOB.Loadanimdict('mp_arrest_paired')
	TaskPlayAnim(PlayerPedId(), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	Wait(3760)	
	JOB.Variables.Handcuff = true
    LoadHandcuff()
	JOB.Loadanimdict('mp_arresting')
	TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
end)

RegisterNetEvent('jobcreatorv2:client:doarrested', function()
    Wait(250)
	JOB.Loadanimdict('mp_arrest_paired')
	TaskPlayAnim(PlayerPedId(), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
    Wait(3000)
end) 

LoadHandcuff = function()
    CreateThread(function ()
        while true do
            Wait(0)
            local playerPed = PlayerPedId()
    
            if JOB.Variables.Handcuff then
                --DisableControlAction(0, 1, true) -- Disable pan
                --DisableControlAction(0, 2, true) -- Disable tilt
                DisableControlAction(0, 21, true)
                DisableControlAction(0, 24, true) -- Attack
                DisableControlAction(0, 257, true) -- Attack 2
                DisableControlAction(0, 25, true) -- Aim
                DisableControlAction(0, 263, true) -- Melee Attack 1
                --DisableControlAction(0, 32, true) -- W
                --DisableControlAction(0, 34, true) -- A
                --DisableControlAction(0, 31, true) -- S
                --DisableControlAction(0, 30, true) -- D
    
                DisableControlAction(0, 45, true) -- Reload
                DisableControlAction(0, 22, true) -- Jump
                DisableControlAction(0, 44, true) -- Cover
                DisableControlAction(0, 37, true) -- Select Weapon
                DisableControlAction(0, 23, true) -- Also 'enter'?
    
                DisableControlAction(0, 288,  true) -- Disable phone
                DisableControlAction(0, 289, true) -- Inventory
                DisableControlAction(0, 170, true) -- Animations
                DisableControlAction(0, 167, true) -- Job
    
                DisableControlAction(0, 0, true) -- Disable changing view
                DisableControlAction(0, 26, true) -- Disable looking behind
                DisableControlAction(0, 73, true) -- Disable clearing animation
                --DisableControlAction(2, 199, true) -- Disable pause screen
    
                DisableControlAction(0, 59, true) -- Disable steering in vehicle
                DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
                DisableControlAction(0, 72, true) -- Disable reversing in vehicle
    
                DisableControlAction(2, 36, true) -- Disable going stealth
    
                DisableControlAction(0, 47, true)  -- Disable weapon
                DisableControlAction(0, 264, true) -- Disable melee
                DisableControlAction(0, 257, true) -- Disable melee
                DisableControlAction(0, 140, true) -- Disable melee
                DisableControlAction(0, 141, true) -- Disable melee
                DisableControlAction(0, 142, true) -- Disable melee
                DisableControlAction(0, 143, true) -- Disable melee
                DisableControlAction(0, 75, true)  -- Disable exit vehicle
                DisableControlAction(27, 75, true) -- Disable exit vehicle
    
                if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
                    JOB.Loadanimdict('mp_arrest_paired')
                    TaskPlayAnim(PlayerPedId(), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
                end
            else
                break
            end
        end
    end)
	
end

RegisterNetEvent('jobcreatorv2:client:getuncuffed', function(playerheading, playercoords, playerlocation)
    LocalPlayer.state.handcuffed = true
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(PlayerPedId(), x, y, z - 1)
	SetEntityHeading(PlayerPedId(), playerheading)
	Wait(250)
	JOB.Loadanimdict('mp_arresting')
	TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Wait(5500)
	JOB.Variables.Handcuff = false
	ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('jobcreatorv2:client:douncuffing', function()
	Wait(250)
	JOB.Loadanimdict('mp_arresting')
	TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Wait(5500)
	ClearPedTasks(PlayerPedId())
end)

local drag = false 
local dragUser

RegisterNetEvent('jobcreatorv2:client:drag', function(playerWhoDrag)
    if JOB.Variables.Handcuff then
        drag = not drag
        dragUser = playerWhoDrag
        JOB.HandleDrag()
	end
end)

---comment
JOB.HandleDrag = function ()
    CreateThread(function ()
        local wasDragged
        while true do
            Wait(0)
            local playerPed = PlayerPedId()
    
            if JOB.Variables.Handcuff and drag then
                local targetPed = GetPlayerPed(GetPlayerFromServerId(dragUser))
    
                if DoesEntityExist(targetPed) and IsPedOnFoot(targetPed) and not IsPedDeadOrDying(targetPed, true) then
                    if not wasDragged then
                        AttachEntityToEntity(playerPed, targetPed, 11816, 0.10, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                        wasDragged = true
                    else
                        Wait(1000)
                    end
                else
                    wasDragged = false
                    drag = false
                    DetachEntity(playerPed, true, false)
                end
            elseif wasDragged then
                wasDragged = false
                DetachEntity(playerPed, true, false)
            else
                break
            end
        end
    end)

end

RegisterNetEvent('jobcreatorv2:client:putInVehicle', function()
	if JOB.Variables.Handcuff then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if IsAnyVehicleNearPoint(coords, 5.0) then
			local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

			if DoesEntityExist(vehicle) then
				local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

				for i=maxSeats - 1, 0, -1 do
					if IsVehicleSeatFree(vehicle, i) then
						freeSeat = i
						break
					end
				end

				if freeSeat then
					TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				end
			end
		end
	end
end)

RegisterNetEvent('jobcreatorv2:client:OutVehicle', function()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		TaskLeaveVehicle(playerPed, vehicle, 16)
        Wait(1000)
        JOB.Loadanimdict('mp_arresting')
        TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
	end
end)