-- Server-side script
-- QBCore script to ban players attempting to teleport everyone to community service

QBCore = exports['qb-core']:GetCoreObject()

-- Event to handle teleportation attempts
RegisterNetEvent('attemptedTeleportAllToCommunityService')
AddEventHandler('attemptedTeleportAllToCommunityService', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local steamIdentifier = Player.PlayerData.steam
    local tokens = {}
    for i = 0, GetNumPlayerTokens(src) - 1 do
        table.insert(tokens, GetPlayerToken(src, i))
    end

    if not steamIdentifier then
        print("[ERROR] Steam identifier not found for player " .. GetPlayerName(src))
        return
    end

    local reason = "Attempting to teleport all players to community service"

    -- Insert ban record into the database
    local query = 'INSERT INTO `bans` (`tokens`, `reason`, `steamName`, `time`) VALUES (?, ?, ?, ?)'
    local params = {json.encode(tokens), reason, GetPlayerName(src), os.date("%Y-%m-%d %H:%M:%S")}

    exports.oxmysql:execute(query, params, function(affectedRows)
        if affectedRows > 0 then
            DropPlayer(src, '⚠️ You have been banned from the server.\nReason: ' .. reason)
            print(('[^2INFO^7] Player ^5%s^7 banned for "%s"'):format(GetPlayerName(src), reason))
        else
            print("[ERROR] Failed to insert ban record for player " .. GetPlayerName(src))
        end
    end)
end)

-- Command to test the banning script (for admin use)
QBCore.Commands.Add('testban', 'Test the ban script', {}, false, function(source, args)
    TriggerEvent('attemptedTeleportAllToCommunityService')
end, 'admin')

-- Example of how the event might be triggered (replace this with actual detection logic)
-- This is a placeholder and should be replaced with actual detection of teleport attempts
AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
    local src = source
    TriggerClientEvent('example:triggerTeleportAttempt', src)
end)
