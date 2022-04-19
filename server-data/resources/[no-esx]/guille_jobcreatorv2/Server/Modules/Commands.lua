JOB.RegisterCommand("managejobs", function (source, args)
    JOB.GetPlayer(source, function(ply)
        ply.triggerEvent("jobcreatorv2:client:openUi")
    end)
end)

JOB.RegisterCommand("setguillejob", function (source, args)
    local src  = args[1]
    local job <const>  = args[2]
    local rank <const> = args[3]
    if src == "me" then
        src = source
    end
    JOB.AddJob(src, job, rank)
end)

JOB.Loaded:resolve()