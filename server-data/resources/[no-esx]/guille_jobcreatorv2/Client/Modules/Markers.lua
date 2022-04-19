---comment
JOB.HandleAll = function ()
    JOB.Variables.IsChanging = true
    CreateThread(function ()
        Wait(10)
        JOB.Variables.IsChanging = false
        local OwnData = GlobalState[JOB.Variables.PlayerId.."-jobplayer"]
        JOB.Variables.OwnJob = OwnData.jobdata
        local JobData = GlobalState[OwnData.jobdata.name.."-guille"]
        print(("Your job is %s"):format(OwnData.jobdata.name))
        while true do
            local PlayerPed = PlayerPedId()
            local PlayerCoords = GetEntityCoords(PlayerPed)
            local Sleep = 1000
            for k, v in pairs(JobData.points) do
                local MarkerCoords = vec3(tonumber(v.x), tonumber(v.y), tonumber(v.z) - 0.93)
                local Distance = #(MarkerCoords - PlayerCoords)
                if Distance < 20 then
                    Sleep = 0
                    DrawMarker(1, MarkerCoords, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 233, 0, 255, 0, 0, 0, 0, 0, 0, 0)
                    if Distance < 1.5 then
                        JOB.Markers[v.selected](MarkerCoords)
                    end
                end
            end

            if JOB.Variables.IsChanging then
                break
            end
            Wait(Sleep)
        end
    end)
end