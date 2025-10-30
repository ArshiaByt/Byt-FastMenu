local ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback(Config.Events.Server.GetGangCount, function(source, cb, gangName)
    local count = 0
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return cb(0) end

    for _, playerId in pairs(ESX.GetPlayers()) do
        local xTarget = ESX.GetPlayerFromId(playerId)
        if xTarget and xTarget.gang and xPlayer.gang and xTarget.gang.name == xPlayer.gang.name then
            count = count + 1
        end
    end
    cb(count)
end)
