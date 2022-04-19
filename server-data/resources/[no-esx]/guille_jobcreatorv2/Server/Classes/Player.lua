---comment
---@param src any
---@param jobdata any
---@return table
JOB.CreatePlayer = function(src, jobdata)

    local self = { }

    self.src = src or 0
    self.jobdata = jobdata or { }

    ---comment
    ---@param name any
    ---@param ... any
    ---@return any
    self.triggerEvent = function (name, ...)
        return TriggerClientEvent(name, self.src, ...)
    end

    return self

end