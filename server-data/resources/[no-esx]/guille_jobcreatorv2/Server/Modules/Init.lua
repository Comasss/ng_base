JOB.Thread(function ()

    Citizen.Await(JOB.Loaded)

    JOB.Execute("SELECT * FROM `guille_jobcreator`", {}, function (data)
        for k, v in pairs(data) do
            JOB.Jobs[v.name] = JOB.CreateJob(v.name, v.label, json.decode(v.ranks), json.decode(v.points), json.decode(v.data), json.decode(v.blips), json.decode(v.publicvehicles), json.decode(v.privatevehicles), json.decode(v.inventory), json.decode(v.wardrobe))
            JOB.Jobs[v.name].players = {}
            JOB.Jobs[v.name].fetchMembers()
            GlobalState[v.name.."-guille"] = JOB.Jobs[v.name]
            JOB.Print("INFO", ("Job loaded '%s'"):format(v.name))
        end
        GlobalState.JobsData = JOB.Jobs
    end)

    local Players = GetPlayers()
    
    for k, v in pairs(Players) do 
        Wait(50)
        GlobalState[v.."-jobplayer"] = nil
        JOB.Players[tonumber(v)] = JOB.CreatePlayer(tonumber(v), { })
        JOB.Execute("SELECT * FROM `guille_jobcreator_members` WHERE license = ?", {
            JOB.GetIdentifier(v)
        }, function (data)
            if data[1] then
                table.insert(JOB.Jobs[json.decode(data[1]['job1']).name].players, tonumber(v))
                JOB.Players[tonumber(v)] = JOB.CreatePlayer(tonumber(v), json.decode(data[1]['job1']))
                GlobalState[v.."-jobplayer"] = JOB.Players[tonumber(v)] 
                JOB.Players[tonumber(v)].triggerEvent("jobcreatorv2:client:initData")
            end
        end)
    end

end)