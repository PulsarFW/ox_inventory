-- bridge: admin inventory commands using native FiveM RegisterCommand (no Chat component)

local function getTarget(source, sidArg)
    local sid
    if sidArg == 'me' then
        local player = exports['pulsar-base']:FetchSource(source)
        sid = player and player:GetData('Character') and player:GetData('Character'):GetData('SID')
    else
        sid = tonumber(sidArg)
    end
    if not sid then return nil, nil end
    local player = exports['pulsar-base']:FetchPlayerData('SID', sid)
    if not player then return nil, nil end
    return player:GetData('Source'), player:GetData('Character')
end

RegisterCommand('giveitem', function(source, args)
    local targetSource, char = getTarget(source, args[1])
    if not targetSource then
        TriggerClientEvent('HUD:Client:Notification', source, { type = 'error', message = 'Player not online', duration = 5000 })
        return
    end
    local itemName = args[2]
    local count = tonumber(args[3]) or 1
    if not itemName then return end
    local meta = BuildDefaultMeta(itemName, targetSource)
    exports['ox_inventory']:AddItem(targetSource, itemName, count, meta)
    TriggerClientEvent('HUD:Client:Notification', source, { type = 'success', message = ('Gave %dx %s to %s'):format(count, itemName, char:GetData('SID')), duration = 4000 })
end, true)

RegisterCommand('giveweapon', function(source, args)
    local targetSource, char = getTarget(source, args[1])
    if not targetSource then
        TriggerClientEvent('HUD:Client:Notification', source, { type = 'error', message = 'Player not online', duration = 5000 })
        return
    end
    local weapon = string.upper(args[2] or '')
    local ammo = tonumber(args[3]) or 0
    local scratched = args[4] == '1'
    if weapon == '' then return end
    exports['ox_inventory']:AddItem(targetSource, weapon, 1, { ammo = ammo, clip = 0, Scratched = scratched or nil })
    TriggerClientEvent('HUD:Client:Notification', source, { type = 'success', message = ('Gave %s to %s'):format(weapon, char:GetData('SID')), duration = 4000 })
end, true)

RegisterCommand('clearinventory', function(source, args)
    local targetSource, char = getTarget(source, args[1])
    if not targetSource then
        TriggerClientEvent('HUD:Client:Notification', source, { type = 'error', message = 'Player not online', duration = 5000 })
        return
    end
    exports['ox_inventory']:clearinventory(targetSource)
    TriggerClientEvent('HUD:Client:Notification', source, { type = 'success', message = ('Cleared inventory of %s'):format(char:GetData('SID')), duration = 4000 })
end, true)
