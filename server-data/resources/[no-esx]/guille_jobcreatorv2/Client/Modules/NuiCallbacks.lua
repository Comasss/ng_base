RegisterNUICallback("getCoords", function (data, cb)
    local Ped = PlayerPedId()
    local Coords = GetEntityCoords(Ped)
    cb(json.encode(Coords))
end)

RegisterNUICallback("exit", function (data, cb)
    SetNuiFocus(false, false)
    JOB.Variables['IsOpen'] = true
    cb(json.encode("ok"))
end)

RegisterNUICallback("updateInfo", function (data, cb)
    TriggerServerEvent("jobcreatorv2:server:updateValue", data.type, data.data, data.job)
    cb(json.encode("ok"))
end)