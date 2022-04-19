---comment
JOB.RefreshData = function ()
    local JobsData = GlobalState.JobsData
    SendNUIMessage({ type = "loadData", JobsData = JobsData })
end