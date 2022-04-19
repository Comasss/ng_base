---comment
---@param name any
---@param label any
---@param ranks any
---@param points any
---@param options any
---@param blips any
---@param publicvehicles any
---@param privatevehicles any
---@return table
JOB.CreateJob = function(name, label, ranks, points, options, blips, publicvehicles, privatevehicles, inventory, wardrobe)
    local self = { }

    self.name = name or "None"
    self.label = label or "None"
    self.ranks = ranks or { }
    self.points = points or { }
    self.options = options or { }
    self.blips = blips or { }
    self.publicvehicles = publicvehicles or { }
    self.privatevehicles = privatevehicles or { }
    self.inventory = inventory or { }
    self.wardrobe = wardrobe or { }
    self.allmembers = { }

    ---comment
    ---@param newMarkers any
    ---@param cb any
    ---@return boolean or void
    self.updateMarkers = function (newMarkers, cb)
        self.points = newMarkers
        GlobalState[self.name.."-guille"] = JOB.Jobs[self.name]
        JOB.Print("INFO", ("Job updated '%s'"):format(self.name))
        GlobalState.JobsData = JOB.Jobs
        for k, v in pairs(JOB.Jobs[self.name].players) do 
            TriggerClientEvent("jobcreatorv2:client:initData", tonumber(v))
        end
        JOB.Execute("UPDATE guille_jobcreator SET points = ? WHERE name = ?", {
            json.encode(self.points),
            self.name
        })
        if cb then
            return cb(true)
        else
            return true
        end
    end

    ---comment
    ---@param newVehs any
    ---@param cb any
    ---@return any
    self.updatePublicVehs = function (newVehs, cb)
        self.publicvehicles = newVehs
        GlobalState[self.name.."-guille"] = JOB.Jobs[self.name]
        JOB.Print("INFO", ("Job updated '%s'"):format(self.name))
        GlobalState.JobsData = JOB.Jobs
        for k, v in pairs(JOB.Jobs[self.name].players) do 
            TriggerClientEvent("jobcreatorv2:client:initData", tonumber(v))
        end
        JOB.Execute("UPDATE guille_jobcreator SET publicvehicles = ? WHERE name = ?", {
            json.encode(self.publicvehicles),
            self.name
        })
        if cb then
            return cb(true)
        else
            return true
        end
    end

    ---comment
    ---@param newOptions any
    ---@param cb any
    ---@return any
    self.updateOptions = function (newOptions, cb)
        self.options = newOptions
        GlobalState[self.name.."-guille"] = JOB.Jobs[self.name]
        JOB.Print("INFO", ("Job updated '%s'"):format(self.name))
        GlobalState.JobsData = JOB.Jobs
        for k, v in pairs(JOB.Jobs[self.name].players) do 
            TriggerClientEvent("jobcreatorv2:client:initData", tonumber(v))
        end
        JOB.Execute("UPDATE guille_jobcreator SET data = ? WHERE name = ?", {
            json.encode(self.options),
            self.name
        })
        if cb then
            return cb(true)
        else
            return true
        end
    end

    ---comment
    ---@param type any
    ---@param name any
    ---@param count any
    ---@param label any
    ---@param cb any
    ---@return boolean
    self.addItemToInv = function(type, name, count, label, cb)
        local found = false
        if #self.inventory >= 1 then
            for k, v in pairs(self.inventory) do
                if v.type == "account" and type == "account" and name == v.name then
                    table.insert(self.inventory, {type = type, label = label, name = name, count = v.count + count})
                    table.remove(self.inventory, k)
                    found = true
                    break
                elseif v.type == "item" and type == "item" and name == v.name then
                    table.insert(self.inventory, {type = type, label = label, name = name, count = v.count + count})
                    table.remove(self.inventory, k)
                    found = true
                    break
                end
            end
            
        end
        if not found then
            table.insert(self.inventory, {type = type, label = label, name = name, count = count})
        end
        GlobalState[self.name.."-guille"] = JOB.Jobs[self.name]
        JOB.Execute("UPDATE guille_jobcreator SET inventory=? WHERE name = ?", {
            json.encode(self.inventory),
            self.name
        }, function(rows)
            if rows then
                if cb then
                    return cb(true)
                else
                    return true
                end
            end
        end)
        if cb then
            cb(false)
        else
            return false
        end
    end
    
    self.removeItemOfInv = function(type, name, count, cb)
        local found = false
        if #self.inventory >= 1 then
            for k, v in pairs(self.inventory) do
                if v.type == "account" and type == "account" then
                    if v.name == name then
                        if v.count >= 1 then
                            self.inventory[k]['count'] = v.count - count
                            if self.inventory[k]['count'] == 0 then
                                table.remove(self.inventory, k)
                            end
                            found = true
                            break
                        else
                            table.remove(self.inventory, k)
                            found = true
                            break
                        end

                    end
                elseif v.type == "item" and type == "item" then
                    if v.name == name then
                        if v.count == 0 then
                            table.remove(self.inventory, k)
                        end
                        if v.count > 1 then
                            self.inventory[k]['count'] = v.count - count
                            if self.inventory[k]['count'] == 0 then
                                table.remove(self.inventory, k)
                            end
                            found = true
                            break
                        else
                            table.remove(self.inventory, k)
                            found = true
                            break
                        end
                    end
                elseif v.type == "weapon" and type == "weapon" then
                    if v.name == name then
                        table.remove(self.inventory, k)
                        found = true
                        break
                    end
                end
            end
        end
        GlobalState[self.name.."-guille"] = JOB.Jobs[self.name]
        JOB.Execute("UPDATE guille_jobcreator SET inventory=? WHERE name = ?", {
            json.encode(self.inventory),
            self.name,
        }, function(rows)
            if rows then
                if cb then
                    return cb(true)
                else
                    return true
                end
            end
        end)
        if cb then
            cb(false)
        else
            return false
        end
    end

    self.fetchMembers = function ()
        self.allmembers = { }
        JOB.Execute("SELECT * FROM `guille_jobcreator_members` WHERE job1 LIKE '%"..self.name.."%'", {}, function (data)
            for k, v in pairs(data) do
                local ParsedData = json.decode(v.job1)
                table.insert(self.allmembers, { license = v.license, name = ParsedData.plyname, rank = ParsedData.rank, rankname = ParsedData.rankname })
            end
        end)
    end
    
    return self
    
end

