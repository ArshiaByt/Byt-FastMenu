local ESX = exports['es_extended']:getSharedObject()
local menuOpen, lastOpen = false, 0

-- Wait until ESX player data is ready
CreateThread(function()
    while not ESX.PlayerData or not ESX.PlayerData.gang do
        Wait(200)
        ESX.PlayerData = ESX.GetPlayerData()
    end
end)

-- Update player data
RegisterNetEvent('esx:setGang', function(gang) ESX.PlayerData.gang = gang end)
RegisterNetEvent('esx:setJob', function(job) ESX.PlayerData.job = job end)
RegisterNetEvent("es:lastAnnounceUpdate", function(msg) ESX.PlayerData.announce = msg end)
RegisterNetEvent("esx_tasks:CountTasks", function(task) ESX.PlayerData.tasks = task end)

-- Command / Key to open menu
RegisterCommand('openfastmenu', function()
    if menuOpen or (GetGameTimer() - lastOpen < Config.MenuCooldown) then return end
    menuOpen = true
    lastOpen = GetGameTimer()

    ESX.TriggerServerCallback(Config.Events.Server.GetGangCount, function(count)
		SendNUIMessage({
			action = 'show',
			data = {
				announce = { Level = 0 },
				achievements = false,
				hasPremium = ESX.PlayerData.group,
				VIPType = string.upper(ESX.PlayerData.group or "NONE"),
				Job = firstToUpper(ESX.PlayerData.job.name or "NONE"),
				Gang = firstToUpper(ESX.PlayerData.gang.name or "NONE"),
				gXP = count,
				announce = ESX.PlayerData.announce or Config.DefaultAnnouncement,
				tasks = ESX.PlayerData.tasks or 0,
				buttons = Config.Events.Buttons,
				serverIcon = Config.ServerIcon or ""
			}
		})
        SetNuiFocus(true, true)
    end)
end, false)

RegisterKeyMapping('openfastmenu', 'Open FastMenu', 'keyboard', Config.OpenKey)

-- NUI Sound Handler
RegisterNUICallback("playSound", function(data, cb)
    local sound = Config.Sounds[data.action]
    if sound then
        PlaySoundFrontend(-1, sound.name, sound.set, true)
    end
    cb('ok')
end)

-- Execute Action
RegisterNUICallback('execute', function(data, cb)
    if not data or not data.action then return end
    local actionType, act = data.actionType, data.action
    closeFastMenu()
    Wait(200)
    if not isAllowed(act) then return end

    if actionType == 'command' then
        ExecuteCommand(act)
    elseif actionType == 'client_event' then
        TriggerEvent(act)
    end
    cb('ok')
end)

-- NUI Callbacks
RegisterNUICallback('closeNUI', function(_, cb)
    closeFastMenu()
    cb('ok')
end)

function closeFastMenu()
    if menuOpen then
        SetNuiFocus(false, false)
        SendNUIMessage({ action = 'hide' })
        menuOpen = false
    end
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function isAllowed(action)
    for _, v in pairs(Config.AllowedActions) do
        if v == action then return true end
    end
    return false
end
