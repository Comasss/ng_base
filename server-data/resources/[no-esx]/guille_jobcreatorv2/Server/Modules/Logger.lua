---comment
---@param type any
---@param message any
JOB.Print = function(type, message)
    Citizen.Trace('^4['..os.date('%c')..'] ^2[guille_jobcreatorv2] ['..type..'] ^7'..tostring(message)..'\n')
end